/*************************************************************************
 * File: kinwebs.c                                                       *
 * Programmers: Allan G. Taylor and Alan C. Hindmarsh @ LLNL             *
 * Version of 16 January 2001                                            *
 *-----------------------------------------------------------------------*
 * Example problem for KINSol, serial machine version.
 * This example solves a nonlinear system that arises from a system of  
 * partial differential equations. The PDE system is a food web         
 * population model, with predator-prey interaction and diffusion on the
 * unit square in two dimensions. The dependent variable vector is      
 * 
 *       1   2         ns
 * c = (c , c ,  ..., c  )              (denoted by the variable cc)
 * 
 * and the PDE's are as follows:
 *
 *                    i       i      
 *         0 = d(i)*(c     + c    )  +  f  (x,y,c)   (i=1,...,ns)
 *                    xx      yy         i
 *
 *   where
 *
 *                   i             ns         j  
 *   f  (x,y,c)  =  c  * (b(i)  + sum a(i,j)*c )
 *    i                           j=1
 *
 * The number of species is ns = 2 * np, with the first np being prey and
 * the last np being predators. The number np is both the number of prey and
 * predator species. The coefficients a(i,j), b(i), d(i) are
 *
 *   a(i,i) = -AA  (all i)
 *   a(i,j) = -GG  (i <= np , j >  np)
 *   a(i,j) =  EE  (i >  np,  j <= np)
 *   b(i) = BB * (1 + alpha * x * y)  (i <= np)
 *   b(i) =-BB * (1 + alpha * x * y)  (i >  np)
 *   d(i) = DPREY  (i <= np)
 *   d(i) = DPRED  ( i > np)
 *
 *  The various scalar parameters are set using define's 
 *  or in routine InitUserData.
 *  The boundary conditions are: normal derivative  =  0.
 *  The initial guess is constant in x and y, although the final
 *  solution is not.
 *
 *  The PDEs are discretized by central differencing on a MX by MY mesh.
 * 
 *  The nonlinear system is solved by KINSOL using the method specified in
 *  local variable globalstrat .
 *
 *  The preconditioner matrix is a block-diagonal matrix based on the
 *  partial derivatives of the interaction terms f only.
 * 
 * 
 * References:
 *
 * 1. Peter N. Brown and Youcef Saad,
 *    Hybrid Krylov Methods for Nonlinear Systems of Equations
 *    LLNL report UCRL-97645, November 1987.
 *  
 * 2. Peter N. Brown and Alan C. Hindmarsh,
 *    Reduced Storage Matrix Methods in Stiff ODE systems,
 *    Lawrence Livermore National Laboratory Report  UCRL-95088, Rev. 1,
 *    June 1987, and  Journal of Applied Mathematics and Computation, Vol. 31
 *    (May 1989), pp. 40-91. (Presents a description of the time-dependent
 *    version of this test problem.)
 ****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "llnltyps.h"   /* definitions of real, integer, bool, TRUE, FALSE */
#include "kinsol.h"     /* main KINSOL header file                         */
#include "iterativ.h"   /* contains the enum for types of preconditioning  */
#include "kinspgmr.h"   /* use KINSPGMR linear solver                      */
#include "smalldense.h" /* use generic DENSE solver for preconditioning    */
#include "nvector.h"    /* definitions of type N_Vector, macro N_VDATA     */
#include "llnlmath.h"   /* contains RSqrt and UnitRoundoff routines        */

/* Problem Constants */

#define NUM_SPECIES     6  /* must equal 2*(number of prey or predators)
			      number of prey = number of predators       */ 

#define PI       3.1415926535898   /* pi */ 

