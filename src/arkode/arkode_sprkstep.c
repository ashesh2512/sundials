/*---------------------------------------------------------------
 * Programmer(s): Cody J. Balos @ LLNL
 *---------------------------------------------------------------
 * SUNDIALS Copyright Start
 * Copyright (c) 2002-2022, Lawrence Livermore National Security
 * and Southern Methodist University.
 * All rights reserved.
 *
 * See the top-level LICENSE and NOTICE files for details.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 * SUNDIALS Copyright End
 *---------------------------------------------------------------
 * This is the implementation file for ARKODE's ARK time stepper
 * module.
 *--------------------------------------------------------------*/

#include "arkode/arkode_sprkstep.h"

#include <arkode/arkode.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sundials/sundials_math.h>
#include <sundials/sundials_nvector.h>
#include <sundials/sundials_types.h>
#include <sunnonlinsol/sunnonlinsol_newton.h>

#include "arkode_impl.h"
#include "arkode_interp_impl.h"
#include "arkode_sprkstep_impl.h"

/*===============================================================
  SPRKStep Exported functions -- Required
  ===============================================================*/

void* SPRKStepCreate(ARKRhsFn f1, ARKRhsFn f2, realtype t0, N_Vector y0,
                     SUNContext sunctx)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  booleantype nvectorOK;
  int retval;

  /* Check that f1 and f2 are supplied */
  if (f1 == NULL)
  {
    arkProcessError(NULL, ARK_ILL_INPUT, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_NULL_F);
    return (NULL);
  }

  if (f2 == NULL)
  {
    arkProcessError(NULL, ARK_ILL_INPUT, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_NULL_F);
    return (NULL);
  }

  /* Check for legal input parameters */
  if (y0 == NULL)
  {
    arkProcessError(NULL, ARK_ILL_INPUT, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_NULL_Y0);
    return (NULL);
  }

  if (!sunctx)
  {
    arkProcessError(NULL, ARK_ILL_INPUT, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_NULL_SUNCTX);
    return (NULL);
  }

  /* Test if all required vector operations are implemented */
  nvectorOK = sprkStep_CheckNVector(y0);
  if (!nvectorOK)
  {
    arkProcessError(NULL, ARK_ILL_INPUT, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_BAD_NVECTOR);
    return (NULL);
  }

  /* Create ark_mem structure and set default values */
  ark_mem = arkCreate(sunctx);
  if (ark_mem == NULL)
  {
    arkProcessError(NULL, ARK_MEM_NULL, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_NO_MEM);
    return (NULL);
  }

  /* Allocate ARKodeSPRKStepMem structure, and initialize to zero */
  step_mem = NULL;
  step_mem = (ARKodeSPRKStepMem)malloc(sizeof(struct ARKodeSPRKStepMemRec));
  if (step_mem == NULL)
  {
    arkProcessError(ark_mem, ARK_MEM_FAIL, "ARKODE::SPRKStep", "SPRKStepCreate",
                    MSG_ARK_ARKMEM_FAIL);
    return (NULL);
  }
  memset(step_mem, 0, sizeof(struct ARKodeSPRKStepMemRec));

  /* Allocate vectors in stepper mem */
  if (!arkAllocVec(ark_mem, y0, &(step_mem->sdata)))
  {
    SPRKStepFree((void**)&ark_mem);
    return (NULL);
  }

  /* Attach step_mem structure and function pointers to ark_mem */
  ark_mem->step_attachlinsol   = NULL;
  ark_mem->step_attachmasssol  = NULL;
  ark_mem->step_disablelsetup  = NULL;
  ark_mem->step_disablemsetup  = NULL;
  ark_mem->step_getlinmem      = NULL;
  ark_mem->step_getmassmem     = NULL;
  ark_mem->step_getimplicitrhs = NULL;
  ark_mem->step_mmult          = NULL;
  ark_mem->step_getgammas      = NULL;
  ark_mem->step_init           = sprkStep_Init;
  ark_mem->step_fullrhs        = sprkStep_FullRHS;
  ark_mem->step                = sprkStep_TakeStep;
  ark_mem->step_mem            = (void*)step_mem;

  /* Set default values for SPRKStep optional inputs */
  retval = SPRKStepSetDefaults((void*)ark_mem);
  if (retval != ARK_SUCCESS)
  {
    arkProcessError(ark_mem, retval, "ARKODE::SPRKStep", "SPRKStepCreate",
                    "Error setting default solver options");
    SPRKStepFree((void**)&ark_mem);
    return (NULL);
  }

  /* Copy the input parameters into ARKODE state */
  step_mem->f1 = f1;
  step_mem->f2 = f2;

  /* Initialize the counters */
  step_mem->nf1    = 0;
  step_mem->nf2    = 0;
  step_mem->istage = 0;

  /* Initialize main ARKODE infrastructure */
  retval = arkInit(ark_mem, t0, y0, FIRST_INIT);
  if (retval != ARK_SUCCESS)
  {
    arkProcessError(ark_mem, retval, "ARKODE::SPRKStep", "SPRKStepCreate",
                    "Unable to initialize main ARKODE infrastructure");
    SPRKStepFree((void**)&ark_mem);
    return (NULL);
  }

  /* We use Lagrange interpolation by default otherwise extra RHS calls are
     needed. This is because we cannot reuse the f2 RHS in TakeStep since it is
     a staggered time step. Additionally, it seems Lagrange interpolation does
     a better job of conservation. */
  arkSetInterpolantType(ark_mem, ARK_INTERP_LAGRANGE);

  return ((void*)ark_mem);
}

