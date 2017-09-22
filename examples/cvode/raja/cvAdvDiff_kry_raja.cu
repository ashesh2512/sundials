/*
 * -----------------------------------------------------------------
 * $Revision: 4272 $
 * $Date: 2014-12-02 11:19:41 -0800 (Tue, 02 Dec 2014) $
 * -----------------------------------------------------------------
 * Programmer(s): Slaven Peles @ LLNL
 * -----------------------------------------------------------------
 * Acknowledgements: This example is based on cvAdvDiff_bnd 
 *                   example by Scott D. Cohen, Alan C. 
 *                   Hindmarsh and Radu Serban @ LLNL
 * -----------------------------------------------------------------
 * Example problem:
 *
 * The following is a simple example problem with a banded Jacobian,
 * with the program for its solution by CVODE.
 * The problem is the semi-discrete form of the advection-diffusion
 * equation in 2-D:
 *   du/dt = d^2 u / dx^2 + .5 du/dx + d^2 u / dy^2
 * on the rectangle 0 <= x <= 2, 0 <= y <= 1, and the time
 * interval 0 <= t <= 1. Homogeneous Dirichlet boundary conditions
 * are posed, and the initial condition is
 *   u(x,y,t=0) = x(2-x)y(1-y)exp(5xy).
 * The PDE is discretized on a uniform MX+2 by MY+2 grid with
 * central differencing, and with boundary values eliminated,
 * leaving an ODE system of size NEQ = MX*MY.
 * This program solves the problem with the BDF method, Newton
 * iteration with the CVBAND band linear solver, and a user-supplied
 * Jacobian routine.
 * It uses scalar relative and absolute tolerances.
 * Output is printed at t = .1, .2, ..., 1.
 * Run statistics (optional outputs) are printed at the end.
 * -----------------------------------------------------------------
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <cvode/cvode.h>
#include <cvode/cvode_spgmr.h>
#include <nvector/nvector_raja.h>
#include <nvector/raja/Vector.hpp>
#include <sundials/sundials_types.h>
#include <sundials/sundials_math.h>

#include <RAJA/RAJA.hpp>

#define SUNDIALS_HAVE_POSIX_TIMERS
#define _POSIX_TIMERS

#if defined( SUNDIALS_HAVE_POSIX_TIMERS) && defined(_POSIX_TIMERS)
#include <time.h>
#include <unistd.h>
#endif

//#include <cvode/cvode.h>             /* prototypes for CVODE fcts., consts. */
////#include <cvode/cvode_band.h>        /* prototype for CVBand */
//#include <cvode/cvode_spgmr.h>       /* prototypes & constants for CVSPGMR */
////#include <sundials/sundials_band.h>  /* definitions of type DlsMat and macros */
//#include <sundials/sundials_types.h> /* definition of type realtype */
//#include <sundials/sundials_math.h>  /* definition of ABS and EXP */
//
//#include <nvector/nvector_raja.h>

/* Problem Constants */

#define XMAX  RCONST(2.0)    /* domain boundaries         */
#define YMAX  RCONST(1.0)
#define MX    10             /* mesh dimensions           */
#define MY    5
#define NEQ   MX*MY          /* number of equations       */
#define ATOL  RCONST(1.0e-5) /* scalar absolute tolerance */
#define T0    RCONST(0.0)    /* initial time              */
#define T1    RCONST(0.1)    /* first output time         */
#define DTOUT RCONST(0.1)    /* output time increment     */
#define NOUT  10             /* number of output times    */

#define ZERO RCONST(0.0)
#define HALF RCONST(0.5)
#define ONE  RCONST(1.0)
#define TWO  RCONST(2.0)
#define FIVE RCONST(5.0)


/* Type : UserData (contains grid constants) */

typedef struct {
  sunindextype neq;
  realtype dx, dy;
  realtype hdcoef, hacoef, vdcoef;
} *UserData;

/* Private Helper Functions */
static UserData SetUserData(int argc, char** argv);
static void SetIC(N_Vector u, UserData data);
static void PrintHeader(realtype reltol, realtype abstol, realtype umax);
static void PrintOutput(realtype t, realtype umax, long int nst);
static void PrintFinalStats(void *cvode_mem);

