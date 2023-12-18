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

module fnvector_serial_mod
 use, intrinsic :: ISO_C_BINDING
 use fsundials_types_mod
 use fsundials_nvector_mod
 use fsundials_context_mod
 use fsundials_types_mod
 use fsundials_types_mod
 implicit none
 private

 ! DECLARATION CONSTRUCTS
 public :: FN_VNewEmpty_Serial
 public :: FN_VNew_Serial
 public :: FN_VMake_Serial
 public :: FN_VGetLength_Serial
 public :: FN_VPrint_Serial
 public :: FN_VPrintFile_Serial
 public :: FN_VGetVectorID_Serial
 public :: FN_VCloneEmpty_Serial
 public :: FN_VClone_Serial
 public :: FN_VDestroy_Serial
 public :: FN_VSpace_Serial
 public :: FN_VSetArrayPointer_Serial
 public :: FN_VLinearSum_Serial
 public :: FN_VConst_Serial
 public :: FN_VProd_Serial
 public :: FN_VDiv_Serial
 public :: FN_VScale_Serial
 public :: FN_VAbs_Serial
 public :: FN_VInv_Serial
 public :: FN_VAddConst_Serial
 public :: FN_VDotProd_Serial
 public :: FN_VMaxNorm_Serial
 public :: FN_VWrmsNorm_Serial
 public :: FN_VWrmsNormMask_Serial
 public :: FN_VMin_Serial
 public :: FN_VWL2Norm_Serial
 public :: FN_VL1Norm_Serial
 public :: FN_VCompare_Serial
 public :: FN_VInvTest_Serial
 public :: FN_VConstrMask_Serial
 public :: FN_VMinQuotient_Serial
 public :: FN_VLinearCombination_Serial
 public :: FN_VScaleAddMulti_Serial
 public :: FN_VDotProdMulti_Serial
 public :: FN_VLinearSumVectorArray_Serial
 public :: FN_VScaleVectorArray_Serial
 public :: FN_VConstVectorArray_Serial
 public :: FN_VWrmsNormVectorArray_Serial
 public :: FN_VWrmsNormMaskVectorArray_Serial
 public :: FN_VWSqrSumLocal_Serial
 public :: FN_VWSqrSumMaskLocal_Serial
 public :: FN_VBufSize_Serial
 public :: FN_VBufPack_Serial
 public :: FN_VBufUnpack_Serial
 public :: FN_VEnableFusedOps_Serial
 public :: FN_VEnableLinearCombination_Serial
 public :: FN_VEnableScaleAddMulti_Serial
 public :: FN_VEnableDotProdMulti_Serial
 public :: FN_VEnableLinearSumVectorArray_Serial
 public :: FN_VEnableScaleVectorArray_Serial
 public :: FN_VEnableConstVectorArray_Serial
 public :: FN_VEnableWrmsNormVectorArray_Serial
 public :: FN_VEnableWrmsNormMaskVectorArray_Serial

 public :: FN_VGetArrayPointer_Serial


! WRAPPER DECLARATIONS
interface
function swigc_FN_VNewEmpty_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VNewEmpty_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR) :: fresult
end function

function swigc_FN_VNew_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VNew_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR) :: fresult
end function

function swigc_FN_VMake_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VMake_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR) :: fresult
end function

