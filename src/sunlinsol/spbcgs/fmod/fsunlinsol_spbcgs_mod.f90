! This file was automatically generated by SWIG (http://www.swig.org).
! Version 4.0.0
!
! Do not make changes to this file unless you know what you are doing--modify
! the SWIG interface file instead.

! ---------------------------------------------------------------
! Programmer(s): Auto-generated by swig.
! ---------------------------------------------------------------
! SUNDIALS Copyright Start
! Copyright (c) 2002-2023, Lawrence Livermore National Security
! and Southern Methodist University.
! All rights reserved.
!
! See the top-level LICENSE and NOTICE files for details.
!
! SPDX-License-Identifier: BSD-3-Clause
! SUNDIALS Copyright End
! ---------------------------------------------------------------

module fsunlinsol_spbcgs_mod
 use, intrinsic :: ISO_C_BINDING
 use fsundials_types_mod
 use fsundials_linearsolver_mod
 use fsundials_context_mod
 use fsundials_types_mod
 use fsundials_nvector_mod
 use fsundials_context_mod
 use fsundials_types_mod
 use fsundials_matrix_mod
 use fsundials_nvector_mod
 use fsundials_context_mod
 use fsundials_types_mod
 implicit none
 private

 ! DECLARATION CONSTRUCTS
 integer(C_INT), parameter, public :: SUNSPBCGS_MAXL_DEFAULT = 5_C_INT
 public :: FSUNLinSol_SPBCGS
 public :: FSUNLinSol_SPBCGSSetPrecType
 public :: FSUNLinSol_SPBCGSSetMaxl
 public :: FSUNLinSolGetType_SPBCGS
 public :: FSUNLinSolGetID_SPBCGS
 public :: FSUNLinSolInitialize_SPBCGS
 public :: FSUNLinSolSetATimes_SPBCGS
 public :: FSUNLinSolSetPreconditioner_SPBCGS
 public :: FSUNLinSolSetScalingVectors_SPBCGS
 public :: FSUNLinSolSetZeroGuess_SPBCGS
 public :: FSUNLinSolSetup_SPBCGS
 public :: FSUNLinSolSolve_SPBCGS
 public :: FSUNLinSolNumIters_SPBCGS
 public :: FSUNLinSolResNorm_SPBCGS
 public :: FSUNLinSolResid_SPBCGS
 public :: FSUNLinSolLastFlag_SPBCGS
 public :: FSUNLinSolSpace_SPBCGS
 public :: FSUNLinSolDestroy_SPBCGS
 public :: FSUNLinSolFree_SPBCGS

! WRAPPER DECLARATIONS
interface
function swigc_FSUNLinSol_SPBCGS(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FSUNLinSol_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT), intent(in) :: farg3
type(C_PTR), value :: farg4
type(C_PTR) :: fresult
end function

function swigc_FSUNLinSol_SPBCGSSetPrecType(farg1, farg2) &
bind(C, name="_wrap_FSUNLinSol_SPBCGSSetPrecType") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSol_SPBCGSSetMaxl(farg1, farg2) &
bind(C, name="_wrap_FSUNLinSol_SPBCGSSetMaxl") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolGetType_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolGetType_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolGetID_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolGetID_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolInitialize_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolInitialize_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSetATimes_SPBCGS(farg1, farg2, farg3) &
bind(C, name="_wrap_FSUNLinSolSetATimes_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_FUNPTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSetPreconditioner_SPBCGS(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FSUNLinSolSetPreconditioner_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_FUNPTR), value :: farg3
type(C_FUNPTR), value :: farg4
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSetScalingVectors_SPBCGS(farg1, farg2, farg3) &
bind(C, name="_wrap_FSUNLinSolSetScalingVectors_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSetZeroGuess_SPBCGS(farg1, farg2) &
bind(C, name="_wrap_FSUNLinSolSetZeroGuess_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSetup_SPBCGS(farg1, farg2) &
bind(C, name="_wrap_FSUNLinSolSetup_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolSolve_SPBCGS(farg1, farg2, farg3, farg4, farg5) &
bind(C, name="_wrap_FSUNLinSolSolve_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
real(C_DOUBLE), intent(in) :: farg5
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolNumIters_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolNumIters_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolResNorm_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolResNorm_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
real(C_DOUBLE) :: fresult
end function

function swigc_FSUNLinSolResid_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolResid_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR) :: fresult
end function

function swigc_FSUNLinSolLastFlag_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolLastFlag_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT64_T) :: fresult
end function

function swigc_FSUNLinSolSpace_SPBCGS(farg1, farg2, farg3) &
bind(C, name="_wrap_FSUNLinSolSpace_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolDestroy_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolDestroy_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FSUNLinSolFree_SPBCGS(farg1) &
bind(C, name="_wrap_FSUNLinSolFree_SPBCGS") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

end interface


contains
 ! MODULE SUBPROGRAMS
function FSUNLinSol_SPBCGS(y, pretype, maxl, sunctx) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(SUNLinearSolver), pointer :: swig_result
type(N_Vector), target, intent(inout) :: y
integer(C_INT), intent(in) :: pretype
integer(C_INT), intent(in) :: maxl
type(C_PTR) :: sunctx
type(C_PTR) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 
integer(C_INT) :: farg3 
type(C_PTR) :: farg4 

farg1 = c_loc(y)
farg2 = pretype
farg3 = maxl
farg4 = sunctx
fresult = swigc_FSUNLinSol_SPBCGS(farg1, farg2, farg3, farg4)
call c_f_pointer(fresult, swig_result)
end function

function FSUNLinSol_SPBCGSSetPrecType(s, pretype) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT), intent(in) :: pretype
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(s)
farg2 = pretype
fresult = swigc_FSUNLinSol_SPBCGSSetPrecType(farg1, farg2)
swig_result = fresult
end function

function FSUNLinSol_SPBCGSSetMaxl(s, maxl) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT), intent(in) :: maxl
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(s)
farg2 = maxl
fresult = swigc_FSUNLinSol_SPBCGSSetMaxl(farg1, farg2)
swig_result = fresult
end function

function FSUNLinSolGetType_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(SUNLinearSolver_Type) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolGetType_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolGetID_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(SUNLinearSolver_ID) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolGetID_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolInitialize_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolInitialize_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolSetATimes_SPBCGS(s, a_data, atimes) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(C_PTR) :: a_data
type(C_FUNPTR), intent(in), value :: atimes
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_FUNPTR) :: farg3 

farg1 = c_loc(s)
farg2 = a_data
farg3 = atimes
fresult = swigc_FSUNLinSolSetATimes_SPBCGS(farg1, farg2, farg3)
swig_result = fresult
end function

function FSUNLinSolSetPreconditioner_SPBCGS(s, p_data, pset, psol) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(C_PTR) :: p_data
type(C_FUNPTR), intent(in), value :: pset
type(C_FUNPTR), intent(in), value :: psol
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_FUNPTR) :: farg3 
type(C_FUNPTR) :: farg4 

farg1 = c_loc(s)
farg2 = p_data
farg3 = pset
farg4 = psol
fresult = swigc_FSUNLinSolSetPreconditioner_SPBCGS(farg1, farg2, farg3, farg4)
swig_result = fresult
end function

function FSUNLinSolSetScalingVectors_SPBCGS(s, s1, s2) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(N_Vector), target, intent(inout) :: s1
type(N_Vector), target, intent(inout) :: s2
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(s)
farg2 = c_loc(s1)
farg3 = c_loc(s2)
fresult = swigc_FSUNLinSolSetScalingVectors_SPBCGS(farg1, farg2, farg3)
swig_result = fresult
end function

function FSUNLinSolSetZeroGuess_SPBCGS(s, onoff) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT), intent(in) :: onoff
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(s)
farg2 = onoff
fresult = swigc_FSUNLinSolSetZeroGuess_SPBCGS(farg1, farg2)
swig_result = fresult
end function

