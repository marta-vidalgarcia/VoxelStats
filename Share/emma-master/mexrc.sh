#
# usage:        .mexrc.sh
#
# abstract:     This Bourne Shell script is sourced by the cmex and fmex
#		scripts to obtain certain site/user dependent information
#		as explained below. The first occurrence of this file
#		in the directory list:
#
#			. 		(current)
#			$HOME		(home)
#			matlab/bin	(default location)
#
#		is used. Most of the time this file in the default location
#		need not be modified at all and nothing needs to be done.
#		However, if cmex and fmex do not work properly with the
#		default values then this file may need to be modified and
#		different values inserted.
#
#		Currently, the following variables are available to
#		change on each platform.
#
#		cmex and fmex:
#		-------------
#       	MATLAB                  (MATLAB root directory)
#       	CC                      (C compiler)
#       	CFLAGS                  (C compiler options)
#       	FC                      (Fortran 77 compiler)
#       	FFLAGS                  (Fortran 77 options)
#       	LD_FCLIBS               (Libraries for ld(1) that include
#					 Fortran 77 objects)
#
#		cmex only:
#		---------
#       	LD_CCLIBS               (Libraries for ld(1) with C objects
#					 only)
#
#		NOTE: Run cmex or fmex without arguments to see what are
#		      the default values set in the script for these
#		      variables.
#
#		Any of these variables MUST remain null if the
#		default value in the cmex or fmex script is to be used.
#
#		There are other variables that can be changed but they
#		are not intended for MATLAB users and are not documented. You
#		may add variable assignment statements for platform dependent
#		variables that affect compilation and linking to completely
#		tailor your environment. You can supersede values assigned
#		here by passing them as arguments of the form
#
#				name=definition
#
#		to either cmex or fmex. Definitions which have white space
#		must be placed in quotes.
#		
#		The strategy behind the use of this file is to keep
#		the site wide changes in the matlab/bin/.mexrc.sh version
#		and have the individual user start with a copy in their
#		$HOME directory and modify it for their special circumstances.
#
#		IMPORTANT: Please understand that The MathWorks cannot
#			   anticipate every possible installation so
#			   it may be necessary in RARE cases to have to
#			   edit the matlab/.scripts/cmex.bin and
#			   matlab/.scripts/fmex.bin master scripts and
#			   add something to this script to make things
#			   work for your situation. We would especially
#			   like to hear from you in those cases. Please
#			   contact The MathWorks Technical Support.
#
# note(s):	1. The default values are
#
#		   cmex and fmex:
#		   -------------
#
#		   MATLAB		(MATLAB root directory)
#
#			Determined at run time by cmex or fmex as the
#			parent directory of the directory where the script
#			is.
#
#		   CC			(C compiler)
#
#			First cc command on your path.
#		        
#		   CFLAGS		(C compiler options)
#
#			Platform dependent. Run cmex or fmex without
#			arguments.
#
#		   FC			(Fortran 77 compiler)
#
#			First f77 command on your path.
#
#                  FFLAGS		(Fortran 77 options)
#
#			Platform dependent. Run cmex or fmex without
#			arguments.
#
#       	   LD_FCLIBS            (Libraries for ld(1) that include
#					 Fortran 77 objects)
#
#			Platform dependent. Run cmex or fmex without
#			arguments.
#
#			NOTE: (sun4 only)
#
#			      No dummy assignment provided below because
#			      you shouldn't need to use it. The correct list
#			      is generated by a dry run of the Fortran compiler
#			      in the cmex/fmex scripts. Use cmex/fmex in
#			      verbose mode, -v, to see what libraries are
#			      actually being linked in.
#
#		   cmex only:
#		   ---------
#
#       	   LD_CCLIBS            (Libraries for ld(1) with C objects
#					 only)
#
#			Platform dependent. Run cmex without arguments.
#
#			NOTE: (sun4 only)
#
#			      No dummy assignment provided below because
#			      you shouldn't need to use it. The correct list
#			      is generated by a dry run of the C compiler
#			      in the cmex script. Use cmex in verbose mode,
#			      -v, to see what libraries are actually being
#			      linked in.
#
# Copyright (c) 1992-93 by The MathWorks, Inc.
# $Revision: 1.1 $  $Date: 1994-05-27 18:07:51 $
#----------------------------------------------------------------------------
#
# Determine the arch.
#
#   -------------------------------------------------------------
#
    MEX_UTIL_DIR=
#
#   -------------------------------------------------------------
#
    if [ ! "$MEX_UTIL_DIR" ]; then
	MEX_UTIL_DIR=$MEX_UTIL_DIRdefault
    fi
#
    . $MEX_UTIL_DIR/arch.sh
    if [ ! "$Arch" ]; then
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    echo ''
    echo '^G    Sorry! We could not determine the machine architecture for your'
    echo '           host. Please contact:'
    echo ''
    echo '               MathWorks Technical Support'
    echo ''
    echo '           for further assistance.'
    echo ''
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        trap ""
        exit 1
    fi
#
#	IMPORTANT! Modify ONLY if you don't like the defaults after running
#		   cmex or fmex! No spaces around the '=' in the variable
#		   assignment!
#
    case "$Arch" in
	sun4)
#----------------------------------------------------------------------------
# LD_FCLIBS and LD_CCLIBS are not explicitly listed because a dry run of
# the appropriate compiler is done in the cmex/fmex scripts to generate
# the correct library list. Use -v option to see what libraries are actually
# being linked in.
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC="gcc"
       	    CFLAGS="-ansi -Wall"
       	    FC=
       	    FFLAGS=
#----------------------------------------------------------------------------
	    ;;
	sol2)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	hp700)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	ibm_rs)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
	    CCLIBS=
	    FC_CCLIBS=
       	    LD_CCLIBS=
# fmex only
	    FCLIBS=
#----------------------------------------------------------------------------
	    ;;
	sgi)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS="-D__STDC__ -ansi -prototypes -fullwarn -G 0"
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	dec_risc)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	hp300)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	alpha)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
	*)
#----------------------------------------------------------------------------
# cmex & fmex
	    MATLAB=
	    CC=
       	    CFLAGS=
       	    FC=
       	    FFLAGS=
       	    LD_FCLIBS=
# cmex only
       	    LD_CCLIBS=
#----------------------------------------------------------------------------
	    ;;
    esac
#