/* Private function to check function return values */

static int check_flag(void *flagvalue, const char *funcname, int opt);

/* Functions Called by the Solver */

static int f(realtype t, N_Vector u, N_Vector udot, void *user_data);
static int jtv(N_Vector v, N_Vector Jv, realtype t,
               N_Vector u, N_Vector fu,
               void *user_data, N_Vector tmp);

/*
 *-------------------------------
 * Main Program
 *-------------------------------
 */

int main(int argc, char** argv)
{
  realtype dx, dy, reltol, abstol, t, tout, umax;
  N_Vector u;
  UserData data;
  void *cvode_mem;
  int iout, flag;
  long int nst;

  u = NULL;
  data = NULL;
  cvode_mem = NULL;

  /* Create a CUDA vector */

  u = N_VNew_Raja(NEQ);  /* Allocate u vector */
  if(check_flag((void*)u, "N_VNew_Serial", 0)) return(1);

  reltol = ZERO;  /* Set the tolerances */
  abstol = ATOL;

//  data = (UserData) malloc(sizeof *data);  /* Allocate data memory */
  data = SetUserData(argc, argv);
  if(check_flag((void *)data, "malloc", 2)) return(1);
//  data->dx = XMAX/(MX+1);  /* Set grid coefficients in data */
//  data->dy = YMAX/(MY+1);
//  data->hdcoef = ONE/(data->dx*data->dx);
//  data->hacoef = HALF/(TWO*data->dx);
//  data->vdcoef = ONE/(data->dy*data->dy);

  SetIC(u, data);  /* Initialize u vector */

  /* Call CVodeCreate to create the solver memory and specify the 
   * Backward Differentiation Formula and the use of a Newton iteration */
  cvode_mem = CVodeCreate(CV_BDF, CV_NEWTON);
  if(check_flag((void *)cvode_mem, "CVodeCreate", 0)) return(1);

  /* Call CVodeInit to initialize the integrator memory and specify the
   * user's right hand side function in u'=f(t,u), the initial time T0, and
   * the initial dependent variable vector u. */
  flag = CVodeInit(cvode_mem, f, T0, u);
  if(check_flag(&flag, "CVodeInit", 1)) return(1);

  /* Call CVodeSStolerances to specify the scalar relative tolerance
   * and scalar absolute tolerance */
  flag = CVodeSStolerances(cvode_mem, reltol, abstol);
  if (check_flag(&flag, "CVodeSStolerances", 1)) return(1);

  /* Set the pointer to user-defined data */
  flag = CVodeSetUserData(cvode_mem, data);
  if(check_flag(&flag, "CVodeSetUserData", 1)) return(1);

  /* Call CVSpgmr to specify the linear solver CVSPGMR 
   * without preconditioning and the maximum Krylov dimension maxl */
  flag = CVSpgmr(cvode_mem, PREC_NONE, 0);
  if(check_flag(&flag, "CVSpgmr", 1)) return(1);

  /* set the JAcobian-times-vector function */
  flag = CVSpilsSetJacTimesVecFn(cvode_mem, jtv);
  if(check_flag(&flag, "CVSpilsSetJacTimesVecFn", 1)) return(1);

  /* In loop over output points: call CVode, print results, test for errors */

  umax = N_VMaxNorm(u);
  PrintHeader(reltol, abstol, umax);
  for(iout=1, tout=T1; iout <= NOUT; iout++, tout += DTOUT) {
    flag = CVode(cvode_mem, tout, u, &t, CV_NORMAL);
    if(check_flag(&flag, "CVode", 1)) break;
    umax = N_VMaxNorm(u);
    flag = CVodeGetNumSteps(cvode_mem, &nst);
    check_flag(&flag, "CVodeGetNumSteps", 1);
    PrintOutput(t, umax, nst);
  }

  PrintFinalStats(cvode_mem);  /* Print some final statistics   */

  N_VDestroy(u);          /* Free the u vector */
  CVodeFree(&cvode_mem);  /* Free the integrator memory */
  free(data);             /* Free the user data */

  return(0);
}

