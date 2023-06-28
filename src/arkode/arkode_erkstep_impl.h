/*---------------------------------------------------------------
 * Programmer(s): Daniel R. Reynolds @ SMU
 *---------------------------------------------------------------
 * SUNDIALS Copyright Start
 * Copyright (c) 2002-2023, Lawrence Livermore National Security
 * and Southern Methodist University.
 * All rights reserved.
 *
 * See the top-level LICENSE and NOTICE files for details.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 * SUNDIALS Copyright End
 *---------------------------------------------------------------
 * Implementation header file for ARKODE's ERK time stepper
 * module.
 *--------------------------------------------------------------*/

#ifndef _ARKODE_ERKSTEP_IMPL_H
#define _ARKODE_ERKSTEP_IMPL_H

#include <arkode/arkode_erkstep.h>
#include "arkode_impl.h"

/* access to MRIStepInnerStepper_Create */
#include "arkode/arkode_mristep.h"

#ifdef __cplusplus  /* wrapper to enable C++ usage */
extern "C" {
#endif

/*===============================================================
  ERK time step module constants -- move many items here from
  arkode_impl.h
  ===============================================================*/



/*===============================================================
  ERK time step module data structure
  ===============================================================*/

/*---------------------------------------------------------------
  Types : struct ARKodeERKStepMemRec, ARKodeERKStepMem
  ---------------------------------------------------------------
  The type ARKodeERKStepMem is type pointer to struct
  ARKodeERKStepMemRec.  This structure contains fields to
  perform an explicit Runge-Kutta time step.
  ---------------------------------------------------------------*/
typedef struct ARKodeERKStepMemRec {

  /* ERK problem specification */
  ARKRhsFn f;             /* y' = f(t,y)                */

  /* ARK method storage and parameters */
  N_Vector *F;            /* explicit RHS at each stage */
  int q;                  /* method order               */
  int p;                  /* embedding order            */
  int stages;             /* number of stages           */
  ARKodeButcherTable B;   /* ERK Butcher table          */

  /* Counters */
  long int nfe;           /* num fe calls               */

  /* Reusable arrays for fused vector operations */
  realtype* cvals;
  N_Vector* Xvecs;
  int       nfusedopvecs;  /* length of cvals and Xvecs arrays */

  /* Data for using ERKStep with external polynomial forcing */
  realtype    tshift;      /* time normalization shift    */
  realtype    tscale;      /* time normalization scaling  */
  N_Vector*   forcing;     /* array of forcing vectors    */
  int         nforcing;    /* number of forcing vectors   */

} *ARKodeERKStepMem;


/*===============================================================
  ERK time step module private function prototypes
  ===============================================================*/

/* Interface routines supplied to ARKODE */
int erkStep_Init(void* arkode_mem, int init_type);
int erkStep_FullRHS(void* arkode_mem, realtype t,
                    N_Vector y, N_Vector f, int mode);
int erkStep_TakeStep(void* arkode_mem, realtype *dsmPtr, int *nflagPtr);

/* Internal utility routines */
int erkStep_AccessStepMem(void* arkode_mem, const char *fname,
                          ARKodeMem *ark_mem, ARKodeERKStepMem *step_mem);
booleantype erkStep_CheckNVector(N_Vector tmpl);
int erkStep_SetButcherTable(ARKodeMem ark_mem);
int erkStep_CheckButcherTable(ARKodeMem ark_mem);
int erkStep_ComputeSolutions(ARKodeMem ark_mem, realtype *dsm);
void erkStep_ApplyForcing(ARKodeERKStepMem step_mem, realtype t,
                          realtype s, int *nvec);

/* private functions for interfacing with MRIStep */
int erkStep_SetInnerForcing(void* arkode_mem, realtype tshift, realtype tscale,
                            N_Vector *f, int nvecs);
int erkStep_MRIStepInnerEvolve(MRIStepInnerStepper stepper,
                               realtype t0, realtype tout, N_Vector y);
int erkStep_MRIStepInnerFullRhs(MRIStepInnerStepper stepper, realtype t,
                                N_Vector y, N_Vector f, int mode);
int erkStep_MRIStepInnerReset(MRIStepInnerStepper stepper, realtype tR,
                              N_Vector yR);

/*===============================================================
  Reusable ERKStep Error Messages
  ===============================================================*/

/* Initialization and I/O error messages */
#define MSG_ERKSTEP_NO_MEM    "Time step module memory is NULL."

#ifdef __cplusplus
}
#endif

#endif
