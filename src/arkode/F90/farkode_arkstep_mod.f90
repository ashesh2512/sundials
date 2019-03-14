! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.0.0
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! ---------------------------------------------------------------
! Programmer(s): Auto-generated by swig.
! ---------------------------------------------------------------
! SUNDIALS Copyright Start
! Copyright (c) 2002-2019, Lawrence Livermore National Security
! and Southern Methodist University.
! All rights reserved.
!
! See the top-level LICENSE and NOTICE files for details.
!
! SPDX-License-Identifier: BSD-3-Clause
! SUNDIALS Copyright End
! ---------------------------------------------------------------

module farkode_arkstep_mod
 use, intrinsic :: ISO_C_BINDING
 use farkode_mod
 use fsundials_types
 implicit none
 private

 ! PUBLIC METHODS AND TYPES
 public :: FARKStepCreate
 public :: FARKStepResize
 public :: FARKStepReInit
 public :: FARKStepSStolerances
 public :: FARKStepSVtolerances
 public :: FARKStepWFtolerances
 public :: FARKStepResStolerance
 public :: FARKStepResVtolerance
 public :: FARKStepResFtolerance
 public :: FARKStepSetLinearSolver
 public :: FARKStepSetMassLinearSolver
 public :: FARKStepRootInit
 public :: FARKStepSetDefaults
 public :: FARKStepSetOptimalParams
 public :: FARKStepSetOrder
 public :: FARKStepSetDenseOrder
 public :: FARKStepSetNonlinearSolver
 public :: FARKStepSetLinear
 public :: FARKStepSetNonlinear
 public :: FARKStepSetExplicit
 public :: FARKStepSetImplicit
 public :: FARKStepSetImEx
 public :: FARKStepSetTables
 public :: FARKStepSetTableNum
 public :: FARKStepSetCFLFraction
 public :: FARKStepSetSafetyFactor
 public :: FARKStepSetErrorBias
 public :: FARKStepSetMaxGrowth
 public :: FARKStepSetFixedStepBounds
 public :: FARKStepSetAdaptivityMethod
 public :: FARKStepSetAdaptivityFn
 public :: FARKStepSetMaxFirstGrowth
 public :: FARKStepSetMaxEFailGrowth
 public :: FARKStepSetSmallNumEFails
 public :: FARKStepSetMaxCFailGrowth
 public :: FARKStepSetNonlinCRDown
 public :: FARKStepSetNonlinRDiv
 public :: FARKStepSetDeltaGammaMax
 public :: FARKStepSetMaxStepsBetweenLSet
 public :: FARKStepSetPredictorMethod
 public :: FARKStepSetStabilityFn
 public :: FARKStepSetMaxErrTestFails
 public :: FARKStepSetMaxNonlinIters
 public :: FARKStepSetMaxConvFails
 public :: FARKStepSetNonlinConvCoef
 public :: FARKStepSetMaxNumSteps
 public :: FARKStepSetMaxHnilWarns
 public :: FARKStepSetInitStep
 public :: FARKStepSetMinStep
 public :: FARKStepSetMaxStep
 public :: FARKStepSetStopTime
 public :: FARKStepSetFixedStep
 public :: FARKStepSetRootDirection
 public :: FARKStepSetNoInactiveRootWarn
 public :: FARKStepSetErrHandlerFn
 public :: FARKStepSetErrFile
 public :: FARKStepSetUserData
 public :: FARKStepSetDiagnostics
 public :: FARKStepSetPostprocessStepFn
 public :: FARKStepSetJacFn
 public :: FARKStepSetMassFn
 public :: FARKStepSetMaxStepsBetweenJac
 public :: FARKStepSetEpsLin
 public :: FARKStepSetMassEpsLin
 public :: FARKStepSetPreconditioner
 public :: FARKStepSetMassPreconditioner
 public :: FARKStepSetJacTimes
 public :: FARKStepSetMassTimes
 public :: FARKStepEvolve
 public :: FARKStepGetDky
 public :: FARKStepGetNumExpSteps
 public :: FARKStepGetNumAccSteps
 public :: FARKStepGetNumStepAttempts
 public :: FARKStepGetNumRhsEvals
 public :: FARKStepGetNumLinSolvSetups
 public :: FARKStepGetNumErrTestFails
 public :: FARKStepGetCurrentButcherTables
 public :: FARKStepGetEstLocalErrors
 public :: FARKStepGetWorkSpace
 public :: FARKStepGetNumSteps
 public :: FARKStepGetActualInitStep
 public :: FARKStepGetLastStep
 public :: FARKStepGetCurrentStep
 public :: FARKStepGetCurrentTime
 public :: FARKStepGetTolScaleFactor
 public :: FARKStepGetErrWeights
 public :: FARKStepGetResWeights
 public :: FARKStepGetNumGEvals
 public :: FARKStepGetRootInfo
 public :: FARKStepGetReturnFlagName
 public :: FARKStepWriteParameters
 public :: FARKStepWriteButcher
 public :: FARKStepGetTimestepperStats
 public :: FARKStepGetStepStats
 public :: FARKStepGetNumNonlinSolvIters
 public :: FARKStepGetNumNonlinSolvConvFails
 public :: FARKStepGetNonlinSolvStats
 public :: FARKStepGetLinWorkSpace
 public :: FARKStepGetNumJacEvals
 public :: FARKStepGetNumPrecEvals
 public :: FARKStepGetNumPrecSolves
 public :: FARKStepGetNumLinIters
 public :: FARKStepGetNumLinConvFails
 public :: FARKStepGetNumJTSetupEvals
 public :: FARKStepGetNumJtimesEvals
 public :: FARKStepGetNumLinRhsEvals
 public :: FARKStepGetLastLinFlag
 public :: FARKStepGetMassWorkSpace
 public :: FARKStepGetNumMassSetups
 public :: FARKStepGetNumMassMult
 public :: FARKStepGetNumMassSolves
 public :: FARKStepGetNumMassPrecEvals
 public :: FARKStepGetNumMassPrecSolves
 public :: FARKStepGetNumMassIters
 public :: FARKStepGetNumMassConvFails
 public :: FARKStepGetNumMTSetups
 public :: FARKStepGetLastMassFlag
 public :: FARKStepGetLinReturnFlagName
 public :: FARKStepFree
 public :: FARKStepPrintMem

 ! PARAMETERS
 integer(C_INT), parameter, public :: DEFAULT_ERK_2 = 0_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ERK_3 = 1_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ERK_4 = 3_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ERK_5 = 6_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ERK_6 = 10_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ERK_8 = 11_C_INT
 integer(C_INT), parameter, public :: DEFAULT_DIRK_2 = 100_C_INT
 integer(C_INT), parameter, public :: DEFAULT_DIRK_3 = 104_C_INT
 integer(C_INT), parameter, public :: DEFAULT_DIRK_4 = 107_C_INT
 integer(C_INT), parameter, public :: DEFAULT_DIRK_5 = 111_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ETABLE_3 = 2_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ETABLE_4 = 4_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ETABLE_5 = 9_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ITABLE_3 = 104_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ITABLE_4 = 109_C_INT
 integer(C_INT), parameter, public :: DEFAULT_ARK_ITABLE_5 = 111_C_INT

 ! WRAPPER DECLARATIONS
 interface
