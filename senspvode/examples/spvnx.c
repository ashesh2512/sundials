/************************************************************************
 *                                                                      *
 * File:        spvnx.c                                                 *
 * Programmers: Steven L. Lee and Alan C. Hindmarsh @ LLNL              *
 * Version of:  25 August 2000                                          *
 *                                                                      *
 *----------------------------------------------------------------------*
 * Example problem, with sensitivity analysis                           *
 * The following is a simple example problem, with the program for its  *
 * solution by SensPVODE.  The problem is the semi-discrete form of the *
 * advection-diffusion equation in 1-D:                                 *
 *   du/dt = d^2 u / dx^2 + .5 du/dx                                    *
 * on the interval 0 <= x <= 2, and the time interval 0 <= t <= 5.      *
 * Homogeneous Dirichlet boundary conditions are posed, and the         *
 * initial condition is                                                 *
 *   u(x,y,t=0) = x(2-x)exp(2x) .                                       *
 * The PDE is discretized on a uniform grid of size MX+2 with           *
 * central differencing, and with boundary values eliminated,           *
 * leaving an ODE system of size Ny = MX.                               *
 * This program solves the problem with the option for nonstiff systems:*
 * ADAMS method and functional iteration.                               *
 * It uses scalar relative and absolute tolerances.                     *
 * Solution and sensitivity output is printed at t = .5, 1.0, ..., 5.   *
 * Run statistics (optional outputs) are printed at the end.            *
 *                                                                      *
 * This version uses MPI for user routines, and the SensPVODE solver.   *
 * Execute with Number of Processors = N,  with 1 <= N <= MX.           *
 ************************************************************************/

#include <stdio.h>
#include <math.h>

/* CVODE header files with a description of contents used here */

#include "llnltyps.h" /* definitions of real, integer, FALSE, DOUBLE       */
#include "cvode.h"    /* prototypes for CVodeMalloc, CVode, and CVodeFree, */
                      /* constants OPT_SIZE, ADAMS, FUNCTIONAL, SS,        */
                      /* SUCCESS, NST, NFE, NNI, NCFN, NETF                */
#include "nvector.h"  /* definitions of type N_Vector and vector macros,   */
                      /* prototypes for N_Vector functions                 */
#include "mpi.h"      /* for MPI constants and types                       */
#include "sensitivity.h" /* sensitivity data types and prototypes          */


/* Problem Constants */

#define XMAX       2.0          /* domain boundary           */
#define MX         10           /* mesh dimension            */
#define Ny         MX           /* number of equations       */
#define Np         2            /* number of parameters      */
#define Ns         2            /* number of sensitivities   */
#define ATOL       1.e-5        /* scalar absolute tolerance */
#define T0         0.0          /* initial time              */
#define T1         0.5          /* first output time         */
#define DTOUT      0.5          /* output time increment     */
#define NOUT       10           /* number of output times    */

#define ZERO       RCONST(0.0)    /* real 0.0 */
#define HALF       RCONST(0.5)    /* real 0.0 */
#define ONE        RCONST(1.0)    /* real 1.0 */
#define TWO        RCONST(2.0)    /* real 2.0 */

/* Type : UserData 
   contains grid constants, parallel machine parameters, work array. */

typedef struct {
  real *p;
  real dx;
  integer npes, my_pe;
  MPI_Comm comm;
  real z[100];
} *UserData;


/* Private Helper Functions */

static void SetIC(N_Vector u, real dx, integer my_length, integer my_base);

static void PrintFinalStats(long int iopt[]);

/* Functions Called by the CVODE Solver */

static void f(integer N, real t, N_Vector u, N_Vector udot, void *f_data);


/***************************** Main Program ******************************/

