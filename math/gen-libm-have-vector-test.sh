#!/bin/sh
# Copyright (C) 2014-2015 Free Software Foundation, Inc.
# This file is part of the GNU C Library.

# The GNU C Library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.

# The GNU C Library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with the GNU C Library; if not, see
# <http://www.gnu.org/licenses/>.

# Generate series of definitions used for vector math functions tests.
# TEST_VECTOR_* and WRAPPER_NAME are defined in vector math functions tests.
# *_VEC_SUFF is used in individual tests, as result of FUNC_TEST unfolding
# to avoid warnings / errors about undeclared functions.
print_defs()
{
  echo "#if defined TEST_VECTOR_$1 && TEST_VECTOR_$1"
  echo "# define HAVE_VECTOR_$1 1"
  echo "# define ${1}_VEC_SUFF WRAPPER_NAME ($1)"
  echo "#else"
  echo "# define HAVE_VECTOR_$1 0"
  echo "# define ${1}_VEC_SUFF $1"
  echo "#endif"
  echo
}

for func in $(grep ALL_RM_TEST libm-test.inc | grep -v define | sed -r "s/.*\(//; s/,.*//"); do
  print_defs ${func}
  print_defs ${func}f
  print_defs ${func}l
done

# When all functions will use ALL_RM_TEST instead of using START directly,
# this code can be removed.
for func in $(grep 'START.*;$' libm-test.inc | sed -r "s/.*\(//; s/,.*//"); do
  print_defs ${func}
  print_defs ${func}f
  print_defs ${func}l
done