function FARKStepCreate(fe, fi, t0, y0) &
bind(C, name="ARKStepCreate") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_FUNPTR), value :: fe
type(C_FUNPTR), value :: fi
real(C_DOUBLE), value :: t0
type(C_PTR), value :: y0
type(C_PTR) :: fresult
end function

function FARKStepResize(arkode_mem, ynew, hscale, t0, resize, resize_data) &
bind(C, name="ARKStepResize") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: ynew
real(C_DOUBLE), value :: hscale
real(C_DOUBLE), value :: t0
type(C_FUNPTR), value :: resize
type(C_PTR), value :: resize_data
integer(C_INT) :: fresult
end function

function FARKStepReInit(arkode_mem, fe, fi, t0, y0) &
bind(C, name="ARKStepReInit") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: fe
type(C_FUNPTR), value :: fi
real(C_DOUBLE), value :: t0
type(C_PTR), value :: y0
integer(C_INT) :: fresult
end function

function FARKStepSStolerances(arkode_mem, reltol, abstol) &
bind(C, name="ARKStepSStolerances") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: reltol
real(C_DOUBLE), value :: abstol
integer(C_INT) :: fresult
end function

function FARKStepSVtolerances(arkode_mem, reltol, abstol) &
bind(C, name="ARKStepSVtolerances") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: reltol
type(C_PTR), value :: abstol
integer(C_INT) :: fresult
end function