/*---------------------------------------------------------------
  SPRKStepResize:

  This routine resizes the memory within the SPRKStep module.
  It first resizes the main ARKODE infrastructure memory, and
  then resizes its own data.
  ---------------------------------------------------------------*/
int SPRKStepResize(void* arkode_mem, N_Vector y0, realtype hscale, realtype t0,
                   ARKVecResizeFn resize, void* resize_data)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  SUNNonlinearSolver NLS;
  sunindextype lrw1, liw1, lrw_diff, liw_diff;
  int i, retval;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "SPRKStepResize", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  /* resize ARKODE infrastructure memory */
  retval = arkResize(ark_mem, y0, hscale, t0, resize, resize_data);
  if (retval != ARK_SUCCESS)
  {
    arkProcessError(ark_mem, retval, "ARKODE::SPRKStep", "SPRKStepResize",
                    "Unable to resize main ARKODE infrastructure");
    return (retval);
  }

  return (ARK_SUCCESS);
}

/*---------------------------------------------------------------
  SPRKStepReInit:

  This routine re-initializes the SPRKStep module to solve a new
  problem of the same size as was previously solved. This routine
  should also be called when the problem dynamics or desired solvers
  have changed dramatically, so that the problem integration should
  resume as if started from scratch.

  Note all internal counters are set to 0 on re-initialization.
  ---------------------------------------------------------------*/
int SPRKStepReInit(void* arkode_mem, ARKRhsFn f1, ARKRhsFn f2, realtype t0,
                   N_Vector y0)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  int retval;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "SPRKStepReInit", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  /* Check if ark_mem was allocated */
  if (ark_mem->MallocDone == SUNFALSE)
  {
    arkProcessError(ark_mem, ARK_NO_MALLOC, "ARKODE::SPRKStep",
                    "SPRKStepReInit", MSG_ARK_NO_MALLOC);
    return (ARK_NO_MALLOC);
  }

  /* Check that f1 and f2 are supplied */
  if (f1 == NULL || f2 == NULL)
  {
    arkProcessError(ark_mem, ARK_ILL_INPUT, "ARKODE::SPRKStep",
                    "SPRKStepReInit", MSG_ARK_NULL_F);
    return (ARK_ILL_INPUT);
  }

  /* Check that y0 is supplied */
  if (y0 == NULL)
  {
    arkProcessError(ark_mem, ARK_ILL_INPUT, "ARKODE::SPRKStep",
                    "SPRKStepReInit", MSG_ARK_NULL_Y0);
    return (ARK_ILL_INPUT);
  }

  /* Copy the input parameters into ARKODE state */
  step_mem->f1 = f1;
  step_mem->f2 = f2;

  /* Initialize main ARKODE infrastructure */
  retval = arkInit(ark_mem, t0, y0, FIRST_INIT);
  if (retval != ARK_SUCCESS)
  {
    arkProcessError(ark_mem, retval, "ARKODE::SPRKStep", "SPRKStepReInit",
                    "Unable to reinitialize main ARKODE infrastructure");
    return (retval);
  }

  /* Initialize the counters */
  step_mem->nf1    = 0;
  step_mem->nf2    = 0;
  step_mem->istage = 0;

  return (ARK_SUCCESS);
}