#define MX          8              /* MX = number of x mesh points */
#define MY          8              /* MY = number of y mesh points */
#define NSMX        (NUM_SPECIES * MX)
#define NEQ         (NSMX * MY)    /* number of equations in the system */
#define AA          RCONST(1.0)    /* value of coefficient AA in above eqns */
#define EE          RCONST(10000.) /* value of coefficient EE in above eqns */
#define GG          RCONST(0.5e-6) /* value of coefficient GG in above eqns */
#define BB          RCONST(1.0)    /* value of coefficient BB in above eqns */
#define DPREY       RCONST(1.0)    /* value of coefficient dprey above */
#define DPRED       RCONST(0.5)    /* value of coefficient dpred above */
#define ALPHA       RCONST(1.0)    /* value of coefficient alpha above */
#define AX          RCONST(1.0)    /* total range of x variable */
#define AY          RCONST(1.0)    /* total range of y variable */
#define FTOL        RCONST(1.e-7)  /* ftol tolerance */
#define STOL        RCONST(1.e-13) /* stol tolerance */
#define THOUSAND    RCONST(1000.0) /* one thousand */
#define ZERO        RCONST(0.)     /* 0. */
#define ONE         RCONST(1.0)    /* 1. */
#define PREYIN      RCONST(1.0)    /* initial guess for prey concentrations. */
#define PREDIN      RCONST(30000.0)/* initial guess for predator concs.      */

/* User-defined vector access macro: IJ_Vptr */

/* IJ_Vptr is defined in order to translate from the underlying 3D structure
   of the dependent variable vector to the 1D storage scheme for an N-vector.
   IJ_Vptr(vv,i,j) returns a pointer to the location in vv corresponding to 
   indices is = 0, jx = i, jy = j.    */

#define IJ_Vptr(vv,i,j)   (&(((vv)->data)[(i)*NUM_SPECIES + (j)*NSMX]))

/* Type : UserData 
   contains preconditioner blocks, pivot arrays, and problem constants */

typedef struct {
  real **P[MX][MY];
  integer *pivot[MX][MY];
  real **acoef, *bcoef;
  N_Vector rates;
  real *cox, *coy;
  real ax, ay, dx, dy;
  real uround, sqruround;
  integer Neq, mx, my, ns, np;
} *UserData;


/* Private Helper Functions */

static UserData AllocUserData(void);
static void InitUserData(UserData data);
static void FreeUserData(UserData data);
static void SetInitialProfiles(N_Vector cc, N_Vector sc);
static void PrintOutput(N_Vector cc);
static void PrintFinalStats(long int iopt[]);
static void WebRate(real xx, real yy, real *cxy, real *ratesxy, void *f_data);
static real DotProd(integer size, real *x1, real *x2);


/* Functions Called by the KINSOL Solver */

static void funcprpr(integer Neq, N_Vector cc, N_Vector fval, void *f_data);

static int Precondbd(integer Neq, N_Vector cc, N_Vector cscale, N_Vector fval,
		     N_Vector fscale, N_Vector vtemp1, N_Vector vtemp2, 
                     SysFn func, real uround, long int *nfePtr, void *P_data);

static int PSolvebd(integer Neq, N_Vector cc, N_Vector cscale,
		  N_Vector fval, N_Vector fscale, N_Vector vv, N_Vector ftem,
		  SysFn func, real uround, long int *nfePtr, void *P_data); 


/***************************** Main Program ******************************/