function FARKStepWFtolerances(arkode_mem, efun) &
bind(C, name="ARKStepWFtolerances") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: efun
integer(C_INT) :: fresult
end function

function FARKStepResStolerance(arkode_mem, rabstol) &
bind(C, name="ARKStepResStolerance") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: rabstol
integer(C_INT) :: fresult
end function

function FARKStepResVtolerance(arkode_mem, rabstol) &
bind(C, name="ARKStepResVtolerance") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: rabstol
integer(C_INT) :: fresult
end function

function FARKStepResFtolerance(arkode_mem, rfun) &
bind(C, name="ARKStepResFtolerance") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: rfun
integer(C_INT) :: fresult
end function

function FARKStepSetLinearSolver(arkode_mem, ls, a) &
bind(C, name="ARKStepSetLinearSolver") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: ls
type(C_PTR), value :: a
integer(C_INT) :: fresult
end function

function FARKStepSetMassLinearSolver(arkode_mem, ls, m, time_dep) &
bind(C, name="ARKStepSetMassLinearSolver") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: ls
type(C_PTR), value :: m
logical(C_BOOL), value :: time_dep
integer(C_INT) :: fresult
end function

function FARKStepRootInit(arkode_mem, nrtfn, g) &
bind(C, name="ARKStepRootInit") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: nrtfn
type(C_FUNPTR), value :: g
integer(C_INT) :: fresult
end function

function FARKStepSetDefaults(arkode_mem) &
bind(C, name="ARKStepSetDefaults") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetOptimalParams(arkode_mem) &
bind(C, name="ARKStepSetOptimalParams") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetOrder(arkode_mem, maxord) &
bind(C, name="ARKStepSetOrder") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: maxord
integer(C_INT) :: fresult
end function

function FARKStepSetDenseOrder(arkode_mem, dord) &
bind(C, name="ARKStepSetDenseOrder") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: dord
integer(C_INT) :: fresult
end function

function FARKStepSetNonlinearSolver(arkode_mem, nls) &
bind(C, name="ARKStepSetNonlinearSolver") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: nls
integer(C_INT) :: fresult
end function

function FARKStepSetLinear(arkode_mem, timedepend) &
bind(C, name="ARKStepSetLinear") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: timedepend
integer(C_INT) :: fresult
end function

function FARKStepSetNonlinear(arkode_mem) &
bind(C, name="ARKStepSetNonlinear") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetExplicit(arkode_mem) &
bind(C, name="ARKStepSetExplicit") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetImplicit(arkode_mem) &
bind(C, name="ARKStepSetImplicit") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetImEx(arkode_mem) &
bind(C, name="ARKStepSetImEx") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetTables(arkode_mem, q, p, bi, be) &
bind(C, name="ARKStepSetTables") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: q
integer(C_INT), value :: p
type(C_PTR), value :: bi
type(C_PTR), value :: be
integer(C_INT) :: fresult
end function

function FARKStepSetTableNum(arkode_mem, itable, etable) &
bind(C, name="ARKStepSetTableNum") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: itable
integer(C_INT), value :: etable
integer(C_INT) :: fresult
end function

