.. ----------------------------------------------------------------
   Programmer(s): David J. Gardner @ LLNL
   ----------------------------------------------------------------
   SUNDIALS Copyright Start
   Copyright (c) 2002-2023, Lawrence Livermore National Security
   and Southern Methodist University.
   All rights reserved.

   See the top-level LICENSE and NOTICE files for details.

   SPDX-License-Identifier: BSD-3-Clause
   SUNDIALS Copyright End
   ----------------------------------------------------------------

.. _ARKODE.Usage.MRIStep.InnerStepper:

MRIStep Inner Steppers
======================

Recall that MIS, MRI-GARK, and IMEX-MRI-GARK methods require solving a set of auxiliary IVPs

.. math::
   \dot{v}(t) = f^F(t, v) + r_i(t), \qquad v(t_{i,0}) = v_{i,0},
   :label: ARKODE_MRI_IVP

on intervals :math:`t \in [t_{i,0}, t_{i,f}]`.  For MIS, MRI-GARK and IMEX-MRI-GARK methods,
the forcing term :math:`r_i(t)` presented in :numref:`ARKODE.Mathematics.MRIStep` can be
equivalently written as

.. math::
   r_i(t) =
   \sum\limits_{k \geq 0} \hat{\omega}^{\{k\}}_i \tau^k
   +
   \sum\limits_{k \geq 0} \hat{\gamma}^{\{k\}}_i \tau^k
   :label: ARKODE_MRI_forcing_poly

where :math:`\tau = (t - t_{n,i-1}^S)/(h^S \Delta c_i^S)` is the normalized time
with :math:`\Delta c_i^S=\left(c^S_i - c^S_{i-1}\right)`, the slow stage times are
:math:`t_{n,i-1}^S = t_{n-1} + c_{i-1}^S h^S`, and the polynomial coefficient
vectors are

.. math::
   \hat{\omega}^{\{k\}}_i = \frac{1}{\Delta c_i^S} \sum\limits_{j=1}^{i-1}
   \omega^{\{k\}}_{i,j}  f^E(t_{n,j}^S, z_j)
   \quad\text{and}\quad
   \hat{\gamma}^{\{k\}}_i = \frac{1}{\Delta c_i^S} \sum\limits_{j=1}^i
   \gamma^{\{k\}}_{i,j}  f^I(t_{n,j}^S, z_j).
   :label: ARKODE_MRI_forcing_coefficients

To evolve the IVP :eq:`ARKODE_MRI_IVP` MRIStep utilizes a generic time integrator
interface defined by the :c:type:`MRIStepInnerStepper` base class. This section
presents the :c:type:`MRIStepInnerStepper` base class and methods that define
the integrator interface as well as detailing the steps for creating an
:c:type:`MRIStepInnerStepper`.

.. toctree::
   :maxdepth: 1

   Description
   Implementing