/*---------------------------------------------------------------
  SPRKStepReset:

  This routine resets the SPRKStep module state to solve the same
  problem from the given time with the input state (all counter
  values are retained).
  ---------------------------------------------------------------*/
int SPRKStepReset(void* arkode_mem, realtype tR, N_Vector yR)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  int retval;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "SPRKStepReset", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  /* Initialize main ARKODE infrastructure */
  retval = arkInit(ark_mem, tR, yR, RESET_INIT);

  if (retval != ARK_SUCCESS)
  {
    arkProcessError(ark_mem, retval, "ARKODE::SPRKStep", "SPRKStepReset",
                    "Unable to initialize main ARKODE infrastructure");
    return (retval);
  }

  return (ARK_SUCCESS);
}

/*---------------------------------------------------------------
  SPRKStepEvolve:

  This is the main time-integration driver (wrappers for general
  ARKODE utility routine)
  ---------------------------------------------------------------*/
int SPRKStepEvolve(void* arkode_mem, realtype tout, N_Vector yout,
                   realtype* tret, int itask)
{
  int retval;
  SUNDIALS_MARK_FUNCTION_BEGIN(ARK_PROFILER);
  retval = arkEvolve((ARKodeMem)arkode_mem, tout, yout, tret, itask);
  SUNDIALS_MARK_FUNCTION_END(ARK_PROFILER);
  return (retval);
}

/*---------------------------------------------------------------
  SPRKStepGetDky:

  This returns interpolated output of the solution or its
  derivatives over the most-recently-computed step (wrapper for
  generic ARKODE utility routine)
  ---------------------------------------------------------------*/
int SPRKStepGetDky(void* arkode_mem, realtype t, int k, N_Vector dky)
{
  int retval;
  SUNDIALS_MARK_FUNCTION_BEGIN(ARK_PROFILER);
  retval = arkGetDky((ARKodeMem)arkode_mem, t, k, dky);
  SUNDIALS_MARK_FUNCTION_END(ARK_PROFILER);
  return (retval);
}

/*---------------------------------------------------------------
  SPRKStepFree frees all SPRKStep memory, and then calls an ARKODE
  utility routine to free the ARKODE infrastructure memory.
  ---------------------------------------------------------------*/
void SPRKStepFree(void** arkode_mem)
{
  int j;
  sunindextype Bliw, Blrw;
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;

  /* nothing to do if arkode_mem is already NULL */
  if (*arkode_mem == NULL) return;

  /* conditional frees on non-NULL SPRKStep module */
  ark_mem = (ARKodeMem)(*arkode_mem);
  if (ark_mem->step_mem != NULL)
  {
    step_mem = (ARKodeSPRKStepMem)ark_mem->step_mem;

    if (step_mem->sdata != NULL)
    {
      arkFreeVec(ark_mem, &step_mem->sdata);
      step_mem->sdata = NULL;
    }

    ARKodeSPRKMem_Free(step_mem->method);

    free(ark_mem->step_mem);
    ark_mem->step_mem = NULL;
  }

  /* free memory for overall ARKODE infrastructure */
  arkFree(arkode_mem);
}

/*===============================================================
  SPRKStep Private functions
  ===============================================================*/

/*---------------------------------------------------------------
  Interface routines supplied to ARKODE
  ---------------------------------------------------------------*/

/*---------------------------------------------------------------
  sprkStep_Init:

  This routine is called just prior to performing internal time
  steps (after all user "set" routines have been called) from
  within arkInitialSetup.

  For all initialization types, this routine sets the relevant
  TakeStep routine based on the current problem configuration.

  With initialization type FIRST_INIT this routine:

  With initialization type FIRST_INIT or RESIZE_INIT, this routine:

  With initialization type RESET_INIT, this routine does nothing.
  ---------------------------------------------------------------*/