function FARKStepSetCFLFraction(arkode_mem, cfl_frac) &
bind(C, name="ARKStepSetCFLFraction") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: cfl_frac
integer(C_INT) :: fresult
end function

function FARKStepSetSafetyFactor(arkode_mem, safety) &
bind(C, name="ARKStepSetSafetyFactor") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: safety
integer(C_INT) :: fresult
end function

function FARKStepSetErrorBias(arkode_mem, bias) &
bind(C, name="ARKStepSetErrorBias") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: bias
integer(C_INT) :: fresult
end function

function FARKStepSetMaxGrowth(arkode_mem, mx_growth) &
bind(C, name="ARKStepSetMaxGrowth") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: mx_growth
integer(C_INT) :: fresult
end function

function FARKStepSetFixedStepBounds(arkode_mem, lb, ub) &
bind(C, name="ARKStepSetFixedStepBounds") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: lb
real(C_DOUBLE), value :: ub
integer(C_INT) :: fresult
end function

function FARKStepSetAdaptivityMethod(arkode_mem, imethod, idefault, pq, adapt_params) &
bind(C, name="ARKStepSetAdaptivityMethod") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: imethod
integer(C_INT), value :: idefault
integer(C_INT), value :: pq
type(C_PTR) :: adapt_params
integer(C_INT) :: fresult
end function