main()
{
  integer Neq=NEQ, globalstrategy, i;
  real fnormtol, scsteptol, ropt[OPT_SIZE];
  long int iopt[OPT_SIZE];
  N_Vector cc, sc, constraints;
  UserData data;
  void *kinsol_mem;
  int iout, flag, maxl, maxlrst;
  boole optIn;
  void *mem;
  KINMem kmem;

  /* Allocate memory, and set problem data, initial values, tolerances */ 

  optIn = FALSE;

  globalstrategy = INEXACT_NEWTON;

  data = AllocUserData();
  InitUserData(data);

  cc = N_VNew(Neq, NULL);
  sc = N_VNew(Neq, NULL);
  data->rates=N_VNew(Neq,NULL);

  constraints = N_VNew(Neq, NULL);
  N_VConst(0.,constraints);
  
  SetInitialProfiles(cc, sc);

  fnormtol=FTOL; scsteptol=STOL;

  /* Call KINMalloc to initialize KINSOL: 
     Neq      is the number of equations in the system being solved
     NULL     directs error messages to stdout
     NULL     the machEnv pointer is not used in the serial version
   A pointer to KINSOL problem memory is returned and stored in kinsol_mem.*/

  mem = KINMalloc(Neq, NULL, NULL);
  if (mem == NULL) { printf("KINMalloc failed."); return(1); }
  kmem = (KINMem)mem;

  /* Call KINSpgmr to specify the linear solver KINSPGMR with preconditioner
     routines Precondbd and PSolvebd, and the pointer to the user block data. */

  maxl = 15; maxlrst = 2;
  flag = KINSpgmr(kmem,
           maxl,      /*  max. dimension of the Krylov subspace in SPGMR */
           maxlrst,   /*  max number of SPGMR restarts */
           0,         /*  0 forces use of default for msbpre, the max.
                          number of nonlinear steps between calls to the
                          preconditioner setup routine */
           Precondbd, /* user-supplied preconditioner setup routine */
           PSolvebd,  /* user-supplied preconditioner solve routine */
           NULL,      /* user-supplied ATimes routine -- Null here */
           data);     /* pointer to the user-defined data block */

  if (flag != 0) {
    printf("KINSpgmr call failed, returning %d \n",flag);
    return(1);
  }

  /* Print out the problem size, solution parameters, initial guess. */

  printf("\nPredator-prey test problem --  KINSol (serial version)\n\n");
  printf("Mesh dimensions = %d X %d\n", MX, MY);
  printf("Number of species = %d\n", NUM_SPECIES);
  printf("Total system size = %d\n\n", Neq);
  printf("Flag globalstrategy = %d (0 = Inex. Newton, 1 = Linesearch)\n",
                   globalstrategy);
  printf("Linear solver is SPGMR with maxl = %d, maxlrst = %d\n",
                   maxl, maxlrst);
  printf("Preconditioning uses interaction-only block-diagonal matrix\n");
  printf("Tolerance parameters:  fnormtol = %g   scsteptol = %g\n",
	           fnormtol, scsteptol);

  printf("\nInitial profile of concentration\n");
  printf("At all mesh points:  %g %g %g   %g %g %g\n", PREYIN,PREYIN,PREYIN,
         PREDIN,PREDIN,PREDIN);

  /* Call KINSol and print output concentration profile */

  flag = KINSol(kmem,           /* KINSol memory block */
		Neq,            /* system size -- number of equations  */
		cc,             /* solution vector, and initial guess on input */
		funcprpr,       /* function describing the system equations */
		globalstrategy, /* global stragegy choice */
		sc,             /* scaling vector, for the variable cc */
		sc,             /* scaling vector for function values fval */
		fnormtol,       /* tolerance on norm of scaled function value */
		scsteptol,      /* step size tolerance */
		constraints,    /* constraints vector  */
		optIn,          /* optional inputs flag: TRUE or FALSE */
		iopt,           /* integer optional input array */
		ropt,           /* real optional input array */
		data);          /* pointer to user data */

  if (flag != KINSOL_SUCCESS) { 
    printf("KINSOL failed, returning %d.\n", flag); 
    return(flag); }

  printf("\n\n\nComputed equilibrium species concentrations:\n");
  PrintOutput(cc);


  /* Print final statistics and free memory */  

  PrintFinalStats(iopt);

  N_VFree(cc);
  N_VFree(sc);
  N_VFree(constraints);
  KINFree(kmem);
  FreeUserData(data);

  return(0);

} /* end of main *********************************************************/


/*********************** Private Helper Functions ************************/


/* Allocate memory for data structure of type UserData */

static UserData AllocUserData(void)
{
  int jx, jy;
  UserData data;

  data = (UserData) malloc(sizeof *data);

  for (jx=0; jx < MX; jx++) {
    for (jy=0; jy < MY; jy++) {
      (data->P)[jx][jy] = denalloc(NUM_SPECIES);
      (data->pivot)[jx][jy] = denallocpiv(NUM_SPECIES);
    }
  }
 (data->acoef) = denalloc(NUM_SPECIES);
 (data->bcoef) = (real *)malloc(NUM_SPECIES * sizeof(real));
 (data->cox)   = (real *)malloc(NUM_SPECIES * sizeof(real));
 (data->coy)   = (real *)malloc(NUM_SPECIES * sizeof(real));
 
  return(data);

} /* end of routine AllocUserData ****************************************/