main(int argc, char *argv[])
{
  real ropt[OPT_SIZE], dx, reltol, abstol, t, tout, umax;
  long int iopt[OPT_SIZE];
  N_Vector u;
  UserData data;
  void *cvode_mem;
  int iout, flag, i;
  integer local_N, my_pe, npes, nperpe, nrem, my_base;
  machEnvType machEnv;
  MPI_Comm comm;
  N_Vector *usub;
  integer Ntotal;
  real *pbar, rhomax;

  Ntotal = (1+Ns)*Ny;

  /* Get processor number, total number of pe's, and my_pe. */
  MPI_Init(&argc, &argv);
  comm = MPI_COMM_WORLD;
  MPI_Comm_size(comm, &npes);
  MPI_Comm_rank(comm, &my_pe);

  /* Set local vector length. */
  nperpe = Ny/npes;
  nrem = Ny - npes*nperpe;
  local_N = (my_pe < nrem) ? nperpe+1 : nperpe;
  my_base = (my_pe < nrem) ? my_pe*local_N : my_pe*nperpe + nrem;

  /* Allocate data memory */
  data = (UserData) malloc(sizeof *data);  

  data->comm = comm;
  data->npes = npes;
  data->my_pe = my_pe;

  /* Set machEnv block. */
  machEnv = PVecInitMPI(comm, local_N, Ny, &argc, &argv);
  if (machEnv == NULL) return(1);

  /* Set grid coefficient in data */
  dx = data->dx = XMAX/((real)(MX+1));

  /* Store nominal parameter values in p */
  data->p = (real *) malloc(Np * sizeof(real));
  data->p[0] = 1.0;
  data->p[1] = 0.5;

  /* Scaling factor for each sensitivity equation */
  pbar = (real *) malloc(Np * sizeof(real));
  pbar[0] = 1.0;
  pbar[1] = 0.5;

  /* Allocate u vector */
  u = N_VNew(Ntotal, machEnv); 

  /* Initialize all state variables */
  usub = N_VSUB(u);
  SetIC(usub[0], dx, local_N, my_base);  

  /* Set the scalar error tolerances */
  reltol = 0.0;
  abstol = ATOL;

  /* Initialize all sensitivity variables */
  for (i = 1; i <= Ns; i++) {
    N_VConst(0.0, usub[i]);
  }

  /* rhomax selects the finite difference formula for estimating */
  /* scaled sensitivity vectors.                                 */
  /* rhomax = 0.0 is the default value.                          */
  rhomax = ZERO;

  /* Call SensCVodeMalloc to initialize CVODE: 

     Ny      is the number of ODEs in u' = f(t,u,p)
     Ns      is the number of sensitivity vectors to compute
     Ntotal  is the problem size = total number of ODEs = Ny*(Ns+1)
     f       is the user's right hand side function in u' = f(t,u,p)
     T0      is the initial time
     u       is the initial dependent variable vector of length Ntotal
     ADAMS   specifies the Adams Method
     FUNCTIONAL  specifies functional iteration
     SS      specifies scalar relative and absolute tolerances
     &reltol and &abstol are pointers to the scalar tolerances
     data    is the pointer to the user-defined block of coefficients
     FALSE   indicates there are no optional inputs in iopt and ropt
     iopt and ropt arrays communicate optional integer and real input/output
     data->p is a pointer to the parameter values
     pbar    is a pointer to the sensitivity scaling factors
     rhomax  selects the formula for estimating scaled sensitivity derivatives

     A pointer to CVODE problem memory is returned and stored in cvode_mem.  */

  cvode_mem = SensCVodeMalloc(Ny, Ns, Ntotal, f, T0, u, ADAMS, FUNCTIONAL, 
			      SS, &reltol, &abstol, data, NULL, FALSE, iopt, 
			      ropt, machEnv, data->p, pbar, rhomax);

  if (cvode_mem == NULL) { printf("SensCVodeMalloc failed.\n"); return(1); }

  if (my_pe == 0) {
    printf("\n 1-D advection-diffusion equation, mesh size =%3d \n", MX);
    printf(" Number of sensitivity vectors: Ns  = %3d \n", Ns);
    printf(" Number of PEs = %3d \n\n",npes); 
  }

  umax = N_VMaxNorm(usub[0]);

  if (my_pe == 0) 
    printf("At t = %4.2f    max.norm(u) =%14.6e \n", T0, umax);
  for (i = 1; i <= Ns; i++) {
    umax = N_VMaxNorm(usub[i]);
    if (my_pe == 0) {
      printf("sensitivity s_%d:  max.norm =%14.6e \n", i, umax/pbar[i-1]);
      if (i == Ns) printf("\n");
    }
  }

  /* In loop over output points, call CVode, print results, test for error */

  for (iout=1, tout=T1; iout <= NOUT; iout++, tout += DTOUT) {
    flag = CVode(cvode_mem, tout, u, &t, NORMAL);
    umax = N_VMaxNorm(usub[0]);
    if (my_pe == 0) {
      printf("At t = %4.2f    max.norm(u) =%14.6e   nst =%4d \n", 
            t,umax,iopt[NST]);
    }
    for (i = 1; i <= Ns; i++) {
      umax = N_VMaxNorm(usub[i]);
      if (my_pe == 0) {
	printf("sensitivity s_%d:  max.norm =%14.6e \n", i, umax/pbar[i-1]);
	if (i == Ns) printf("\n");
      }
    }
    if (flag != SUCCESS) { 
      if (my_pe == 0) printf("CVode failed, flag=%d.\n", flag); 
      break; 
    }
  }

  if (my_pe == 0) 
    PrintFinalStats(iopt);     /* Print some final statistics   */

  SensCVodeFree(cvode_mem);    /* Free the CVODE problem memory */

  N_VFree(u);                  /* Free the u vector */
  free(pbar);                  /* Free the sensitivity scaling factors */
  free(data->p);               /* Free the parameter values */
  free(data);                  /* Free block of UserData */

  PVecFreeMPI(machEnv);
  MPI_Finalize();
  return(0);
}