/*
 *-------------------------------
 * Functions called by the solver
 *-------------------------------
 */

UserData SetUserData(int argc, char *argv[])
{
  const int maxthreads = 256;

  /* Allocate user data structure */
  UserData ud = (UserData) malloc(sizeof *ud);
  if(check_flag((void*) ud, "AllocUserData", 2)) return(NULL);

  ud->dx = XMAX/(MX+1);  /* Set grid coefficients in data */
  ud->dy = YMAX/(MY+1);
  ud->hdcoef = ONE/(ud->dx*ud->dx);
  ud->hacoef = HALF/(TWO*ud->dx);
  ud->vdcoef = ONE/(ud->dy*ud->dy);

//  ud->Nx = dimX + 1;
//  ud->Ny = dimY + 1;
//  ud->NEQ = ud->Nx * ud->Ny;
//
//  /* Set thread partitioning for GPU execution */
//  ud->block = maxthreads;
//  ud->grid  = (ud->NEQ + maxthreads - 1) / maxthreads;
//
//  /* Compute cell sizes */
//  ud->hx = 1.0/((realtype) dimX);
//  ud->hy = 1.0/((realtype) dimY);
//
//  /* Compute diffusion coefficients */
//  ud->hordc = diffusionConst/(ud->hx * ud->hx);
//  ud->verdc = diffusionConst/(ud->hy * ud->hy);
//
//  /* Compute advection coefficient */
//  ud->horac = advectionConst/(2.0 * ud->hx);
//  ud->verac = advectionConst/(2.0 * ud->hy);
//
//  /* Set reaction coefficient */
//  ud->reacc = reactionConst;

  return ud;
}


/* f routine. Compute f(t,u). */

static int f(realtype t, N_Vector u, N_Vector udot, void *user_data)
{
  realtype hordc, horac, verdc;
  UserData data;

  sunindextype zero = 0;
  sunindextype neq = NEQ;
//  int maxthreads = 256;


  const realtype *udata = sunrajavec::extract<realtype, sunindextype>(u)->device();
  realtype *dudata    = sunrajavec::extract<realtype, sunindextype>(udot)->device();

  /* Extract needed constants from data */

  data = (UserData) user_data;
  hordc = data->hdcoef;
  horac = data->hacoef;
  verdc = data->vdcoef;

  RAJA::forall<RAJA::cuda_exec<256> >(zero, neq, [=] __device__(sunindextype index) {
    sunindextype i = index/MY;
    sunindextype j = index%MY;

    realtype uab = udata[index];

    realtype udn = (j == 0)    ? ZERO : udata[index - 1];
    realtype uup = (j == MY-1) ? ZERO : udata[index + 1];
    realtype ult = (i == 0)    ? ZERO : udata[index - MY];
    realtype urt = (i == MX-1) ? ZERO : udata[index + MY];

    /* Set diffusion and advection terms and load into udot */

    realtype hdiff = hordc*(ult -TWO*uab + urt);
    realtype hadv  = horac*(urt - ult);
    realtype vdiff = verdc*(udn -TWO*uab + uup);

    dudata[index] = hdiff + hadv + vdiff;
  });

//  if (tid < MX*MY) {
//    i = tid/MY;
//    j = tid%MY;
//
//    uij = u[tid];
//    udn = (j ==    0) ? ZERO : u[tid - 1];
//    uup = (j == MY-1) ? ZERO : u[tid + 1];
//    ult = (i ==    0) ? ZERO : u[tid - MY];
//    urt = (i == MX-1) ? ZERO : u[tid + MY];
//
//    /* Set diffusion and advection terms and load into udot */
//
//    hdiff = hordc*(ult - TWO*uij + urt);
//    hadv  = horac*(urt - ult);
//    vdiff = verdc*(uup - TWO*uij + udn);
//    udot[tid] = hdiff + hadv + vdiff;
//  }

  return(0);
}


/* Jacobian-times-vector routine. */