/* Readability definitions used in other routines below */
#define acoef  (data->acoef)
#define bcoef  (data->bcoef)
#define cox    (data->cox)
#define coy    (data->coy)


/* Load problem constants in data */

static void InitUserData(UserData data)
{
  int i, j, np;
  real *a1,*a2, *a3, *a4, *b, dx2, dy2;

  data->mx = MX;
  data->my = MY;
  data->Neq= NEQ;
  data->ns = NUM_SPECIES;
  data->np = NUM_SPECIES/2;
  data->ax = AX;
  data->ay = AY;
  data->dx = (data->ax)/(MX-1);
  data->dy = (data->ay)/(MY-1);
  data->uround = UnitRoundoff();
  data->sqruround = RSqrt(data->uround);
  
  /* Set up the coefficients a and b plus others found in the equations */
  np = data->np;

  dx2=(data->dx)*(data->dx); dy2=(data->dy)*(data->dy);

  for(i=0;i<np;i++){
    a1= &(acoef[i][np]);
    a2= &(acoef[i+np][0]);
    a3= &(acoef[i][0]);
    a4= &(acoef[i+np][np]);
    /*  Fill in the portion of acoef in the four quadrants, row by row */
    for(j=0;j<np;j++){
      *a1++ =  -GG;
      *a2++ =   EE;
      *a3++ = ZERO;
      *a4++ = ZERO;
    }

    /* and then change the diagonal elements of acoef to -AA */
    acoef[i][i]=-AA;
    acoef[i+np][i+np] = -AA;

    bcoef[i] = BB;
    bcoef[i+np] = -BB;

    cox[i]=DPREY/dx2;
    cox[i+np]=DPRED/dx2;

    coy[i]=DPREY/dy2;
    coy[i+np]=DPRED/dy2;
  }

} /* end of routine InitUserData *****************************************/


/* Free data memory */

static void FreeUserData(UserData data)
{
  int jx, jy;

  for (jx=0; jx < MX; jx++) {
    for (jy=0; jy < MY; jy++) {
      denfree((data->P)[jx][jy]);
      denfreepiv((data->pivot)[jx][jy]);
    }
  }

  denfree(acoef);
  free(bcoef);
  free(cox);
  N_VFree(data->rates);
  free(data);

} /* end of routine FreeUserData *****************************************/


/* Set initial conditions in cc */

static void SetInitialProfiles(N_Vector cc, N_Vector sc)
{
  int i, jx, jy;
  real *cloc, *sloc;
  real  ctemp[NUM_SPECIES], stemp[NUM_SPECIES];

  /* Initialize arrays ctemp and stemp used in the loading process */
  for(i=0;i<NUM_SPECIES/2;i++) {
    ctemp[i] = PREYIN;
    stemp[i] = ONE;
  }
  for(i=NUM_SPECIES/2;i<NUM_SPECIES;i++) {
    ctemp[i] = PREDIN;
    stemp[i] = 0.00001;
  }

  /* Load initial profiles into cc and sc vector from ctemp and stemp. */
  for (jy=0; jy < MY; jy++) {
    for (jx=0; jx < MX; jx++) {
      cloc = IJ_Vptr(cc,jx,jy);
      sloc = IJ_Vptr(sc,jx,jy);
      for(i=0;i<NUM_SPECIES;i++){
	cloc[i] = ctemp[i];
	sloc[i] = stemp[i];
      }
    }
  }

} /* end of routine SetInitialProfiles ***********************************/


/* Print sampled values of current cc */