int sprkStep_Init(void* arkode_mem, int init_type)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  int j, retval;
  booleantype reset_efun;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "sprkStep_Init", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  /* immediately return if reset */
  if (init_type == RESET_INIT) { return (ARK_SUCCESS); }

  /* initializations/checks for (re-)initialization call */
  if (init_type == FIRST_INIT)
  {
    if (!step_mem->method)
    {
      switch (step_mem->q)
      {
      case 1: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_1); break;
      case 2: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_2); break;
      case 3: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_3); break;
      case 4: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_4); break;
      case 5: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_5); break;
      case 6: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_6); break;
      case 7:
      case 8: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_8); break;
      case 9:
      case 10:
        step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_10);
        break;
      default: step_mem->method = ARKodeSPRKMem_Load(SPRKSTEP_DEFAULT_4); break;
      }
    }
  }

  /* Signal to shared arkode module that fullrhs is not required after each step
   */
  ark_mem->call_fullrhs = SUNFALSE;

  // TODO(CJB): setting this to NULL is not supported in arkode right now.
  // Should this really exist in fixed step mode? 
  // ark_mem->hadapt_mem = NULL;

  return (ARK_SUCCESS);
}

int SPRKStepRootInit(void* arkode_mem, int nrtfn, ARKRootFn g)
{
  /* unpack ark_mem, call arkRootInit, and return */
  ARKodeMem ark_mem;
  if (arkode_mem == NULL)
  {
    arkProcessError(NULL, ARK_MEM_NULL, "ARKODE::SPRKStep", "SPRKStepRootInit",
                    MSG_ARK_NO_MEM);
    return (ARK_MEM_NULL);
  }
  ark_mem = (ARKodeMem)arkode_mem;
  return (arkRootInit(ark_mem, nrtfn, g));
}

/* Utility to call f1 and increment the counter */
int sprkStep_f1(ARKodeSPRKStepMem step_mem, sunrealtype tcur, N_Vector ycur,
                N_Vector f1, void* user_data)
{
  int retval = step_mem->f1(tcur, ycur, f1, user_data);
  step_mem->nf1++;
  return retval;
}

/* Utility to call f2 and increment the counter */
int sprkStep_f2(ARKodeSPRKStepMem step_mem, sunrealtype tcur, N_Vector ycur,
                N_Vector f2, void* user_data)
{
  int retval = step_mem->f2(tcur, ycur, f2, user_data);
  step_mem->nf2++;
  return retval;
}

/*---------------------------------------------------------------
  sprkStep_FullRHS:

  This is just a wrapper to call the user-supplied RHS,
  f1(t,y) + f2(t,y).

  This will be called in one of three 'modes':
    ARK_FULLRHS_START -> called at the beginning of a simulation
                         or after post processing at step
    ARK_FULLRHS_END   -> called at the end of a successful step
    ARK_FULLRHS_OTHER -> called elsewhere (e.g. for dense output)

  If it is called in ARK_FULLRHS_START mode, we store the vectors
  f1(t,y) and f2(t,y) in sdata for possible reuse in the first stage
  of the subsequent time step.

  If it is called in ARK_FULLRHS_END mode and the method coefficients
  support it, we may just copy the stage vectors to fill f instead
  of calling f().

  ARK_FULLRHS_OTHER mode is only called for dense output in-between
  steps, so we strive to store the intermediate parts so that they
  do not interfere with the other two modes.
  ---------------------------------------------------------------*/
int sprkStep_FullRHS(void* arkode_mem, realtype t, N_Vector y, N_Vector f,
                     int mode)
{
  int retval;
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  booleantype recomputeRHS;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "SPRKStep_FullRHS", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  /* perform RHS functions contingent on 'mode' argument */
  switch (mode)
  {
  case ARK_FULLRHS_START:
  case ARK_FULLRHS_END:
  case ARK_FULLRHS_OTHER:

    retval = sprkStep_f1(step_mem, t, y, f, ark_mem->user_data);
    if (retval != 0)
    {
      arkProcessError(ark_mem, ARK_RHSFUNC_FAIL, "ARKODE::SPRKStep",
                      "SPRKStep_FullRHS", MSG_ARK_RHSFUNC_FAILED, t);
      return (ARK_RHSFUNC_FAIL);
    }

    retval = sprkStep_f2(step_mem, t, y, f, ark_mem->user_data);
    if (retval != 0)
    {
      arkProcessError(ark_mem, ARK_RHSFUNC_FAIL, "ARKODE::SPRKStep",
                      "SPRKStep_FullRHS", MSG_ARK_RHSFUNC_FAILED, t);
      return (ARK_RHSFUNC_FAIL);
    }

    break;

  default:
    /* return with RHS failure if unknown mode is passed */
    arkProcessError(ark_mem, ARK_RHSFUNC_FAIL, "ARKODE::SPRKStep",
                    "SPRKStep_FullRHS", "Unknown full RHS mode");
    return (ARK_RHSFUNC_FAIL);
  }

  return (ARK_SUCCESS);
}