static int jtv(N_Vector v, N_Vector Jv, realtype t,
               N_Vector u, N_Vector fu,
               void *user_data, N_Vector tmp)
{
  realtype hordc, horac, verdc;
  UserData data;

  sunindextype zero = 0;
  sunindextype neq = NEQ;
  int maxthreads = 256;

  const realtype *vdata = sunrajavec::extract<realtype, sunindextype>(v)->device();
  realtype *Jvdata    = sunrajavec::extract<realtype, sunindextype>(Jv)->device();

  N_VConst(ZERO, Jv);

  data = (UserData) user_data;
  hordc = data->hdcoef;
  horac = data->hacoef;
  verdc = data->vdcoef;
  
  RAJA::forall<RAJA::cuda_exec<256> >(zero, neq, [=] __device__(sunindextype index) {
    sunindextype i = index/MY;
    sunindextype j = index%MY;

    Jvdata[index] = -TWO*(verdc+hordc) * vdata[index];
    if (i !=    0) Jvdata[index] += (hordc - horac) * vdata[index-MY];
    if (i != MX-1) Jvdata[index] += (hordc + horac) * vdata[index+MY];
    if (j !=    0) Jvdata[index] += verdc * vdata[index-1];
    if (j != MY-1) Jvdata[index] += verdc * vdata[index+1];
  });
  
  return(0);
}

/*
 *-------------------------------
 * Private helper functions
 *-------------------------------
 */

/* Set initial conditions in u vector */

static void SetIC(N_Vector u, UserData data)
{
  sunindextype i, j, tid;
  realtype x, y, dx, dy;
  realtype *udata = sunrajavec::extract<realtype, sunindextype>(u)->host();

  /* Extract needed constants from data */

  dx = data->dx;
  dy = data->dy;

  /* Load initial profile into u vector */

  for (tid=0; tid <MY*MX; tid++) {
    i = tid/MY;
    j = tid%MY;
    
    x = (i+1)*dx;
    y = (j+1)*dy;
    
    udata[tid] = x*(XMAX - x)*y*(YMAX - y)*SUNRexp(FIVE*x*y);
  }
  sunrajavec::extract<realtype, sunindextype>(u)->copyToDev();
}

/* Print first lines of output (problem description) */

static void PrintHeader(realtype reltol, realtype abstol, realtype umax)
{
  printf("\n2-D Advection-Diffusion Equation\n");
  printf("Mesh dimensions = %d X %d\n", MX, MY);
  printf("Total system size = %d\n", NEQ);
#if defined(SUNDIALS_EXTENDED_PRECISION)
  printf("Tolerance parameters: reltol = %Lg   abstol = %Lg\n\n",
         reltol, abstol);
  printf("At t = %Lg      max.norm(u) =%14.6Le \n", T0, umax);
#elif defined(SUNDIALS_DOUBLE_PRECISION)
  printf("Tolerance parameters: reltol = %g   abstol = %g\n\n",
         reltol, abstol);
  printf("At t = %g      max.norm(u) =%14.6e \n", T0, umax);
#else
  printf("Tolerance parameters: reltol = %g   abstol = %g\n\n", reltol, abstol);
  printf("At t = %g      max.norm(u) =%14.6e \n", T0, umax);
#endif

  return;
}

/* Print current value */

static void PrintOutput(realtype t, realtype umax, long int nst)
{
#if defined(SUNDIALS_EXTENDED_PRECISION)
  printf("At t = %4.2Lf   max.norm(u) =%14.6Le   nst = %4ld\n", t, umax, nst);
#elif defined(SUNDIALS_DOUBLE_PRECISION)
  printf("At t = %4.2f   max.norm(u) =%14.6e   nst = %4ld\n", t, umax, nst);
#else
  printf("At t = %4.2f   max.norm(u) =%14.6e   nst = %4ld\n", t, umax, nst);
#endif

  return;
}

/* Get and print some final statistics */