static void PrintOutput(N_Vector cc)
{
  int is, jx, jy;
  real *ct;

  jy = 0; jx = 0;
  ct = IJ_Vptr(cc,jx,jy);
  printf("\nAt bottom left:");
  /* Print out lines with up to 6 values per line */
  for(is=0;is<NUM_SPECIES;is++){
    if((is%6)*6 == is)printf("\n");
    printf(" %g",ct[is]);
  }

  jy = MY-1; jx = MX-1;
  ct = IJ_Vptr(cc,jx,jy);
  printf("\n\nAt top right:");
  /* Print out lines with up to 6 values per line */
  for(is=0;is<NUM_SPECIES;is++){
    if((is%6)*6 == is)printf("\n");
    printf(" %g",ct[is]);
  }
 printf("\n\n");

} /* end of routine PrintOutput ******************************************/


/* Print final statistics contained in iopt */

static void PrintFinalStats(long int iopt[])
{
  printf("\nFinal Statistics.. \n\n");
  printf("nni    = %5ld    nli   = %5ld\n", iopt[NNI], iopt[SPGMR_NLI]);
  printf("nfe    = %5ld    npe   = %5ld\n", iopt[NFE], iopt[SPGMR_NPE]);
  printf("nps    = %5ld    ncfl  = %5ld\n", iopt[SPGMR_NPS], iopt[SPGMR_NCFL]);

} /* end of routine PrintFinalStats **************************************/


/***************** Functions Called by the KINSOL Solver *****************/


/* System function for predator-prey system */

static void funcprpr(integer Neq, N_Vector cc, N_Vector fval, void *f_data)
{
  real xx, yy, delx, dely, *cxy, *rxy, *fxy, dcyli, dcyui, dcxli, dcxri;
  integer jx, jy, is, idyu, idyl, idxr, idxl;
  UserData data;
 
  data=(UserData)f_data;
  delx = data->dx;
  dely = data->dy;

  /* Loop over all mesh points, evaluating rate array at each point*/

  for (jy = 0; jy < MY; jy++) {

    yy = dely*jy;
    /* Set lower/upper index shifts, special at boundaries. */
    idyl = (jy != 0   ) ? NSMX : -NSMX;
    idyu = (jy != MY-1) ? NSMX : -NSMX;

    for (jx = 0; jx < MX; jx++) {

      xx = delx*jx;
      /* Set left/right index shifts, special at boundaries. */
      idxl = (jx !=  0  ) ?  NUM_SPECIES : -NUM_SPECIES;
      idxr = (jx != MX-1) ?  NUM_SPECIES : -NUM_SPECIES;

      cxy = IJ_Vptr(cc,jx,jy);
      rxy = IJ_Vptr(data->rates,jx,jy);
      fxy = IJ_Vptr(fval,jx,jy);

      /* Get species interaction rate array at (xx,yy) */
      WebRate(xx, yy, cxy, rxy, f_data);

      for(is=0; is<NUM_SPECIES; is++){

	/* Differencing in x direction */
	dcyli = *(cxy+is) - *(cxy - idyl + is) ;
	dcyui = *(cxy + idyu + is) - *(cxy+is);
	
	/* Differencing in y direction */
	dcxli = *(cxy+is) - *(cxy - idxl + is);
	dcxri = *(cxy + idxr +is) - *(cxy+is);

	/* Compute the total rate value at (xx,yy) */
	fxy[is] = (coy)[is] * (dcyui - dcyli) +
                  (cox)[is] * (dcxri - dcxli) + rxy[is];

      } /* end of is loop */

    } /* end of jx loop */

  } /* end of jy loop */

} /* end of routine funcprpr *********************************************/


/* Preconditioner setup routine. Generate and preprocess P. */

