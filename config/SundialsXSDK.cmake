# ---------------------------------------------------------------
# Programmer:  David J. Gardner @ LLNL
# ---------------------------------------------------------------
# LLNS Copyright Start
# Copyright (c) 2014, Lawrence Livermore National Security
# This work was performed under the auspices of the U.S. Department 
# of Energy by Lawrence Livermore National Laboratory in part under 
# Contract W-7405-Eng-48 and in part under Contract DE-AC52-07NA27344.
# Produced at the Lawrence Livermore National Laboratory.
# All rights reserved.
# For details, see the LICENSE file.
# LLNS Copyright End
# ---------------------------------------------------------------
# xSDK specific CMake variables. If set, these variables will 
# overwrite the value in equivalent SUNDIALS CMake variable.
#
# Only USE_XSDK_DEFAULTS is created in CACHE by default (set to 
# OFF). The other xSDK variables are left undefined. They can be
# be set by passing -D<variable_name>=<value> to cmake or can be 
# enabled in the cmake-gui setting USE_XSDK_DEFAULTS to ON.
#
# When USE_XSDK_DEFAULTS is ON the default values are overwritten
# by values passed to cmake or manually set in the cmake-gui.
# ---------------------------------------------------------------

# always show the option to turn on xSDK defaults
OPTION(USE_XSDK_DEFAULTS "Enable default xSDK settings" OFF)

# ---------------------------------------------------------------
# Set default values for some xSDK variables
# ---------------------------------------------------------------

IF(USE_XSDK_DEFAULTS)

  MESSAGE("Enabeling xSDK defaults")
  
  # set the CMake build type, SUNDIALS does not set a build type by default
  IF(NOT CMAKE_BUILD_TYPE)
    MESSAGE("Setting build type to Debug")
    SET(DOCSTR "Choose the type of build: None Debug Release RelWithDebInfo MinSizeRel")
    FORCE_VARIABLE(CMAKE_BUILD_TYPE STRING "${DOCSTR}" "Debug")
  ENDIF()

  # set build precision, SUNDIALS_PRECISION defaults to double
  SHOW_VARIABLE(XSDK_PRECISION STRING "single, double, or quad" "double")

  # set build index size, SUNDIALS_INDEX_TYPE defaults to int64_t
  SHOW_VARIABLE(XSDK_INDEX_SIZE STRING "32 or 64" "32")

  # disable Fortran-C interface, FCMIX defaults to OFF
  SHOW_VARIABLE(XSDK_ENABLE_FORTRAN BOOL "Enable Fortran-C support" OFF)

  # disable BLAS by default
  # SHOW_VARIABLE(TPL_ENABLE_BLAS BOOL "Enable BLAS support" OFF)

  # disable LAPACK by default
  SHOW_VARIABLE(TPL_ENABLE_LAPACK BOOL "Enable LAPACK support" OFF)

  # disable SuperLU_MT by default
  SHOW_VARIABLE(TPL_ENABLE_SUPERLUMT BOOL "Enable SuperLU_MT support" OFF)

  # disable KLU by default
  SHOW_VARIABLE(TPL_ENABLE_KLU BOOL "Enable KLU support" OFF)

  # disable PETSc by default
  SHOW_VARIABLE(TPL_ENABLE_PETSC BOOL "Enable PETSc support" OFF)

  # disable hypre by default
  SHOW_VARIABLE(TPL_ENABLE_HYPRE BOOL "Enable hypre support" OFF)

ENDIF()

# ---------------------------------------------------------------
# hide (make advanced) and overwrite equivalent SUNDIALS variables
# ---------------------------------------------------------------

# ---------------------------------------------------------------
# SUNDIALS precision, indextype, and Fortran interface
# ---------------------------------------------------------------

# XSDK_PRECISION => SUNDIALS_PRECISION
IF(XSDK_PRECISION)
  MESSAGE("Replacing SUNDIALS_PRECISION with XSDK_PRECISION")
  SET(DOCSTR "single, double, or extended")

  IF(XSDK_PRECISION MATCHES "quad")
    FORCE_VARIABLE(SUNDIALS_PRECISION STRING "${DOCSTR}" "extended")
  ELSE()
    FORCE_VARIABLE(SUNDIALS_PRECISION STRING "${DOCSTR}" "${XSDK_PRECISION}")
  ENDIF()

  MARK_AS_ADVANCED(FORCE SUNDIALS_PRECISION)
ENDIF()

# XSDK_INDEX_SIZE => SUNDIALS_INDEX_TYPE
IF(XSDK_INDEX_SIZE)
  MESSAGE("Replacing SUNDIALS_INDEX_TYPE with XSDK_INDEX_SIZE")
  SET(DOCSTR "Signed 64-bit (int64_t) or signed 32-bit (int32_t) integer")

  IF(XSDK_INDEX_SIZE MATCHES "32")
    FORCE_VARIABLE(SUNDIALS_INDEX_TYPE STRING "${DOCSTR}" "int32_t")
  ELSE()
    FORCE_VARIABLE(SUNDIALS_INDEX_TYPE STRING "${DOCSTR}" "int64_t")
  ENDIF()

  MARK_AS_ADVANCED(FORCE SUNDIALS_INDEX_TYPE)
ENDIF()