static void PrintFinalStats(void *cvode_mem)
{
  long lenrw, leniw ;
  long lenrwLS, leniwLS;
  long int nst, nfe, nsetups, nni, ncfn, netf;
  long int nli, npe, nps, ncfl, nfeLS;
  int flag;

  flag = CVodeGetWorkSpace(cvode_mem, &lenrw, &leniw);
  check_flag(&flag, "CVodeGetWorkSpace", 1);
  flag = CVodeGetNumSteps(cvode_mem, &nst);
  check_flag(&flag, "CVodeGetNumSteps", 1);
  flag = CVodeGetNumRhsEvals(cvode_mem, &nfe);
  check_flag(&flag, "CVodeGetNumRhsEvals", 1);
  flag = CVodeGetNumLinSolvSetups(cvode_mem, &nsetups);
  check_flag(&flag, "CVodeGetNumLinSolvSetups", 1);
  flag = CVodeGetNumErrTestFails(cvode_mem, &netf);
  check_flag(&flag, "CVodeGetNumErrTestFails", 1);
  flag = CVodeGetNumNonlinSolvIters(cvode_mem, &nni);
  check_flag(&flag, "CVodeGetNumNonlinSolvIters", 1);
  flag = CVodeGetNumNonlinSolvConvFails(cvode_mem, &ncfn);
  check_flag(&flag, "CVodeGetNumNonlinSolvConvFails", 1);

  flag = CVSpilsGetWorkSpace(cvode_mem, &lenrwLS, &leniwLS);
  check_flag(&flag, "CVSpilsGetWorkSpace", 1);
  flag = CVSpilsGetNumLinIters(cvode_mem, &nli);
  check_flag(&flag, "CVSpilsGetNumLinIters", 1);
  flag = CVSpilsGetNumPrecEvals(cvode_mem, &npe);
  check_flag(&flag, "CVSpilsGetNumPrecEvals", 1);
  flag = CVSpilsGetNumPrecSolves(cvode_mem, &nps);
  check_flag(&flag, "CVSpilsGetNumPrecSolves", 1);
  flag = CVSpilsGetNumConvFails(cvode_mem, &ncfl);
  check_flag(&flag, "CVSpilsGetNumConvFails", 1);
  flag = CVSpilsGetNumRhsEvals(cvode_mem, &nfeLS);
  check_flag(&flag, "CVSpilsGetNumRhsEvals", 1);

  printf("\nFinal Statistics.. \n\n");
  printf("lenrw   = %5ld     leniw   = %5ld\n", lenrw, leniw);
  printf("lenrwLS = %5ld     leniwLS = %5ld\n", lenrwLS, leniwLS);
  printf("nst     = %5ld\n"                  , nst);
  printf("nfe     = %5ld     nfeLS   = %5ld\n"  , nfe, nfeLS);
  printf("nni     = %5ld     nli     = %5ld\n"  , nni, nli);
  printf("nsetups = %5ld     netf    = %5ld\n"  , nsetups, netf);
  printf("npe     = %5ld     nps     = %5ld\n"  , npe, nps);
  printf("ncfn    = %5ld     ncfl    = %5ld\n\n", ncfn, ncfl);

  return;
}

/* Check function return value...
     opt == 0 means SUNDIALS function allocates memory so check if
              returned NULL pointer
     opt == 1 means SUNDIALS function returns a flag so check if
              flag >= 0
     opt == 2 means function allocates memory so check if returned
              NULL pointer */

static int check_flag(void *flagvalue, const char *funcname, int opt)
{
  int *errflag;

  /* Check if SUNDIALS function returned NULL pointer - no memory allocated */

  if (opt == 0 && flagvalue == NULL) {
    fprintf(stderr, "\nSUNDIALS_ERROR: %s() failed - returned NULL pointer\n\n",
            funcname);
    return(1); }

  /* Check if flag < 0 */

  else if (opt == 1) {
    errflag = (int *) flagvalue;
    if (*errflag < 0) {
      fprintf(stderr, "\nSUNDIALS_ERROR: %s() failed with flag = %d\n\n",
              funcname, *errflag);
      return(1); }}

  /* Check if function returned NULL pointer - no memory allocated */

  else if (opt == 2 && flagvalue == NULL) {
    fprintf(stderr, "\nMEMORY_ERROR: %s() failed - returned NULL pointer\n\n",
            funcname);
    return(1); }

  return(0);
}
