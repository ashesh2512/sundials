#!/bin/bash
# ---------------------------------------------------------------------------------
# SUNDIALS Copyright Start
# Copyright (c) 2002-2023, Lawrence Livermore National Security
# and Southern Methodist University.
# All rights reserved.
#
# See the top-level LICENSE and NOTICE files for details.
#
# SPDX-License-Identifier: BSD-3-Clause
# SUNDIALS Copyright End
# ---------------------------------------------------------------------------------
# This script will use clang-tidy and clang-format to 'lint' and format code.
# For clang-tidy to work, the build directory must have a ``compile_commands.json``, 
# which  can be generated by setting the CMake option
# ``CMAKE_EXPORT_COMPILE_COMMANDS`` to ``ON``.
#
# Usage:
#    ./tidy_and_format.sh <path to directory to tidy and format> <path to builddir>
# 
# We require clang-format and clang-tidy 17.0.4. Other versions may produce
# different styles!
# ---------------------------------------------------------------------------------


find $1 -name fmod -prune -iname *.h -o -iname *.hpp -o -iname *.c -o -iname *.cpp -o -iname *.cuh -o -iname *.cu | xargs clang-tidy -fix-errors -p $2

find $1 -name fmod -prune -iname *.h -o -iname *.hpp -o -iname *.c -o -iname *.cpp -o -iname *.cuh -o -iname *.cu | xargs clang-format -i
