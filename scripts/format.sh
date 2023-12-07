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
# This script will use clang-tidy and clang-format to format code.
#
# Usage:
#    ./tidy_and_format.sh <path to directory to tidy and format>
# 
# We require clang-format 17.0.4. Other versions may produce different styles!
# ---------------------------------------------------------------------------------

find $1 -name fmod -prune -iname *.h -o -iname *.hpp -o -iname *.c -o -iname *.cpp -o -iname *.cuh -o -iname *.cu | xargs clang-format -i