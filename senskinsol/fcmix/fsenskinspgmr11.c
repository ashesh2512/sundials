/******************************************************************
 *                                                                *
 * File          : fsenskinspgmr11.c                              *
 * Programmers   : Allan G Taylor and Alan C. Hindmarsh, and      *
 *                 Keith E. Grant @ LLNL                          *
 * Version of    : 12 Sept 2000 -- Sensitivity version            *
 *                 14 Jan 1998                                    *
 *----------------------------------------------------------------*
 * Routine used to interface between a Fortran main and the       *
 * various options available re preconditioning and user-supplied *
 * A-times (jacobian A times vector v) routines                   *
 ******************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "sens_kinspgmr.h" /* SensKINSol linear solver definitions   */
#include "fkinsol.h"       /* FORTRAN prototypes etc. for KINSol     */
#include "fsenskinsol.h"   /* FORTRAN prototypes etc. for SensKINSol */

/***************************************************************************/

void F_SENSKINSPGMR11( int *maxl, int *maxlrst, int *msbpre)
{
  /***********************************************************************
   * Call SensKINSpgmr to specify the SPGMR linear solver:
   *
   * This is case 11:  preconditioning solve routine and a user ATimes rtn.
   *
   *
   *  SENSKIN_smem   is the pointer to the Sens_KINSOL memory block
   *
   * *maxl           is the maximum Krylov dimension
   *
   * *maxlrst        is the max number of lin solver restarts
   *
   * *msbpre         is the max number of steps calling the
   *                    preconditioning solver w/o calling the
   *                    preconditioner setup interface routine
   *
   * NULL            is a pointer to the preconditioner setup interface
   *                    routine
   *
   * KINPSol         is a pointer to the preconditioner solve interface
   *                    routine
   *
   * KINUAtimes      is a pointer to the user ATimes routine
   *
   * NULL            is a pointer to the P_data memory structure
   *
   ***********************************************************************/

 SensKINSpgmr (SENSKIN_smem, *maxl, *maxlrst, *msbpre, NULL, KINPSol,
         KINUAtimes, NULL);
}
