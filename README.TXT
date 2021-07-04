http://www.jaymoseley.com/hercules/compilers/cobol.htm

The COBOL compiler and installation files are contained in the archive:  cobol.tgz [MD5: 0ffef09764d061de8d28903d2c89a04f].  Click on the archive name to download the archive to your computer.  The archive contains:

    a HET tape image (cobol.het),

    the output of the mainframe utility TAPEMAP showing the contents of the tape image (cobol.map),

    an installation jobstream (mvtcobol.jcl), and

    an installation verification jobstream (cobtest.jcl)

    a jobstream that compiles/links/executes the 99bottles program from http://www.99-bottles-of-beer.net/ (99bottles.jcl).

Uncompress the archive (use the tar xvzf cobol.tgz command on Linux or use WinZip or ZipNAll on Windows).  The tape image should go into your tape image subdirectory, the jobstreams should go into your JCL subdirectory, and the map file may be viewed with a text editor or printed if you are curious about the contents of the tape image.  Note:  The jobstreams were created under Windows, so each line is terminated with x'0d0a'.

The COBOL compiler consists of a set of load modules, which are invoked during the compilation of a user written program, and a set of object modules, which are used during the link-editing of a compiled program.  The compiler load modules are contained in the first dataset on the tape image (COBOL.LOAD).  The object modules are contained in the second dataset on the tape image (COBOL.LIB).  These two datasets were created by an IEBCOPY unload and the two libraries were unloaded from 3350 DASD (RECFM=U,BLKSIZE=19069).  The third dataset on the tape image (COBOL.PROCS) is a set of Catalogued Procedures, in IEBUPDTE format, that can be used to invoke the compiler. 

 
Target Libraries

The load modules for the compiler must be restored to a load library and the object modules must be restored to a Partitioned Dataset that will be available to the Linkage Editor.  The Catalogued Procedures should be restored to a procedure library known to JES2 on your system.  The default targets in the installation jobstream are SYS2.LINKLIB (for the load library), SYS1.COBLIB (for the COBOL object library), and SYS2.PROCLIB (for the Procedure Library).  If these libraries are not correct for your system, you must edit the installation jobstream before submitting it and substitute destination libraries suitable for your configuration.  Search for the comment - <==TARGET - which is contained on each line where a target library is named.  Additionally note that SYS1.COBLIB is created in step LINK003 and changes to the UNIT and VOL=SER parameters may be required to conform to your configuration.

The installation jobstream reloads the unloaded libraries to temporary datasets and the re-links the contents to the target libraries.  This allows you to place the restored modules on the type of DASD that fits your configuration, rather than restrict the destination to 3350 DASD.  However, you must have 3350 work space available in your configuration to restore the datasets to during the installation.

When you have verified that the installation jobstream - mvtcobol.jcl - conforms to your configuration, mount the tape image on a tape device and submit the jobstream to MVS for execution.  The job should take no more than a minute to execute and the return codes expected for the steps are:

    IEF142I MVTCOBOL RELOAD - STEP WAS EXECUTED - COND CODE 0000
    IEF142I MVTCOBOL PROCS - STEP WAS EXECUTED - COND CODE 0000
    IEF142I MVTCOBOL LINK001 - STEP WAS EXECUTED - COND CODE 0000
    IEF142I MVTCOBOL LINK002 - STEP WAS EXECUTED - COND CODE 0000
    IEF142I MVTCOBOL LINK003 - STEP WAS EXECUTED - COND CODE 0004

 
Installation Verification Jobstream

The cobtest.jcl jobstream performs a compile, link, and execute of a simple COBOL program to print the phrase "HELLO WORLD" on the MVS console.  The complete JES2 output for this job may be viewed at cobtest.

After the compiler has been successfully installed and verified, you do not need to retain the installation jobstreams or the tape image on your host computer.

November 2004 Update - I have written a macro, jobstream, and instructions for changing the installed default options for the COBOL compiler (without regenerating the compiler via MVT System Generation).  See: MVT COBOL Compiler Default Options.

 
Patch for XREF Abend  September 2019

In September 2019 there was a discussion on H390-MVS about the long known about abend of MVT COBOL when attempting to specify XREF in the options to obtain a Cross Reference listing of the source program being compiled.  Although the MVT COBOL compiler performs as expected under MVT, it always abends if XREF is requested when executing under MVS. Dave Kreiss researched and found that the compiler was attempting to organize acquired storage to be contiguous, which is simple under MVT, but more complex, if not impossible, under MVS. He submitted a patch to the compiler load module that seems to eliminate the problem and allow compiles to complete when XREF is requested. I applied the patch on my system. In the several test compiles I submitted to the patched compiler, I found that XREF now provides the expected Cross Reference listing. Others posted that they had positive results when they applied the patch on their system. Although this does not mean that the problem is completely resolved, as very large compile jobs requesting XREF may still abend, it seems that we can be hopeful that this has resolved the problem for the majority of cases in the Hercules' user community. 

I am providing a copy of the jobstream here as ZAPCOBOL. You may download the jobstream and run on your system to patch the load module of MVT COBOL on your system. As written, the jobstream is targeting the load module residing in SYSC.LINKLIB, which is the library contained on my Compiler Language/Tools volume (SYSCPK).  If the MVT COBOL compiler is stored in a different load library on your system, you will need to modify the jobstream to point to that library. 