/* Standard formulation of SPRK.
   This requires only 2 vectors in principle, but we use three
   since we persist the stage data. Only the stage data vector
   belongs to SPRKStep, the rest are reused from ARKODE. */
int sprkStep_TakeStep(void* arkode_mem, realtype* dsmPtr, int* nflagPtr)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  N_Vector prev_stage, curr_stage;
  int retval, is;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "sprkStep_TakeStep", &ark_mem,
                                  &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  prev_stage = ark_mem->yn;
  curr_stage = ark_mem->ycur;
  for (is = 0; is < step_mem->method->stages; is++)
  {
    sunrealtype ai = step_mem->method->a[is];
    sunrealtype bi = step_mem->method->b[is];

    /* Set current stage time(s) */
    ark_mem->tcur = ark_mem->tn + ai * ark_mem->h;

    /* Evaluate p' with the previous velocity */
    N_VConst(ZERO, step_mem->sdata); /* either have to do this or ask user to
                                        set other outputs to zero */
    retval = sprkStep_f1(step_mem, ark_mem->tcur, prev_stage, step_mem->sdata,
                         ark_mem->user_data);
    if (retval != 0) return ARK_RHSFUNC_FAIL;

    /* Position update */
    N_VLinearSum(ONE, prev_stage, ark_mem->h * bi, step_mem->sdata, curr_stage);

    /* Evaluate q' with the current positions */
    N_VConst(ZERO, step_mem->sdata); /* either have to do this or ask user to
                                        set other outputs to zero */
    retval = sprkStep_f2(step_mem, ark_mem->tcur, curr_stage, step_mem->sdata,
                         ark_mem->user_data);
    if (retval != 0) return ARK_RHSFUNC_FAIL;

    /* Velocity update */
    N_VLinearSum(ONE, curr_stage, ark_mem->h * ai, step_mem->sdata, curr_stage);

    /* keep track of the stage number */
    step_mem->istage++;

    prev_stage = curr_stage;
  }

  *nflagPtr = 0;
  *dsmPtr   = 0;

  return ARK_SUCCESS;
}

/* Increment SPRK algorithm with compensated summation.
   This algorithm requires 6 vectors, but 5 of them are reused
   from the ARKODE core. */