function FSUNLinSolSetup_SPBCGS(s, a) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(SUNMatrix), target, intent(inout) :: a
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(s)
farg2 = c_loc(a)
fresult = swigc_FSUNLinSolSetup_SPBCGS(farg1, farg2)
swig_result = fresult
end function

function FSUNLinSolSolve_SPBCGS(s, a, x, b, tol) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(SUNMatrix), target, intent(inout) :: a
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: b
real(C_DOUBLE), intent(in) :: tol
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 
real(C_DOUBLE) :: farg5 

farg1 = c_loc(s)
farg2 = c_loc(a)
farg3 = c_loc(x)
farg4 = c_loc(b)
farg5 = tol
fresult = swigc_FSUNLinSolSolve_SPBCGS(farg1, farg2, farg3, farg4, farg5)
swig_result = fresult
end function

function FSUNLinSolNumIters_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolNumIters_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolResNorm_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolResNorm_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolResid_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
type(C_PTR) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolResid_SPBCGS(farg1)
call c_f_pointer(fresult, swig_result)
end function

function FSUNLinSolLastFlag_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT64_T) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolLastFlag_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolSpace_SPBCGS(s, lenrwls, leniwls) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_LONG), dimension(*), target, intent(inout) :: lenrwls
integer(C_LONG), dimension(*), target, intent(inout) :: leniwls
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(s)
farg2 = c_loc(lenrwls(1))
farg3 = c_loc(leniwls(1))
fresult = swigc_FSUNLinSolSpace_SPBCGS(farg1, farg2, farg3)
swig_result = fresult
end function

function FSUNLinSolDestroy_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolDestroy_SPBCGS(farg1)
swig_result = fresult
end function

function FSUNLinSolFree_SPBCGS(s) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(SUNLinearSolver), target, intent(inout) :: s
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(s)
fresult = swigc_FSUNLinSolFree_SPBCGS(farg1)
swig_result = fresult
end function


end module