function swigc_FN_VGetLength_Serial(farg1) &
bind(C, name="_wrap_FN_VGetLength_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT64_T) :: fresult
end function

subroutine swigc_FN_VPrint_Serial(farg1) &
bind(C, name="_wrap_FN_VPrint_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
end subroutine

subroutine swigc_FN_VPrintFile_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VPrintFile_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
end subroutine

function swigc_FN_VGetVectorID_Serial(farg1) &
bind(C, name="_wrap_FN_VGetVectorID_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT) :: fresult
end function

function swigc_FN_VCloneEmpty_Serial(farg1) &
bind(C, name="_wrap_FN_VCloneEmpty_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR) :: fresult
end function

function swigc_FN_VClone_Serial(farg1) &
bind(C, name="_wrap_FN_VClone_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR) :: fresult
end function

subroutine swigc_FN_VDestroy_Serial(farg1) &
bind(C, name="_wrap_FN_VDestroy_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
end subroutine

subroutine swigc_FN_VSpace_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VSpace_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
end subroutine

subroutine swigc_FN_VSetArrayPointer_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VSetArrayPointer_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
end subroutine

subroutine swigc_FN_VLinearSum_Serial(farg1, farg2, farg3, farg4, farg5) &
bind(C, name="_wrap_FN_VLinearSum_Serial")
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE), intent(in) :: farg3
type(C_PTR), value :: farg4
type(C_PTR), value :: farg5
end subroutine

subroutine swigc_FN_VConst_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VConst_Serial")
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: farg1
type(C_PTR), value :: farg2
end subroutine

subroutine swigc_FN_VProd_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VProd_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
end subroutine

subroutine swigc_FN_VDiv_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VDiv_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
end subroutine

subroutine swigc_FN_VScale_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VScale_Serial")
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
end subroutine

subroutine swigc_FN_VAbs_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VAbs_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
end subroutine

subroutine swigc_FN_VInv_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VInv_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
end subroutine

subroutine swigc_FN_VAddConst_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VAddConst_Serial")
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
real(C_DOUBLE), intent(in) :: farg2
type(C_PTR), value :: farg3
end subroutine

function swigc_FN_VDotProd_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VDotProd_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VMaxNorm_Serial(farg1) &
bind(C, name="_wrap_FN_VMaxNorm_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VWrmsNorm_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VWrmsNorm_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VWrmsNormMask_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VWrmsNormMask_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VMin_Serial(farg1) &
bind(C, name="_wrap_FN_VMin_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VWL2Norm_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VWL2Norm_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VL1Norm_Serial(farg1) &
bind(C, name="_wrap_FN_VL1Norm_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
real(C_DOUBLE) :: fresult
end function

subroutine swigc_FN_VCompare_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VCompare_Serial")
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
end subroutine

function swigc_FN_VInvTest_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VInvTest_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VConstrMask_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VConstrMask_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_FN_VMinQuotient_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VMinQuotient_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VLinearCombination_Serial(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FN_VLinearCombination_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
integer(C_INT) :: fresult
end function

function swigc_FN_VScaleAddMulti_Serial(farg1, farg2, farg3, farg4, farg5) &
bind(C, name="_wrap_FN_VScaleAddMulti_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
type(C_PTR), value :: farg5
integer(C_INT) :: fresult
end function

function swigc_FN_VDotProdMulti_Serial(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FN_VDotProdMulti_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
integer(C_INT) :: fresult
end function

function swigc_FN_VLinearSumVectorArray_Serial(farg1, farg2, farg3, farg4, farg5, farg6) &
bind(C, name="_wrap_FN_VLinearSumVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
real(C_DOUBLE), intent(in) :: farg2
type(C_PTR), value :: farg3
real(C_DOUBLE), intent(in) :: farg4
type(C_PTR), value :: farg5
type(C_PTR), value :: farg6
integer(C_INT) :: fresult
end function

function swigc_FN_VScaleVectorArray_Serial(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FN_VScaleVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
integer(C_INT) :: fresult
end function

function swigc_FN_VConstVectorArray_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VConstVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
real(C_DOUBLE), intent(in) :: farg2
type(C_PTR), value :: farg3
integer(C_INT) :: fresult
end function

function swigc_FN_VWrmsNormVectorArray_Serial(farg1, farg2, farg3, farg4) &
bind(C, name="_wrap_FN_VWrmsNormVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
integer(C_INT) :: fresult
end function

function swigc_FN_VWrmsNormMaskVectorArray_Serial(farg1, farg2, farg3, farg4, farg5) &
bind(C, name="_wrap_FN_VWrmsNormMaskVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
integer(C_INT), intent(in) :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
type(C_PTR), value :: farg4
type(C_PTR), value :: farg5
integer(C_INT) :: fresult
end function

function swigc_FN_VWSqrSumLocal_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VWSqrSumLocal_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VWSqrSumMaskLocal_Serial(farg1, farg2, farg3) &
bind(C, name="_wrap_FN_VWSqrSumMaskLocal_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
type(C_PTR), value :: farg3
real(C_DOUBLE) :: fresult
end function

function swigc_FN_VBufSize_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VBufSize_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VBufPack_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VBufPack_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VBufUnpack_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VBufUnpack_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR), value :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableFusedOps_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableFusedOps_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableLinearCombination_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableLinearCombination_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableScaleAddMulti_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableScaleAddMulti_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableDotProdMulti_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableDotProdMulti_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableLinearSumVectorArray_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableLinearSumVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableScaleVectorArray_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableScaleVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableConstVectorArray_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableConstVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableWrmsNormVectorArray_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableWrmsNormVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function

function swigc_FN_VEnableWrmsNormMaskVectorArray_Serial(farg1, farg2) &
bind(C, name="_wrap_FN_VEnableWrmsNormMaskVectorArray_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
integer(C_INT), intent(in) :: farg2
integer(C_INT) :: fresult
end function


function swigc_FN_VGetArrayPointer_Serial(farg1) &
bind(C, name="_wrap_FN_VGetArrayPointer_Serial") &
result(fresult)
use, intrinsic :: ISO_C_BINDING
type(C_PTR), value :: farg1
type(C_PTR) :: fresult
end function

end interface


contains
 ! MODULE SUBPROGRAMS
function FN_VNewEmpty_Serial(vec_length, sunctx) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
integer(C_INT64_T), intent(in) :: vec_length
type(C_PTR) :: sunctx
type(C_PTR) :: fresult 
integer(C_INT64_T) :: farg1 
type(C_PTR) :: farg2 

farg1 = vec_length
farg2 = sunctx
fresult = swigc_FN_VNewEmpty_Serial(farg1, farg2)
call c_f_pointer(fresult, swig_result)
end function

function FN_VNew_Serial(vec_length, sunctx) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
integer(C_INT64_T), intent(in) :: vec_length
type(C_PTR) :: sunctx
type(C_PTR) :: fresult 
integer(C_INT64_T) :: farg1 
type(C_PTR) :: farg2 

farg1 = vec_length
farg2 = sunctx
fresult = swigc_FN_VNew_Serial(farg1, farg2)
call c_f_pointer(fresult, swig_result)
end function

function FN_VMake_Serial(vec_length, v_data, sunctx) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
integer(C_INT64_T), intent(in) :: vec_length
real(C_DOUBLE), dimension(*), target, intent(inout) :: v_data
type(C_PTR) :: sunctx
type(C_PTR) :: fresult 
integer(C_INT64_T) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = vec_length
farg2 = c_loc(v_data(1))
farg3 = sunctx
fresult = swigc_FN_VMake_Serial(farg1, farg2, farg3)
call c_f_pointer(fresult, swig_result)
end function

function FN_VGetLength_Serial(v) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT64_T) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT64_T) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(v)
fresult = swigc_FN_VGetLength_Serial(farg1)
swig_result = fresult
end function

subroutine FN_VPrint_Serial(v)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: v
type(C_PTR) :: farg1 

farg1 = c_loc(v)
call swigc_FN_VPrint_Serial(farg1)
end subroutine

subroutine FN_VPrintFile_Serial(v, outfile)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: v
type(C_PTR) :: outfile
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(v)
farg2 = outfile
call swigc_FN_VPrintFile_Serial(farg1, farg2)
end subroutine

function FN_VGetVectorID_Serial(v) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(N_Vector_ID) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(v)
fresult = swigc_FN_VGetVectorID_Serial(farg1)
swig_result = fresult
end function

function FN_VCloneEmpty_Serial(w) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
type(N_Vector), target, intent(inout) :: w
type(C_PTR) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(w)
fresult = swigc_FN_VCloneEmpty_Serial(farg1)
call c_f_pointer(fresult, swig_result)
end function

function FN_VClone_Serial(w) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), pointer :: swig_result
type(N_Vector), target, intent(inout) :: w
type(C_PTR) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(w)
fresult = swigc_FN_VClone_Serial(farg1)
call c_f_pointer(fresult, swig_result)
end function

subroutine FN_VDestroy_Serial(v)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: v
type(C_PTR) :: farg1 

farg1 = c_loc(v)
call swigc_FN_VDestroy_Serial(farg1)
end subroutine

subroutine FN_VSpace_Serial(v, lrw, liw)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: v
integer(C_INT64_T), dimension(*), target, intent(inout) :: lrw
integer(C_INT64_T), dimension(*), target, intent(inout) :: liw
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(v)
farg2 = c_loc(lrw(1))
farg3 = c_loc(liw(1))
call swigc_FN_VSpace_Serial(farg1, farg2, farg3)
end subroutine

subroutine FN_VSetArrayPointer_Serial(v_data, v)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(*), target, intent(inout) :: v_data
type(N_Vector), target, intent(inout) :: v
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(v_data(1))
farg2 = c_loc(v)
call swigc_FN_VSetArrayPointer_Serial(farg1, farg2)
end subroutine

subroutine FN_VLinearSum_Serial(a, x, b, y, z)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: a
type(N_Vector), target, intent(inout) :: x
real(C_DOUBLE), intent(in) :: b
type(N_Vector), target, intent(inout) :: y
type(N_Vector), target, intent(inout) :: z
real(C_DOUBLE) :: farg1 
type(C_PTR) :: farg2 
real(C_DOUBLE) :: farg3 
type(C_PTR) :: farg4 
type(C_PTR) :: farg5 

farg1 = a
farg2 = c_loc(x)
farg3 = b
farg4 = c_loc(y)
farg5 = c_loc(z)
call swigc_FN_VLinearSum_Serial(farg1, farg2, farg3, farg4, farg5)
end subroutine

subroutine FN_VConst_Serial(c, z)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: c
type(N_Vector), target, intent(inout) :: z
real(C_DOUBLE) :: farg1 
type(C_PTR) :: farg2 

farg1 = c
farg2 = c_loc(z)
call swigc_FN_VConst_Serial(farg1, farg2)
end subroutine

subroutine FN_VProd_Serial(x, y, z)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: y
type(N_Vector), target, intent(inout) :: z
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(x)
farg2 = c_loc(y)
farg3 = c_loc(z)
call swigc_FN_VProd_Serial(farg1, farg2, farg3)
end subroutine

subroutine FN_VDiv_Serial(x, y, z)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: y
type(N_Vector), target, intent(inout) :: z
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(x)
farg2 = c_loc(y)
farg3 = c_loc(z)
call swigc_FN_VDiv_Serial(farg1, farg2, farg3)
end subroutine

subroutine FN_VScale_Serial(c, x, z)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: c
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: z
real(C_DOUBLE) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c
farg2 = c_loc(x)
farg3 = c_loc(z)
call swigc_FN_VScale_Serial(farg1, farg2, farg3)
end subroutine

subroutine FN_VAbs_Serial(x, z)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: z
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(z)
call swigc_FN_VAbs_Serial(farg1, farg2)
end subroutine

subroutine FN_VInv_Serial(x, z)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: z
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(z)
call swigc_FN_VInv_Serial(farg1, farg2)
end subroutine

subroutine FN_VAddConst_Serial(x, b, z)
use, intrinsic :: ISO_C_BINDING
type(N_Vector), target, intent(inout) :: x
real(C_DOUBLE), intent(in) :: b
type(N_Vector), target, intent(inout) :: z
type(C_PTR) :: farg1 
real(C_DOUBLE) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(x)
farg2 = b
farg3 = c_loc(z)
call swigc_FN_VAddConst_Serial(farg1, farg2, farg3)
end subroutine

function FN_VDotProd_Serial(x, y) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: y
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(y)
fresult = swigc_FN_VDotProd_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VMaxNorm_Serial(x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(x)
fresult = swigc_FN_VMaxNorm_Serial(farg1)
swig_result = fresult
end function

function FN_VWrmsNorm_Serial(x, w) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: w
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(w)
fresult = swigc_FN_VWrmsNorm_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VWrmsNormMask_Serial(x, w, id) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: w
type(N_Vector), target, intent(inout) :: id
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(x)
farg2 = c_loc(w)
farg3 = c_loc(id)
fresult = swigc_FN_VWrmsNormMask_Serial(farg1, farg2, farg3)
swig_result = fresult
end function

function FN_VMin_Serial(x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(x)
fresult = swigc_FN_VMin_Serial(farg1)
swig_result = fresult
end function

function FN_VWL2Norm_Serial(x, w) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: w
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(w)
fresult = swigc_FN_VWL2Norm_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VL1Norm_Serial(x) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(x)
fresult = swigc_FN_VL1Norm_Serial(farg1)
swig_result = fresult
end function

subroutine FN_VCompare_Serial(c, x, z)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), intent(in) :: c
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: z
real(C_DOUBLE) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c
farg2 = c_loc(x)
farg3 = c_loc(z)
call swigc_FN_VCompare_Serial(farg1, farg2, farg3)
end subroutine

function FN_VInvTest_Serial(x, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: z
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(z)
fresult = swigc_FN_VInvTest_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VConstrMask_Serial(c, x, m) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: c
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: m
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(c)
farg2 = c_loc(x)
farg3 = c_loc(m)
fresult = swigc_FN_VConstrMask_Serial(farg1, farg2, farg3)
swig_result = fresult
end function

function FN_VMinQuotient_Serial(num, denom) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: num
type(N_Vector), target, intent(inout) :: denom
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(num)
farg2 = c_loc(denom)
fresult = swigc_FN_VMinQuotient_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VLinearCombination_Serial(nvec, c, v, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvec
real(C_DOUBLE), dimension(*), target, intent(inout) :: c
type(C_PTR) :: v
type(N_Vector), target, intent(inout) :: z
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 

farg1 = nvec
farg2 = c_loc(c(1))
farg3 = v
farg4 = c_loc(z)
fresult = swigc_FN_VLinearCombination_Serial(farg1, farg2, farg3, farg4)
swig_result = fresult
end function

function FN_VScaleAddMulti_Serial(nvec, a, x, y, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvec
real(C_DOUBLE), dimension(*), target, intent(inout) :: a
type(N_Vector), target, intent(inout) :: x
type(C_PTR) :: y
type(C_PTR) :: z
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 
type(C_PTR) :: farg5 

farg1 = nvec
farg2 = c_loc(a(1))
farg3 = c_loc(x)
farg4 = y
farg5 = z
fresult = swigc_FN_VScaleAddMulti_Serial(farg1, farg2, farg3, farg4, farg5)
swig_result = fresult
end function

function FN_VDotProdMulti_Serial(nvec, x, y, dotprods) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvec
type(N_Vector), target, intent(inout) :: x
type(C_PTR) :: y
real(C_DOUBLE), dimension(*), target, intent(inout) :: dotprods
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 

farg1 = nvec
farg2 = c_loc(x)
farg3 = y
farg4 = c_loc(dotprods(1))
fresult = swigc_FN_VDotProdMulti_Serial(farg1, farg2, farg3, farg4)
swig_result = fresult
end function

function FN_VLinearSumVectorArray_Serial(nvec, a, x, b, y, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvec
real(C_DOUBLE), intent(in) :: a
type(C_PTR) :: x
real(C_DOUBLE), intent(in) :: b
type(C_PTR) :: y
type(C_PTR) :: z
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
real(C_DOUBLE) :: farg2 
type(C_PTR) :: farg3 
real(C_DOUBLE) :: farg4 
type(C_PTR) :: farg5 
type(C_PTR) :: farg6 

farg1 = nvec
farg2 = a
farg3 = x
farg4 = b
farg5 = y
farg6 = z
fresult = swigc_FN_VLinearSumVectorArray_Serial(farg1, farg2, farg3, farg4, farg5, farg6)
swig_result = fresult
end function

function FN_VScaleVectorArray_Serial(nvec, c, x, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvec
real(C_DOUBLE), dimension(*), target, intent(inout) :: c
type(C_PTR) :: x
type(C_PTR) :: z
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 

farg1 = nvec
farg2 = c_loc(c(1))
farg3 = x
farg4 = z
fresult = swigc_FN_VScaleVectorArray_Serial(farg1, farg2, farg3, farg4)
swig_result = fresult
end function

function FN_VConstVectorArray_Serial(nvecs, c, z) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvecs
real(C_DOUBLE), intent(in) :: c
type(C_PTR) :: z
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
real(C_DOUBLE) :: farg2 
type(C_PTR) :: farg3 

farg1 = nvecs
farg2 = c
farg3 = z
fresult = swigc_FN_VConstVectorArray_Serial(farg1, farg2, farg3)
swig_result = fresult
end function

function FN_VWrmsNormVectorArray_Serial(nvecs, x, w, nrm) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvecs
type(C_PTR) :: x
type(C_PTR) :: w
real(C_DOUBLE), dimension(*), target, intent(inout) :: nrm
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 

farg1 = nvecs
farg2 = x
farg3 = w
farg4 = c_loc(nrm(1))
fresult = swigc_FN_VWrmsNormVectorArray_Serial(farg1, farg2, farg3, farg4)
swig_result = fresult
end function

function FN_VWrmsNormMaskVectorArray_Serial(nvecs, x, w, id, nrm) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
integer(C_INT), intent(in) :: nvecs
type(C_PTR) :: x
type(C_PTR) :: w
type(N_Vector), target, intent(inout) :: id
real(C_DOUBLE), dimension(*), target, intent(inout) :: nrm
integer(C_INT) :: fresult 
integer(C_INT) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 
type(C_PTR) :: farg4 
type(C_PTR) :: farg5 

farg1 = nvecs
farg2 = x
farg3 = w
farg4 = c_loc(id)
farg5 = c_loc(nrm(1))
fresult = swigc_FN_VWrmsNormMaskVectorArray_Serial(farg1, farg2, farg3, farg4, farg5)
swig_result = fresult
end function

function FN_VWSqrSumLocal_Serial(x, w) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: w
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(w)
fresult = swigc_FN_VWSqrSumLocal_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VWSqrSumMaskLocal_Serial(x, w, id) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(N_Vector), target, intent(inout) :: w
type(N_Vector), target, intent(inout) :: id
real(C_DOUBLE) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 
type(C_PTR) :: farg3 

farg1 = c_loc(x)
farg2 = c_loc(w)
farg3 = c_loc(id)
fresult = swigc_FN_VWSqrSumMaskLocal_Serial(farg1, farg2, farg3)
swig_result = fresult
end function

function FN_VBufSize_Serial(x, size) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: x
integer(C_INT64_T), dimension(*), target, intent(inout) :: size
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = c_loc(size(1))
fresult = swigc_FN_VBufSize_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VBufPack_Serial(x, buf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(C_PTR) :: buf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = buf
fresult = swigc_FN_VBufPack_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VBufUnpack_Serial(x, buf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: x
type(C_PTR) :: buf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
type(C_PTR) :: farg2 

farg1 = c_loc(x)
farg2 = buf
fresult = swigc_FN_VBufUnpack_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableFusedOps_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableFusedOps_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableLinearCombination_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableLinearCombination_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableScaleAddMulti_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableScaleAddMulti_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableDotProdMulti_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableDotProdMulti_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableLinearSumVectorArray_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableLinearSumVectorArray_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableScaleVectorArray_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableScaleVectorArray_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableConstVectorArray_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableConstVectorArray_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableWrmsNormVectorArray_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableWrmsNormVectorArray_Serial(farg1, farg2)
swig_result = fresult
end function

function FN_VEnableWrmsNormMaskVectorArray_Serial(v, tf) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
integer(C_INT) :: swig_result
type(N_Vector), target, intent(inout) :: v
integer(C_INT), intent(in) :: tf
integer(C_INT) :: fresult 
type(C_PTR) :: farg1 
integer(C_INT) :: farg2 

farg1 = c_loc(v)
farg2 = tf
fresult = swigc_FN_VEnableWrmsNormMaskVectorArray_Serial(farg1, farg2)
swig_result = fresult
end function


function FN_VGetArrayPointer_Serial(v) &
result(swig_result)
use, intrinsic :: ISO_C_BINDING
real(C_DOUBLE), dimension(:), pointer :: swig_result
type(N_Vector), target, intent(inout) :: v
type(C_PTR) :: fresult 
type(C_PTR) :: farg1 

farg1 = c_loc(v)
fresult = swigc_FN_VGetArrayPointer_Serial(farg1)
call c_f_pointer(fresult, swig_result, [FN_VGetLength_Serial(v)])
end function


end module