int sprkStep_TakeStep_Compensated(void* arkode_mem, realtype* dsmPtr,
                                  int* nflagPtr)
{
  ARKodeMem ark_mem;
  ARKodeSPRKStepMem step_mem;
  ARKodeSPRKMem method;
  int retval, is;
  N_Vector delta_Yi, yn_plus_delta_Yi, diff;

  /* access ARKodeSPRKStepMem structure */
  retval = sprkStep_AccessStepMem(arkode_mem, "sprkStep_TakeStep_SPRK",
                                  &ark_mem, &step_mem);
  if (retval != ARK_SUCCESS) return (retval);

  method = step_mem->method;

  /* Vector shortcuts */
  delta_Yi         = ark_mem->tempv1;
  yn_plus_delta_Yi = ark_mem->tempv2;
  diff             = ark_mem->tempv3;

  /* [ \Delta Q_0 ] = [ 0 ]
     [ \Delta P_0 ] = [ 0 ] */
  N_VConst(ZERO, delta_Yi);

  /* loop over internal stages to the step */
  for (is = 0; is < method->stages; is++)
  {
    /* store current stage index */
    step_mem->istage = is;

    /* set current stage time(s) */
    ark_mem->tcur = ark_mem->tn + method->b[is] * ark_mem->h;

    /* [ q_n ] + [ \Delta Q_i ]
       [     ] + [            ] */
    N_VLinearSum(ONE, ark_mem->yn, ONE, delta_Yi, yn_plus_delta_Yi);

    /* Evaluate p' with the previous velocity */
    N_VConst(ZERO, step_mem->sdata); /* either have to do this or ask user to
                                        set other outputs to zero */
    retval = sprkStep_f1(step_mem, ark_mem->tcur, yn_plus_delta_Yi,
                         step_mem->sdata, ark_mem->user_data);
    if (retval != 0) return (ARK_RHSFUNC_FAIL);

    /* Incremental position update:
       [            ] = [                ] + [       ]
       [ \Delta P_i ] = [ \Delta P_{i-1} ] + [ sdata ] */
    N_VLinearSum(ONE, delta_Yi, ark_mem->h * method->b[is], step_mem->sdata,
                 delta_Yi);

    /* [     ] + [            ]
       [ p_n ] + [ \Delta P_i ] */
    N_VLinearSum(ONE, ark_mem->yn, ONE, delta_Yi, yn_plus_delta_Yi);

    /* Evaluate q' with the current positions */
    N_VConst(ZERO, step_mem->sdata); /* either have to do this or ask user to
                                        set other outputs to zero */
    retval = sprkStep_f2(step_mem, ark_mem->tn + method->a[is] * ark_mem->h,
                         yn_plus_delta_Yi, step_mem->sdata, ark_mem->user_data);
    if (retval != 0) return (ARK_RHSFUNC_FAIL);

    /* Incremental velocity update:
       [ \Delta Q_i ] = [ \Delta Q_{i-1} ] + [ sdata ]
       [            ] = [                ] + [       ] */
    N_VLinearSum(ONE, delta_Yi, ark_mem->h * method->a[is], step_mem->sdata,
                 delta_Yi);
  }

  /*
    Now we compute the step solution via compensated summation.
     [ q_{n+1} ] = [ q_n ] + [ \Delta Q_i ]
     [ p_{n+1} ] = [ p_n ] + [ \Delta P_i ] */
  N_VLinearSum(ONE, delta_Yi, -ONE, ark_mem->yerr, delta_Yi);
  N_VLinearSum(ONE, ark_mem->yn, ONE, delta_Yi, ark_mem->ycur);
  N_VLinearSum(ONE, ark_mem->ycur, -ONE, ark_mem->yn, diff);
  N_VLinearSum(ONE, diff, -ONE, delta_Yi, ark_mem->yerr);

  *nflagPtr = 0;
  *dsmPtr   = 0;

  return 0;
}

/*---------------------------------------------------------------
  Internal utility routines
  ---------------------------------------------------------------*/

/*---------------------------------------------------------------
  sprkStep_AccessStepMem:

  Shortcut routine to unpack ark_mem and step_mem structures from
  void* pointer.  If either is missing it returns ARK_MEM_NULL.
  ---------------------------------------------------------------*/
int sprkStep_AccessStepMem(void* arkode_mem, const char* fname,
                           ARKodeMem* ark_mem, ARKodeSPRKStepMem* step_mem)
{
  /* access ARKodeMem structure */
  if (arkode_mem == NULL)
  {
    arkProcessError(NULL, ARK_MEM_NULL, "ARKODE::SPRKStep", fname,
                    MSG_ARK_NO_MEM);
    return (ARK_MEM_NULL);
  }
  *ark_mem = (ARKodeMem)arkode_mem;
  if ((*ark_mem)->step_mem == NULL)
  {
    arkProcessError(*ark_mem, ARK_MEM_NULL, "ARKODE::SPRKStep", fname,
                    MSG_SPRKSTEP_NO_MEM);
    return (ARK_MEM_NULL);
  }
  *step_mem = (ARKodeSPRKStepMem)(*ark_mem)->step_mem;
  return (ARK_SUCCESS);
}

/*---------------------------------------------------------------
  sprkStep_CheckNVector:

  This routine checks if all required vector operations are
  present.  If any of them is missing it returns SUNFALSE.
  ---------------------------------------------------------------*/
booleantype sprkStep_CheckNVector(N_Vector tmpl)
{
  if ((tmpl->ops->nvclone == NULL) || (tmpl->ops->nvdestroy == NULL) ||
      (tmpl->ops->nvlinearsum == NULL) || (tmpl->ops->nvconst == NULL) ||
      (tmpl->ops->nvscale == NULL) || (tmpl->ops->nvwrmsnorm == NULL))
    return (SUNFALSE);
  return (SUNTRUE);
}