/************************ Private Helper Functions ***********************/

/* Set initial conditions in u vector */

static void SetIC(N_Vector u, real dx, integer my_length, integer my_base)
{
  int i;
  integer iglobal;
  real x;
  real *udata;

  /* Set pointer to data array and get local length of u. */
  udata = N_VDATA(u);
  my_length = N_VLOCLENGTH(u);

  /* Load initial profile into u vector */
  for (i=1; i<=my_length; i++) {
    iglobal = my_base + i;
    x = iglobal*dx;
    udata[i-1] = x*(XMAX - x)*exp(2.0*x);
  }  
}


/* Print some final statistics located in the iopt array */

static void PrintFinalStats(long int iopt[])
{
  printf("\nFinal Statistics.. \n\n");
  printf("nst = %-6ld  nfe  = %-6ld  ", iopt[NST], iopt[NFE]);
  printf("nni = %-6ld  ncfn = %-6ld  netf = %ld\n \n",
	 iopt[NNI], iopt[NCFN], iopt[NETF]);
}


/***************** Function Called by the CVODE Solver ******************/

/* f routine. Compute f(t,u). */

static void f(integer N, real t, N_Vector u, N_Vector udot, void *f_data)
{
  real ui, ult, urt, hordc, horac, hdiff, hadv, dx;
  real *udata, *dudata, *z;
  int i, j;
  int npes, my_pe, my_length, my_pe_m1, my_pe_p1, last_pe, my_last;
  UserData data;
  MPI_Status status;
  MPI_Comm comm;

  udata = N_VDATA(u);
  dudata = N_VDATA(udot);

  /* Extract needed problem constants from data */
  data = (UserData) f_data;
  dx = data->dx;
  hordc = data->p[0]/(dx*dx);
  horac = data->p[1]/(2.0*dx);

  /* Extract parameters for parallel computation. */
  comm = data->comm;
  npes = data->npes;           /* Number of processes. */ 
  my_pe = data->my_pe;         /* Current process number. */
  my_length = N_VLOCLENGTH(u); /* Number of local elements of u. */ 
  z = data->z;

  /* Compute related parameters. */
  my_pe_m1 = my_pe - 1;
  my_pe_p1 = my_pe + 1;
  last_pe = npes - 1;
  my_last = my_length - 1;

  /* Store local segment of u in the working array z. */
   for (i = 1; i <= my_length; i++)
     z[i] = udata[i - 1];

  /* Pass needed data to processes before and after current process. */
   if (my_pe != 0)
     MPI_Send(&z[1], 1, PVEC_REAL_MPI_TYPE, my_pe_m1, 0, comm);
   if (my_pe != last_pe)
     MPI_Send(&z[my_length], 1, PVEC_REAL_MPI_TYPE, my_pe_p1, 0, comm);   

  /* Receive needed data from processes before and after current process. */
   if (my_pe != 0)
     MPI_Recv(&z[0], 1, PVEC_REAL_MPI_TYPE, my_pe_m1, 0, comm, &status);
   else z[0] = 0.0;
   if (my_pe != last_pe)
     MPI_Recv(&z[my_length+1], 1, PVEC_REAL_MPI_TYPE, my_pe_p1, 0, comm,
              &status);   
   else z[my_length + 1] = 0.0;

  /* Loop over all grid points in current process. */
  for (i=1; i<=my_length; i++) {

    /* Extract u at x_i and two neighboring points */
    ui = z[i];
    ult = z[i-1];
    urt = z[i+1];

    /* Set diffusion and advection terms and load into udot */
    hdiff = hordc*(ult - 2.0*ui + urt);
    hadv = horac*(urt - ult);
    dudata[i-1] = hdiff + hadv;
  }
}
