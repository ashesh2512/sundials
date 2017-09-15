#!/bin/bash
# -------------------------------------------------------------------------------
# Programmer(s): David J. Gardner @ LLNL 
# -------------------------------------------------------------------------------
# LLNS Copyright Start
# Copyright (c) 2014, Lawrence Livermore National Security
# This work was performed under the auspices of the U.S. Department 
# of Energy by Lawrence Livermore National Laboratory in part under 
# Contract W-7405-Eng-48 and in part under Contract DE-AC52-07NA27344.
# Produced at the Lawrence Livermore National Laboratory.
# All rights reserved.
# For details, see the LICENSE file.
# LLNS Copyright End
# -------------------------------------------------------------------------------
# xsdk variant of the SUNDIALS regression testing script with all external 
# libraries enabled
# -------------------------------------------------------------------------------

# check number of inputs
if [ "$#" -lt 2 ]; then
    echo "ERROR: Illegal number of parameters, real and index type required"
    exit 1
fi
realtype=$1     # required, precision for realtypes
indextype=$2    # required, integer type for indices
buildthreads=$3 # optional, number of build threads (if empty will use all threads)

# adjust input values for xSDK build
if [ $realtype == "extended" ]; then
    realtype="quad"
fi

if [ $indextype == "int32_t" ]; then
    indextype="32"
else
    indextype="64"
fi

# create install directory
\rm -rf install_${realtype}_${indextype}
mkdir install_${realtype}_${indextype}

# create and move to build directory
\rm -rf build_${realtype}_${indextype}
mkdir build_${realtype}_${indextype}
cd build_${realtype}_${indextype}

# number of threads in OpenMP examples
export OMP_NUM_THREADS=4

# set file permissions (rwxrwxr-x)
umask 002

# -------------------------------------------------------------------------------
# Installed Third Party Libraries
# -------------------------------------------------------------------------------

# path to installed libraries
# NOTE: Will need to change some paths based on realtype/indextype when 
# options other than double and long int are used for testing
APPDIR=/usr/casc/sundials/apps/rh6
MPIDIR=${APPDIR}/openmpi/1.8.8/bin
KLUDIR=${APPDIR}/suitesparse/4.5.3
HYPREDIR=${APPDIR}/hypre/2.11.1
LAPACKDIR=${APPDIR}/lapack/3.6.0/lib64
PETSCDIR=${APPDIR}/petsc/3.7.2
SUPERLUMTDIR=${APPDIR}/superlu_mt/SuperLU_MT_3.1

# -------------------------------------------------------------------------------
# Configure SUNDIALS with CMake
# -------------------------------------------------------------------------------

# The '-LAH' flag lists the non-advanced cached variables (L), the advanced
# variables (A), and help for each variable (H). This will not print any system
# variables.

# The CMake option '-D CMAKE_VERBOSE_MAKEFILE=ON' enables additional output during
# compile time which is useful for debugging build issues.

echo "START CMAKE"
cmake \
    -D CMAKE_INSTALL_PREFIX="../install_${realtype}_${indextype}" \
    \
    -D XSDK_PRECISION=$realtype \
    -D XSDK_INDEX_SIZE=$indextype \
    \
    -D EXAMPLES_ENABLE=ON \
    -D CXX_ENABLE=ON \
    -D XSDK_ENABLE_FORTRAN=ON \
    -D F90_ENABLE=ON \
    \
    -D OPENMP_ENABLE=ON \
    -D PTHREAD_ENABLE=ON \
    \
    -D CMAKE_C_COMPILER="/usr/bin/cc" \
    -D CMAKE_CXX_COMPILER="/usr/bin/c++" \
    -D CMAKE_Fortran_COMPILER="/usr/bin/gfortran" \
    \
    -D CMAKE_C_FLAGS='-Wall -std=c99 -pedantic' \
    \
    -D MPI_ENABLE=ON \
    -D MPI_MPICC="${MPIDIR}/mpicc" \
    -D MPI_MPICXX="${MPIDIR}/mpicxx" \
    -D MPI_MPIF77="${MPIDIR}/mpif77" \
    -D MPI_MPIF90="${MPIDIR}/mpif90" \
    -D MPI_RUN_COMMAND="${MPIDIR}/mpirun" \
    \
    -D TPL_ENABLE_LAPACK=ON \
    -D TPL_LAPACK_LIBRARIES="${LAPACKDIR}/liblapack.so;${LAPACKDIR}/libblas.so;" \
    \
    -D KLU_ENABLE=ON \
    -D KLU_INCLUDE_DIR="${KLUDIR}/include" \
    -D KLU_LIBRARY_DIR="${KLUDIR}/lib" \
    \
    -D HYPRE_ENABLE=ON \
    -D HYPRE_INCLUDE_DIR="${HYPREDIR}/include" \
    -D HYPRE_LIBRARY_DIR="${HYPREDIR}/lib" \
    \
    -D PETSC_ENABLE=ON \
    -D PETSC_INCLUDE_DIR="${PETSCDIR}/include" \
    -D PETSC_LIBRARY_DIR="${PETSCDIR}/lib" \
    \
    -D TPL_ENABLE_SUPERLUMT=ON \
    -D TPL_SUPERLUMT_INCLUDE_DIRS="${SUPERLUMTDIR}/SRC" \
    -D TPL_SUPERLUMT_LIBRARIES="${SUPERLUMTDIR}/lib/libsuperlu_mt_PTHREAD.a" \
    -D TPL_SUPERLUMT_THREAD_TYPE=Pthread \
    \
    -LAH \
    ../../. 2>&1 | tee configure.log

# check cmake return code
rc=${PIPESTATUS[0]}
echo -e "\ncmake returned $rc\n" | tee -a configure.log
if [ $rc -ne 0 ]; then exit 1; fi

# -------------------------------------------------------------------------------
# Make SUNDIALS
# -------------------------------------------------------------------------------

echo "START MAKE"
make -j $buildthreads 2>&1 | tee make.log

# check make return code
rc=${PIPESTATUS[0]}
echo -e "\nmake returned $rc\n" | tee -a make.log
if [ $rc -ne 0 ]; then exit 1; fi

# -------------------------------------------------------------------------------
# Test SUNDIALS
# -------------------------------------------------------------------------------

# test sundials
echo "START TEST"
make test 2>&1 | tee test.log

# check make test return code
rc=${PIPESTATUS[0]}
echo -e "\nmake test returned $rc\n" | tee -a test.log
if [ $rc -ne 0 ]; then exit 1; fi

# -------------------------------------------------------------------------------
# Return
# -------------------------------------------------------------------------------

# if we make it here all tests have passed
exit 0