/*
 * -----------------------------------------------------------------
 * $Revision: 1.21 $
 * $Date: 2004-10-08 15:11:08 $
 * ----------------------------------------------------------------- 
 * Programmers: Michael Wittman, Alan C. Hindmarsh, and         
 *              Radu Serban @ LLNL                              
 * -----------------------------------------------------------------
 * Copyright (c) 2002, The Regents of the University of California 
 * Produced at the Lawrence Livermore National Laboratory
 * All rights reserved
 * For details, see sundials/cvode/LICENSE
 * -----------------------------------------------------------------
 * This is the header file for the CVBBDPRE module, for a          
 * band-block-diagonal preconditioner, i.e. a block-diagonal       
 * matrix with banded blocks, for use with CVSpgmr, and            
 * the parallel implementation of the NVECTOR module.              
 *                                                                 
 * Summary:                                                        
 *                                                                 
 * These routines provide a preconditioner matrix  that is         
 * block-diagonal with banded blocks.  The blocking corresponds    
 * to the distribution of the dependent variable vector y among    
 * the processors.  Each preconditioner block is generated from    
 * the Jacobian of the local part (on the current processor) of a  
 * given function g(t,y) approximating f(t,y).  The blocks are     
 * generated by a difference quotient scheme on each processor     
 * independently.  This scheme utilizes an assumed banded          
 * structure with given half-bandwidths, mudq and mldq.            
 * However, the banded Jacobian block kept by the scheme has       
 * half-bandwiths mukeep and mlkeep, which may be smaller.         
 *                                                                 
 * The user's calling program should have the following form:      
 *                                                                 
 *   #include "nvector_parallel.h"                                 
 *   #include "cvbbdpre.h"                                         
 *   ...                                                           
 *   void *cvode_mem;                                              
 *   void *bbd_data;                                                 
 *   ...                                                           
 *   Set y0
 *   ...                                                           
 *   cvode_mem = CVodeCreate(...);                                 
 *   ier = CVodeMalloc(...);                                       
 *   ...                                                           
 *   bbd_data = CVBBDPrecAlloc(cvode_mem, Nlocal, mudq ,mldq,        
 *                             mukeep, mlkeep, dqrely, gloc, cfn);   
 *   flag = CVBBDSpgmr(cvode_mem, pretype, maxl, bbd_data);          
 *   ...                                                           
 *   ier = CVode(...);                                             
 *   ...                                                           
 *   CVBBDPrecFree(bbd_data);                                        
 *   ...                                                           
 *   CVodeFree(...);                                               
 *                                                                 
 *   Free y0
 *                                                                 
 *                                                                 
 * The user-supplied routines required are:                        
 *                                                                 
 *   f    = function defining the ODE right-hand side f(t,y).      
 *                                                                 
 *   gloc = function defining the approximation g(t,y).            
 *                                                                 
 *   cfn  = function to perform communication need for gloc.       
 *                                                                 
 *                                                                 
 * Notes:                                                          
 *                                                                 
 * 1) This header file is included by the user for the definition  
 *    of the CVBBDData type and for needed function prototypes.    
 *                                                                 
 * 2) The CVBBDPrecAlloc call includes half-bandwiths mudq and mldq
 *    to be used in the difference-quotient calculation of the     
 *    approximate Jacobian.  They need not be the true             
 *    half-bandwidths of the Jacobian of the local block of g,     
 *    when smaller values may provide a greater efficiency.        
 *    Also, the half-bandwidths mukeep and mlkeep of the retained  
 *    banded approximate Jacobian block may be even smaller,       
 *    to reduce storage and computation costs further.             
 *    For all four half-bandwidths, the values need not be the     
 *    same on every processor.                                     
 *                                                                 
 * 3) The actual name of the user's f function is passed to        
 *    CVodeMalloc, and the names of the user's gloc and cfn        
 *    functions are passed to CVBBDPrecAlloc.                      
 *                                                                 
 * 4) The pointer to the user-defined data block f_data, which is  
 *    set through CVodeSetFdata is also available to the user in   
 *    gloc and cfn.                                                
 *                                                                 
 * 5) For the CVSpgmr solver, the Gram-Schmidt type gstype, is     
 *    left to the user to specify through CVSpgmrSetGStype         
 *                                                                 
 * 6) Optional outputs specific to this module are available by    
 *    way of routines listed below.  These include work space sizes
 *    and the cumulative number of gloc calls.  The costs          
 *    associated with this module also include nsetups banded LU   
 *    factorizations, nlinsetups cfn calls, and npsolves banded    
 *    backsolve calls, where nlinsetups and npsolves are           
 *    integrator/CVSPGMR optional outputs.                         
 * -----------------------------------------------------------------
 */