function FARKStepSetAdaptivityFn(arkode_mem, hfun, h_data) &
bind(C, name="ARKStepSetAdaptivityFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: hfun
type(C_PTR), value :: h_data
integer(C_INT) :: fresult
end function

function FARKStepSetMaxFirstGrowth(arkode_mem, etamx1) &
bind(C, name="ARKStepSetMaxFirstGrowth") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: etamx1
integer(C_INT) :: fresult
end function

function FARKStepSetMaxEFailGrowth(arkode_mem, etamxf) &
bind(C, name="ARKStepSetMaxEFailGrowth") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: etamxf
integer(C_INT) :: fresult
end function

function FARKStepSetSmallNumEFails(arkode_mem, small_nef) &
bind(C, name="ARKStepSetSmallNumEFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: small_nef
integer(C_INT) :: fresult
end function

function FARKStepSetMaxCFailGrowth(arkode_mem, etacf) &
bind(C, name="ARKStepSetMaxCFailGrowth") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: etacf
integer(C_INT) :: fresult
end function

function FARKStepSetNonlinCRDown(arkode_mem, crdown) &
bind(C, name="ARKStepSetNonlinCRDown") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: crdown
integer(C_INT) :: fresult
end function

function FARKStepSetNonlinRDiv(arkode_mem, rdiv) &
bind(C, name="ARKStepSetNonlinRDiv") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: rdiv
integer(C_INT) :: fresult
end function

function FARKStepSetDeltaGammaMax(arkode_mem, dgmax) &
bind(C, name="ARKStepSetDeltaGammaMax") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: dgmax
integer(C_INT) :: fresult
end function

function FARKStepSetMaxStepsBetweenLSet(arkode_mem, msbp) &
bind(C, name="ARKStepSetMaxStepsBetweenLSet") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: msbp
integer(C_INT) :: fresult
end function

function FARKStepSetPredictorMethod(arkode_mem, method) &
bind(C, name="ARKStepSetPredictorMethod") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: method
integer(C_INT) :: fresult
end function

function FARKStepSetStabilityFn(arkode_mem, estab, estab_data) &
bind(C, name="ARKStepSetStabilityFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: estab
type(C_PTR), value :: estab_data
integer(C_INT) :: fresult
end function

function FARKStepSetMaxErrTestFails(arkode_mem, maxnef) &
bind(C, name="ARKStepSetMaxErrTestFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: maxnef
integer(C_INT) :: fresult
end function

function FARKStepSetMaxNonlinIters(arkode_mem, maxcor) &
bind(C, name="ARKStepSetMaxNonlinIters") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: maxcor
integer(C_INT) :: fresult
end function

function FARKStepSetMaxConvFails(arkode_mem, maxncf) &
bind(C, name="ARKStepSetMaxConvFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: maxncf
integer(C_INT) :: fresult
end function

function FARKStepSetNonlinConvCoef(arkode_mem, nlscoef) &
bind(C, name="ARKStepSetNonlinConvCoef") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: nlscoef
integer(C_INT) :: fresult
end function

function FARKStepSetMaxNumSteps(arkode_mem, mxsteps) &
bind(C, name="ARKStepSetMaxNumSteps") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG), value :: mxsteps
integer(C_INT) :: fresult
end function

function FARKStepSetMaxHnilWarns(arkode_mem, mxhnil) &
bind(C, name="ARKStepSetMaxHnilWarns") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT), value :: mxhnil
integer(C_INT) :: fresult
end function

function FARKStepSetInitStep(arkode_mem, hin) &
bind(C, name="ARKStepSetInitStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: hin
integer(C_INT) :: fresult
end function

function FARKStepSetMinStep(arkode_mem, hmin) &
bind(C, name="ARKStepSetMinStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: hmin
integer(C_INT) :: fresult
end function

function FARKStepSetMaxStep(arkode_mem, hmax) &
bind(C, name="ARKStepSetMaxStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: hmax
integer(C_INT) :: fresult
end function

function FARKStepSetStopTime(arkode_mem, tstop) &
bind(C, name="ARKStepSetStopTime") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: tstop
integer(C_INT) :: fresult
end function

function FARKStepSetFixedStep(arkode_mem, hfixed) &
bind(C, name="ARKStepSetFixedStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: hfixed
integer(C_INT) :: fresult
end function

function FARKStepSetRootDirection(arkode_mem, rootdir) &
bind(C, name="ARKStepSetRootDirection") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: rootdir
integer(C_INT) :: fresult
end function

function FARKStepSetNoInactiveRootWarn(arkode_mem) &
bind(C, name="ARKStepSetNoInactiveRootWarn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: fresult
end function

function FARKStepSetErrHandlerFn(arkode_mem, ehfun, eh_data) &
bind(C, name="ARKStepSetErrHandlerFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: ehfun
type(C_PTR), value :: eh_data
integer(C_INT) :: fresult
end function

function FARKStepSetErrFile(arkode_mem, errfp) &
bind(C, name="ARKStepSetErrFile") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: errfp
integer(C_INT) :: fresult
end function

function FARKStepSetUserData(arkode_mem, user_data) &
bind(C, name="ARKStepSetUserData") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: user_data
integer(C_INT) :: fresult
end function

function FARKStepSetDiagnostics(arkode_mem, diagfp) &
bind(C, name="ARKStepSetDiagnostics") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: diagfp
integer(C_INT) :: fresult
end function

function FARKStepSetPostprocessStepFn(arkode_mem, processstep) &
bind(C, name="ARKStepSetPostprocessStepFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: processstep
integer(C_INT) :: fresult
end function

function FARKStepSetJacFn(arkode_mem, jac) &
bind(C, name="ARKStepSetJacFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: jac
integer(C_INT) :: fresult
end function

function FARKStepSetMassFn(arkode_mem, mass) &
bind(C, name="ARKStepSetMassFn") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: mass
integer(C_INT) :: fresult
end function

function FARKStepSetMaxStepsBetweenJac(arkode_mem, msbj) &
bind(C, name="ARKStepSetMaxStepsBetweenJac") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG), value :: msbj
integer(C_INT) :: fresult
end function

function FARKStepSetEpsLin(arkode_mem, eplifac) &
bind(C, name="ARKStepSetEpsLin") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: eplifac
integer(C_INT) :: fresult
end function

function FARKStepSetMassEpsLin(arkode_mem, eplifac) &
bind(C, name="ARKStepSetMassEpsLin") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: eplifac
integer(C_INT) :: fresult
end function

function FARKStepSetPreconditioner(arkode_mem, psetup, psolve) &
bind(C, name="ARKStepSetPreconditioner") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: psetup
type(C_FUNPTR), value :: psolve
integer(C_INT) :: fresult
end function

function FARKStepSetMassPreconditioner(arkode_mem, psetup, psolve) &
bind(C, name="ARKStepSetMassPreconditioner") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: psetup
type(C_FUNPTR), value :: psolve
integer(C_INT) :: fresult
end function

function FARKStepSetJacTimes(arkode_mem, jtsetup, jtimes) &
bind(C, name="ARKStepSetJacTimes") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: jtsetup
type(C_FUNPTR), value :: jtimes
integer(C_INT) :: fresult
end function

function FARKStepSetMassTimes(arkode_mem, msetup, mtimes, mtimes_data) &
bind(C, name="ARKStepSetMassTimes") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_FUNPTR), value :: msetup
type(C_FUNPTR), value :: mtimes
type(C_PTR), value :: mtimes_data
integer(C_INT) :: fresult
end function

function FARKStepEvolve(arkode_mem, tout, yout, tret, itask) &
bind(C, name="ARKStepEvolve") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: tout
type(C_PTR), value :: yout
real(C_DOUBLE) :: tret
integer(C_INT), value :: itask
integer(C_INT) :: fresult
end function

function FARKStepGetDky(arkode_mem, t, k, dky) &
bind(C, name="ARKStepGetDky") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE), value :: t
integer(C_INT), value :: k
type(C_PTR), value :: dky
integer(C_INT) :: fresult
end function

function FARKStepGetNumExpSteps(arkode_mem, expsteps) &
bind(C, name="ARKStepGetNumExpSteps") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: expsteps
integer(C_INT) :: fresult
end function

function FARKStepGetNumAccSteps(arkode_mem, accsteps) &
bind(C, name="ARKStepGetNumAccSteps") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: accsteps
integer(C_INT) :: fresult
end function

function FARKStepGetNumStepAttempts(arkode_mem, step_attempts) &
bind(C, name="ARKStepGetNumStepAttempts") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: step_attempts
integer(C_INT) :: fresult
end function

function FARKStepGetNumRhsEvals(arkode_mem, nfe_evals, nfi_evals) &
bind(C, name="ARKStepGetNumRhsEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nfe_evals
integer(C_LONG) :: nfi_evals
integer(C_INT) :: fresult
end function

function FARKStepGetNumLinSolvSetups(arkode_mem, nlinsetups) &
bind(C, name="ARKStepGetNumLinSolvSetups") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nlinsetups
integer(C_INT) :: fresult
end function

function FARKStepGetNumErrTestFails(arkode_mem, netfails) &
bind(C, name="ARKStepGetNumErrTestFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: netfails
integer(C_INT) :: fresult
end function

function FARKStepGetCurrentButcherTables(arkode_mem, bi, be) &
bind(C, name="ARKStepGetCurrentButcherTables") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: bi
type(C_PTR), value :: be
integer(C_INT) :: fresult
end function

function FARKStepGetEstLocalErrors(arkode_mem, ele) &
bind(C, name="ARKStepGetEstLocalErrors") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: ele
integer(C_INT) :: fresult
end function

function FARKStepGetWorkSpace(arkode_mem, lenrw, leniw) &
bind(C, name="ARKStepGetWorkSpace") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: lenrw
integer(C_LONG) :: leniw
integer(C_INT) :: fresult
end function

function FARKStepGetNumSteps(arkode_mem, nsteps) &
bind(C, name="ARKStepGetNumSteps") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nsteps
integer(C_INT) :: fresult
end function

function FARKStepGetActualInitStep(arkode_mem, hinused) &
bind(C, name="ARKStepGetActualInitStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE) :: hinused
integer(C_INT) :: fresult
end function

function FARKStepGetLastStep(arkode_mem, hlast) &
bind(C, name="ARKStepGetLastStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE) :: hlast
integer(C_INT) :: fresult
end function

function FARKStepGetCurrentStep(arkode_mem, hcur) &
bind(C, name="ARKStepGetCurrentStep") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE) :: hcur
integer(C_INT) :: fresult
end function

function FARKStepGetCurrentTime(arkode_mem, tcur) &
bind(C, name="ARKStepGetCurrentTime") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE) :: tcur
integer(C_INT) :: fresult
end function

function FARKStepGetTolScaleFactor(arkode_mem, tolsfac) &
bind(C, name="ARKStepGetTolScaleFactor") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
real(C_DOUBLE) :: tolsfac
integer(C_INT) :: fresult
end function

function FARKStepGetErrWeights(arkode_mem, eweight) &
bind(C, name="ARKStepGetErrWeights") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: eweight
integer(C_INT) :: fresult
end function

function FARKStepGetResWeights(arkode_mem, rweight) &
bind(C, name="ARKStepGetResWeights") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: rweight
integer(C_INT) :: fresult
end function

function FARKStepGetNumGEvals(arkode_mem, ngevals) &
bind(C, name="ARKStepGetNumGEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: ngevals
integer(C_INT) :: fresult
end function

function FARKStepGetRootInfo(arkode_mem, rootsfound) &
bind(C, name="ARKStepGetRootInfo") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_INT) :: rootsfound
integer(C_INT) :: fresult
end function

function FARKStepGetReturnFlagName(flag) &
bind(C, name="ARKStepGetReturnFlagName") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_LONG), value :: flag
type(C_PTR) :: fresult
end function

function FARKStepWriteParameters(arkode_mem, fp) &
bind(C, name="ARKStepWriteParameters") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: fp
integer(C_INT) :: fresult
end function

function FARKStepWriteButcher(arkode_mem, fp) &
bind(C, name="ARKStepWriteButcher") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: fp
integer(C_INT) :: fresult
end function

function FARKStepGetTimestepperStats(arkode_mem, expsteps, accsteps, step_attempts, nfe_evals, nfi_evals, nlinsetups, &
  netfails) &
bind(C, name="ARKStepGetTimestepperStats") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: expsteps
integer(C_LONG) :: accsteps
integer(C_LONG) :: step_attempts
integer(C_LONG) :: nfe_evals
integer(C_LONG) :: nfi_evals
integer(C_LONG) :: nlinsetups
integer(C_LONG) :: netfails
integer(C_INT) :: fresult
end function

function FARKStepGetStepStats(arkode_mem, nsteps, hinused, hlast, hcur, tcur) &
bind(C, name="ARKStepGetStepStats") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nsteps
real(C_DOUBLE) :: hinused
real(C_DOUBLE) :: hlast
real(C_DOUBLE) :: hcur
real(C_DOUBLE) :: tcur
integer(C_INT) :: fresult
end function

function FARKStepGetNumNonlinSolvIters(arkode_mem, nniters) &
bind(C, name="ARKStepGetNumNonlinSolvIters") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nniters
integer(C_INT) :: fresult
end function

function FARKStepGetNumNonlinSolvConvFails(arkode_mem, nncfails) &
bind(C, name="ARKStepGetNumNonlinSolvConvFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nncfails
integer(C_INT) :: fresult
end function

function FARKStepGetNonlinSolvStats(arkode_mem, nniters, nncfails) &
bind(C, name="ARKStepGetNonlinSolvStats") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nniters
integer(C_LONG) :: nncfails
integer(C_INT) :: fresult
end function

function FARKStepGetLinWorkSpace(arkode_mem, lenrwls, leniwls) &
bind(C, name="ARKStepGetLinWorkSpace") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: lenrwls
integer(C_LONG) :: leniwls
integer(C_INT) :: fresult
end function

function FARKStepGetNumJacEvals(arkode_mem, njevals) &
bind(C, name="ARKStepGetNumJacEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: njevals
integer(C_INT) :: fresult
end function

function FARKStepGetNumPrecEvals(arkode_mem, npevals) &
bind(C, name="ARKStepGetNumPrecEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: npevals
integer(C_INT) :: fresult
end function

function FARKStepGetNumPrecSolves(arkode_mem, npsolves) &
bind(C, name="ARKStepGetNumPrecSolves") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: npsolves
integer(C_INT) :: fresult
end function

function FARKStepGetNumLinIters(arkode_mem, nliters) &
bind(C, name="ARKStepGetNumLinIters") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nliters
integer(C_INT) :: fresult
end function

function FARKStepGetNumLinConvFails(arkode_mem, nlcfails) &
bind(C, name="ARKStepGetNumLinConvFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nlcfails
integer(C_INT) :: fresult
end function

function FARKStepGetNumJTSetupEvals(arkode_mem, njtsetups) &
bind(C, name="ARKStepGetNumJTSetupEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: njtsetups
integer(C_INT) :: fresult
end function

function FARKStepGetNumJtimesEvals(arkode_mem, njvevals) &
bind(C, name="ARKStepGetNumJtimesEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: njvevals
integer(C_INT) :: fresult
end function

function FARKStepGetNumLinRhsEvals(arkode_mem, nfevalsls) &
bind(C, name="ARKStepGetNumLinRhsEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nfevalsls
integer(C_INT) :: fresult
end function

function FARKStepGetLastLinFlag(arkode_mem, flag) &
bind(C, name="ARKStepGetLastLinFlag") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: flag
integer(C_INT) :: fresult
end function

function FARKStepGetMassWorkSpace(arkode_mem, lenrwmls, leniwmls) &
bind(C, name="ARKStepGetMassWorkSpace") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: lenrwmls
integer(C_LONG) :: leniwmls
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassSetups(arkode_mem, nmsetups) &
bind(C, name="ARKStepGetNumMassSetups") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmsetups
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassMult(arkode_mem, nmvevals) &
bind(C, name="ARKStepGetNumMassMult") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmvevals
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassSolves(arkode_mem, nmsolves) &
bind(C, name="ARKStepGetNumMassSolves") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmsolves
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassPrecEvals(arkode_mem, nmpevals) &
bind(C, name="ARKStepGetNumMassPrecEvals") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmpevals
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassPrecSolves(arkode_mem, nmpsolves) &
bind(C, name="ARKStepGetNumMassPrecSolves") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmpsolves
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassIters(arkode_mem, nmiters) &
bind(C, name="ARKStepGetNumMassIters") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmiters
integer(C_INT) :: fresult
end function

function FARKStepGetNumMassConvFails(arkode_mem, nmcfails) &
bind(C, name="ARKStepGetNumMassConvFails") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmcfails
integer(C_INT) :: fresult
end function

function FARKStepGetNumMTSetups(arkode_mem, nmtsetups) &
bind(C, name="ARKStepGetNumMTSetups") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: nmtsetups
integer(C_INT) :: fresult
end function

function FARKStepGetLastMassFlag(arkode_mem, flag) &
bind(C, name="ARKStepGetLastMassFlag") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
integer(C_LONG) :: flag
integer(C_INT) :: fresult
end function

function FARKStepGetLinReturnFlagName(flag) &
bind(C, name="ARKStepGetLinReturnFlagName") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_LONG), value :: flag
type(C_PTR) :: fresult
end function

subroutine FARKStepFree(arkode_mem) &
bind(C, name="ARKStepFree")
use, intrinsic :: ISO_C_BINDING
type(C_PTR) :: arkode_mem
end subroutine

subroutine FARKStepPrintMem(arkode_mem, outfile) &
bind(C, name="ARKStepPrintMem")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: arkode_mem
type(C_PTR), value :: outfile
end subroutine

 end interface


end module