static int Precondbd(integer Neq, N_Vector cc, N_Vector cscale,
		   N_Vector fval, N_Vector fscale,
		   N_Vector vtemp1, N_Vector vtemp2, 
		   SysFn func, real uround, long int *nfePtr, void *P_data)
{
  real r, r0, sqruround, xx, yy, delx, dely, csave, fac;
  real *cxy, *scxy, **Pxy, *ratesxy, *Pxycol, perturb_rates[NUM_SPECIES];
  integer i, j, jx, jy, ret;
  UserData data;

  data = (UserData)P_data;
  delx = data->dx;
  dely = data->dy;

  sqruround = data->sqruround;
  fac = N_VWL2Norm(fval, fscale);
  r0 = THOUSAND * uround * fac * Neq;
  if(r0 == ZERO) r0 = ONE;

  /* Loop over spatial points; get size NUM_SPECIES Jacobian block at each */

  for (jy = 0; jy < MY; jy++) {
    yy = jy*dely;

    for (jx = 0; jx < MX; jx++) {
      xx = jx*delx;
      Pxy = (data->P)[jx][jy];
      cxy = IJ_Vptr(cc,jx,jy);
      scxy= IJ_Vptr(cscale,jx,jy);
      ratesxy = IJ_Vptr((data->rates),jx,jy);

      /* Compute difference quotients of interaction rate fn. */

      for (j = 0; j < NUM_SPECIES; j++) {

	csave = cxy[j];  /* Save the j,jx,jy element of cc */
	r = MAX(sqruround*ABS(csave), r0/scxy[j]);
	cxy[j] += r; /* Perturb the j,jx,jy element of cc */
	fac = ONE/r;

	WebRate(xx, yy, cxy, perturb_rates, data);

	/* Restore j,jx,jy element of cc */
	cxy[j] = csave;

        /* Load the j-th column of difference quotients */
	Pxycol = Pxy[j];
	for (i = 0; i < NUM_SPECIES; i++)
	  Pxycol[i] = (perturb_rates[i] - ratesxy[i]) * fac;


      } /* end of j loop */

      /* Do LU decomposition of size NUM_SPECIES preconditioner block */

      ret = gefa(Pxy, NUM_SPECIES, (data->pivot)[jx][jy]);
      if (ret != 0) return(1);

    } /* end of jx loop */

  } /* end of jy loop */

  return(0);

} /* end of routine Precondbd ********************************************/


/* Preconditioner solve routine */

static int PSolvebd(integer Neq, N_Vector cc, N_Vector cscale,
		  N_Vector fval, N_Vector fscale, N_Vector vv, N_Vector ftem,
		  SysFn func, real uround, long int *nfePtr, void *P_data)
{
 real **Pxy, *vxy;
 integer *piv, jx, jy;
 UserData data;

 data = (UserData)P_data;
 
 for(jx=0; jx<MX; jx++) {

   for(jy=0; jy<MY; jy++) {

     /* For each (jx,jy), solve a linear system of size NUM_SPECIES.
        vxy is the address of the corresponding portion of the vector vv;
	Pxy is the address of the corresponding block of the matrix P;
	piv is the address of the corresponding block of the array pivot. */
     vxy = IJ_Vptr(vv,jx,jy);
     Pxy = (data->P)[jx][jy];
     piv = (data->pivot)[jx][jy];
     gesl (Pxy, NUM_SPECIES, piv, vxy);

   } /* end of jy loop */

 } /* end of jx loop */

 return(0);

} /* end of routine PSolvebd *********************************************/


/* Interaction rate function routine */

static void WebRate(real xx, real yy, real *cxy, real *ratesxy, void *f_data)
{
  integer i;
  real fac;
  UserData data;

  data = (UserData)f_data;

  for (i = 0; i<NUM_SPECIES; i++)
       ratesxy[i] = DotProd(NUM_SPECIES, cxy, acoef[i]);

  fac = ONE + ALPHA * xx * yy;

  for (i = 0; i < NUM_SPECIES; i++)
    ratesxy[i] = cxy[i] * ( bcoef[i] * fac + ratesxy[i] );

} /* end of routine WebRate **********************************************/


/* Dot product routine for real arrays */

static real DotProd(integer size, real *x1, real *x2)
{
  integer i;
  real *xx1, *xx2, temp = ZERO;
  
  xx1 = x1; xx2 = x2;
  for (i = 0; i < size; i++) temp += (*xx1++) * (*xx2++);
  return(temp);

} /* end of routine DotProd **********************************************/
