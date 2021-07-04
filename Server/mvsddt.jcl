//DDTSERVR JOB  123,'Install DDT Server',REGION=2048K,MSGCLASS=X
//******************************************************************/
//*                                                                */
//* This JCL will create private load module and macro libraries   */
//* and load the DDT server elements into them. See the comments   */
//* below for information on changes you might wish to make to use */
//* existing libraries instead.                                    */
//*                                                                */
//******************************************************************/
//*
//*
//DEFALIAS EXEC PGM=IDCAMS
//******************************************************************/
//*                                                                */
//* This step defines an alias for the high-level qualifier 'DDT'. */
//* You may modify the DEFINE ALIAS statement to refer to a        */
//* different catalog, or remove the entire IDCAMS step if you     */
//* wish to catalog the DDT data sets into the master catalog (not */
//* recommended), or use existing data sets for the load module    */
//* and macro libraries.                                           */
//*                                                                */
//* Note: Executing this step will require you to know the         */
//*       password for your system's master catalog.               */
//*                                                                */
//******************************************************************/
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
   DEFINE ALIAS(NAME(DDT) RELATE(SYS1.UCAT.MVS))
/*
//*
//*
//DDTLMOD  EXEC PGM=IEBCOPY
//******************************************************************/
//*                                                                */
//* This step will allocate and copy the DDT server load modules   */
//* into the PDS specified by the LOADLIB DD. If you choose to use */
//* an existing library, modify the LOADLIB DD accordingly. Note   */
//* that you must still move or copy the DDT SVC module (IGC0023C) */
//* from this library to SYS1.LPALIB.                              */
//*                                                                */
//******************************************************************/
//TAPE     DD   DSN=MVSDDT,UNIT=TAPE,VOL=(,RETAIN,SER=MVSDDT),
//  DISP=(,KEEP)
//LOADLIB  DD   DSN=DDT.LOAD,UNIT=SYSDA,VOL=SER=PUB002,
//  SPACE=(CYL,(1,0,1)),DISP=(,CATLG)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
 COPY I=TAPE,O=LOADLIB
/*
//*
//*
//DDTMAC   EXEC PGM=IEBCOPY
//******************************************************************/
//*                                                                */
//* This step will allocate and copy the DDT server macros into    */
//* the PDS specified by the MACLIB DD. If you choose to use an    */
//* existing library, modify the MACLIB DD accordingly. If you do  */
//* do not plan to imbed hard-coded breakpoints in any of your     */
//* code using the DDTBRK macro, you can remove this installation  */
//* step.                                                          */
//*                                                                */
//******************************************************************/
//TAPE     DD   DSN=MVSDDT,UNIT=TAPE,VOL=SER=MVSDDT,
//  LABEL=2,DISP=(,KEEP)
//MACLIB   DD   DSN=DDT.MACLIB,UNIT=SYSDA,VOL=SER=PUB002,
//  SPACE=(TRK,(2,0,1)),DISP=(,CATLG)
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
 COPY I=TAPE,O=MACLIB