# XSDK_FORTRAN_ENABLE => FCMIX_ENABLE
IF(DEFINED XSDK_ENABLE_FORTRAN)
  MESSAGE("Replacing FCMIX_ENABLE with XSDK_ENABLE_FORTRAN")
  SET(DOCSTR "Enable Fortran-C support")
  
  # check that at least one solver with a Fortran interface is built
  IF(NOT BUILD_ARKODE AND NOT BUILD_CVODE AND NOT BUILD_IDA AND NOT BUILD_KINSOL)
    IF(XSDK_ENABLE_FORTRAN)
      PRINT_WARNING("Enabled packages do not support Fortran" 
                    "Disabeling XSDK_ENABLE_FORTRAN")
      FORCE_VARIABLE(XSDK_ENABLE_FORTRAN BOOL "${DOCSTR}" OFF)
    ENDIF()
    HIDE_VARIABLE(FCMIX_ENABLE)
    HIDE_VARIABLE(XSDK_ENABLE_FORTRAN)
  ENDIF()

  FORCE_VARIABLE(FCMIX_ENABLE BOOL "${DOCSTR}" "${XSDK_ENABLE_FORTRAN}")
  MARK_AS_ADVANCED(FORCE FCMIX_ENABLE)
ENDIF()

# ---------------------------------------------------------------
# LAPACK
# ---------------------------------------------------------------

# TPL_ENABLE_LAPACK => LAPACK_ENABLE
IF(DEFINED TPL_ENABLE_LAPACK)
  MESSAGE("Replacing LAPACK_ENABLE with TPL_ENABLE_LAPACK")
  SET(DOCSTR "Enable Lapack support")

  FORCE_VARIABLE(LAPACK_ENABLE BOOL "${DOCSTR}" "${TPL_ENABLE_LAPACK}")
  MARK_AS_ADVANCED(FORCE LAPACK_ENABLE)
ENDIF()

# TPL_LAPACK_LIBRARIES => LAPACK_LIBRARIES
IF(TPL_ENABLE_LAPACK)
  MESSAGE("Replacing LAPACK_LIBRARIES with TPL_LAPACK_LIBRARIES")
  SET(DOCSTR "Lapack library")

  SHOW_VARIABLE(TPL_LAPACK_LIBRARIES STRING "${DOCSTR}" "${TPL_LAPACK_LIBRARIES}")
  FORCE_VARIABLE(LAPACK_LIBRARIES STRING "${DOCSTR}" "${TPL_LAPACK_LIBRARIES}")
  MARK_AS_ADVANCED(FORCE LAPACK_LIBRARIES)
ENDIF()

# ---------------------------------------------------------------
# SuperLU_MT
# ---------------------------------------------------------------

# TPL_ENABLE_SUPERLUMT => SUPERLUMT_ENABLE
IF(DEFINED TPL_ENABLE_SUPERLUMT)
  MESSAGE("Replacing SUPERLUMT_ENABLE with TPL_ENABLE_SUPERLUMT")
  SET(DOCSTR "Enable SuperLU_MT support")

  FORCE_VARIABLE(SUPERLUMT_ENABLE BOOL "${DOCSTR}" "${TPL_ENABLE_SUPERLUMT}")
  MARK_AS_ADVANCED(FORCE SUPERLUMT_ENABLE)
ENDIF()

# TPL_SUPERLUMT_INCLUDE_DIRS => SUPERLUMT_INCLUDE_DIR
# TPL_SUPERLUMT_LIBRARIES    => SUPERLUMT_LIBRARY     => SUPERLUMT_LIBRARIES
IF(TPL_ENABLE_SUPERLUMT)
  MESSAGE("Replacing SUPERLUMT_INCLUDE_DIR with TPL_SUPERLUMT_INCLUDE_DIRS")
  SET(DOCSTR "SuperLU_MT include directory")

  SHOW_VARIABLE(TPL_SUPERLUMT_INCLUDE_DIRS STRING "${DOCSTR}" "${TPL_SUPERLUMT_INCLUDE_DIRS}")
  FORCE_VARIABLE(SUPERLUMT_INCLUDE_DIR STRING "${DOCSTR}" "${TPL_SUPERLUMT_INCLUDE_DIRS}")
  MARK_AS_ADVANCED(FORCE SUPERLUMT_INCLUDE_DIR)

  MESSAGE("Replacing SUPERLUMT_LIBRARY with TPL_SUPERLUMT_LIBRARIES")
  SET(DOCSTR "SuperLU_MT library")

  SHOW_VARIABLE(TPL_SUPERLUMT_LIBRARIES STRING "${DOCSTR}" "${TPL_SUPERLUMT_LIBRARIES}")
  FORCE_VARIABLE(SUPERLUMT_LIBRARY STRING "${DOCSTR}" "${TPL_SUPERLUMT_LIBRARIES}")
  MARK_AS_ADVANCED(FORCE SUPERLUMT_LIBRARY)
  MARK_AS_ADVANCED(FORCE SUPERLUMT_LIBRARY_DIR)

  MESSAGE("Replacing SUPERLUMT_THREAD_TYPE with TPL_SUPERLUMT_THREAD_TYPE")
  SET(DOCSTR "SuperLU_MT thread type (OpenMP or Pthread)")
  
  SHOW_VARIABLE(TPL_SUPERLUMT_THREAD_TYPE STRING "${DOCSTR}" "PThread")
  FORCE_VARIABLE(SUPERLUMT_THREAD_TYPE STRING "${DOCSTR}" "${TPL_SUPERLUMT_THREAD_TYPE}")
  MARK_AS_ADVANCED(FORCE SUPERLUMT_THREAD_TYPE)
ENDIF()