#ifdef __cplusplus     /* wrapper to enable C++ usage */
extern "C" {
#endif

#ifndef _cvbbdpre_h
#define _cvbbdpre_h

#include "band.h"
#include "nvector.h"
#include "sundialstypes.h"

/*
 * -----------------------------------------------------------------
 * Type : CVLocalFn                                               
 * -----------------------------------------------------------------
 * The user must supply a function g(t,y) which approximates the  
 * right-hand side function f for the system y'=f(t,y), and which 
 * is computed locally (without inter-processor communication).   
 * (The case where g is mathematically identical to f is allowed.)
 * The implementation of this function must have type CVLocalFn.  
 *                                                                
 * This function takes as input the local vector size Nlocal, the 
 * independent variable value t, the local real dependent         
 * variable vector y, and a pointer to the user-defined data      
 * block f_data.  It is to compute the local part of g(t,y) and   
 * store this in the vector g.                                    
 * (Allocation of memory for y and g is handled within  the       
 * preconditioner module.)                                        
 * The f_data parameter is the same as that specified by the user 
 * through the CVodeSetFdata routine.                             
 * A CVLocalFn gloc does not have a return value.                 
 * -----------------------------------------------------------------
 */

typedef void (*CVLocalFn)(long int Nlocal, realtype t, N_Vector y,
                          N_Vector g, void *f_data);

/*
 * -----------------------------------------------------------------
 * Type : CVCommFn                                                
 * -----------------------------------------------------------------
 * The user must supply a function of type CVCommFn which performs
 * all inter-processor communication necessary to evaluate the    
 * approximate right-hand side function described above.          
 *                                                                
 * This function takes as input the local vector size Nlocal,     
 * the independent variable value t, the dependent variable       
 * vector y, and a pointer to the user-defined data block f_data. 
 * The f_data parameter is the same as that specified by the user 
 * through the CVodeSetFdata routine.  The CVCommFn cfn is        
 * expected to save communicated data in space defined within the 
 * structure f_data.                                              
 * A CVCommFn cfn does not have a return value.                   
 *                                                                
 * Each call to the CVCommFn cfn is preceded by a call to the     
 * RhsFn f with the same (t,y) arguments.  Thus cfn can omit any  
 * communications done by f if relevant to the evaluation of g.   
 * -----------------------------------------------------------------
 */

typedef void (*CVCommFn)(long int Nlocal, realtype t, N_Vector y,
                         void *f_data);

/*
 * -----------------------------------------------------------------
 * Function : CVBBDPrecAlloc                                      
 * -----------------------------------------------------------------
 * CVBBDPrecAlloc allocates and initializes a CVBBDData structure 
 * to be passed to CVSpgmr (and used by CVBBDPrecSetup and        
 * and CVBBDPrecSolve.                                            
 *                                                                
 * The parameters of CVBBDPrecAlloc are as follows:               
 *                                                                
 * cvode_mem is the pointer to the integrator memory.             
 *                                                                
 * Nlocal  is the length of the local block of the vectors y etc. 
 *         on the current processor.                              
 *                                                                
 * mudq, mldq  are the upper and lower half-bandwidths to be used 
 *         in the difference-quotient computation of the local    
 *         Jacobian block.                                        
 *                                                                
 * mukeep, mlkeep  are the upper and lower half-bandwidths of the 
 *         retained banded approximation to the local Jacobian 
 *         block.                                                 
 *                                                                
 * dqrely  is an optional input.  It is the relative increment    
 *         in components of y used in the difference quotient     
 *         approximations.  To specify the default, pass 0.       
 *         The default is dqrely = sqrt(unit roundoff).           
 *                                                                
 * gloc    is the name of the user-supplied function g(t,y) that  
 *         approximates f and whose local Jacobian blocks are     
 *         to form the preconditioner.                            
 *                                                                
 * cfn     is the name of the user-defined function that performs 
 *         necessary inter-processor communication for the        
 *         execution of gloc.                                     
 *                                                                
 * CVBBDPrecAlloc returns the storage allocated (type *void),     
 * or NULL if the request for storage cannot be satisfied.        
 * -----------------------------------------------------------------
 */

void *CVBBDPrecAlloc(void *cvode_mem, long int Nlocal, 
                     long int mudq, long int mldq, 
                     long int mukeep, long int mlkeep, 
                     realtype dqrely,
                     CVLocalFn gloc, CVCommFn cfn);

/*
 * -----------------------------------------------------------------
 * Function : CVBBDSpgmr                                          
 * -----------------------------------------------------------------
 * CVBBDSpgmr links the CVBBDPRE preconditioner to the CVSPGMR    
 * linear solver. It performs the following actions:              
 *  1) Calls the CVSPGMR specification routine and attaches the   
 *     CVSPGMR linear solver to the integrator memory;            
 *  2) Sets the preconditioner data structure for CVSPGMR         
 *  3) Sets the preconditioner setup routine for CVSPGMR          
 *  4) Sets the preconditioner solve routine for CVSPGMR          
 *                                                                
 * Its first 3 arguments are the same as for CVSpgmr (see         
 * cvspgmr.h). The last argument is the pointer to the CVBBDPRE   
 * memory block returned by CVBBDPrecAlloc.  
 * Note that the user need not call CVSpgmr.
 *                                                                
 * Possible return values are:                                    
 *    CVSPGMR_SUCCESS     if successful                                
 *    CVSPGMR_MEM_NULL    if the cvode memory was NULL
 *    CVSPGMR_LMEM_NULL   if the cvspgmr memory was NULL
 *    CVSPGMR_MEM_FAIL    if there was a memory allocation failure     
 *    CVSPGMR_ILL_INPUT   if a required vector operation is missing
 *    CVBBD_DATA_NULL     if the bbd_data was NULL
 * -----------------------------------------------------------------
 */                                                                

int CVBBDSpgmr(void *cvode_mem, int pretype, int maxl, void *bbd_data);

/*
 * -----------------------------------------------------------------
 * Function : CVBBDPrecReInit                                     
 * -----------------------------------------------------------------
 * CVBBDPrecReInit re-initializes the BBDPRE module when solving a
 * sequence of problems of the same size with CVSPGMR/CVBBDPRE,   
 * provided there is no change in Nlocal, mukeep, or mlkeep.      
 * After solving one problem, and after calling CVodeReInit to    
 * re-initialize the integrator for a subsequent problem, call    
 * CVBBDPrecReInit.  Then call CVSpgmrSet* or CVSpgmrReset*
 * functions if necessary for any changes to CVSpgmr parameters,
 * before calling CVode.
 *                                                                
 * The first argument to CVBBDPrecReInit must be the pointer pdata
 * that was returned by CVBBDPrecAlloc.  All other arguments have 
 * the same names and meanings as those of CVBBDPrecAlloc.        
 *                                                                
 * The return value of CVBBDPrecReInit is CVBBD_SUCCESS, indicating 
 * success, or CVBBD_DATA_NULL id bbd_data was NULL.  
 * -----------------------------------------------------------------
 */

int CVBBDPrecReInit(void *bbd_data, long int mudq, long int mldq,
                    realtype dqrely, CVLocalFn gloc, CVCommFn cfn);

/*
 * -----------------------------------------------------------------
 * Function : CVBBDPrecFree                                       
 * -----------------------------------------------------------------
 * CVBBDPrecFree frees the memory block bbd_data allocated by the 
 * call to CVBBDAlloc.                                            
 * -----------------------------------------------------------------
 */

void CVBBDPrecFree(void *bbd_data);

/*
 * -----------------------------------------------------------------
 * BBDPRE optional output extraction routines                     
 * -----------------------------------------------------------------
 * CVBBDPrecGetWorkSpace returns the BBDPRE real and integer workspace  
 *     sizes.                                                      
 * CVBBDPrecGetNumGfnEvals returns the number of calls to gfn.    
 *
 * The return value of CVBBDPrecGet* is one of:
 *    CVBBD_SUCCESS   if successful
 *    CVBBD_DATA_NULL if the bbd_data memory was NULL
 * -----------------------------------------------------------------
 */

int CVBBDPrecGetWorkSpace(void *bbd_data, long int *lenrwBBDP, long int *leniwBBDP);
int CVBBDPrecGetNumGfnEvals(void *bbd_data, long int *ngevalsBBDP);

#endif

#ifdef __cplusplus
}
#endif
