# Created by Vasily Lobaskin (Liastre).
# Redistribution and use of this file is allowed according to the terms of the MIT license.

#.rst:
# FindFREEGLUT
# -------
#
# Search of the FREEGLUT library.
#
# The following variables will be defined:
#
#   FREEGLUT_FOUND         - true if library found
#   FREEGLUT_INCLUDE_DIRS  - path to library headers
#   FREEGLUT_LIBRARIES     - path to library itself
#   FREEGLUT_DEPENDENCIES  - additional dependencies

#===================================
#=========== VARIABLES =============
#===================================
# search paths
set(FREEGLUT_PATHS
    $ENV{include}
    $ENV{lib}
    ${OPENGL_INCLUDE_DIR}
    /usr
    /usr/local
    )

# dependencies
if(UNIX)
    set(FREEGLUT_DEPENDENCIES X11)
elseif(WIN32 OR WIN64)
    set(FREEGLUT_DEPENDENCIES winmm)
endif()

#===================================
#========= SEARCH HEADERS ==========
#===================================
find_path(FREEGLUT_INCLUDE_DIR
    NAMES
        GL/freeglut.h
    HINTS
        ${FREEGLUT_LOCATION}
        ENV${FREEGLUT_LOCATION}
    PATHS
        ${FREEGLUT_PATHS}
    PATH_SUFFIXES
        include
    )

#===================================
#======== SEARCH LIBRARIES =========
#===================================
find_library(FREEGLUT_LIBRARY
    NAMES
        freeglut_static
        freeglut
        # unix
        glut
    HINTS
        ${FREEGLUT_LOCATION}
        ENV${FREEGLUT_LOCATION}
    PATHS
        ${FREEGLUT_PATHS}
    PATH_SUFFIXES
        bin
        lib
    )

#===================================
#========== SET UP OUTPUT ==========
#===================================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FREEGLUT
    REQUIRED_VARS
        FREEGLUT_LIBRARY
        FREEGLUT_INCLUDE_DIR
    )
mark_as_advanced(
    GLFW3_INCLUDE_DIR
    GLFW3_LIBRARY
    )

if(FREEGLUT_FOUND)
    set(FREEGLUT_INCLUDE_DIRS ${FREEGLUT_INCLUDE_DIR})
    set(FREEGLUT_LIBRARIES ${FREEGLUT_LIBRARY})
endif()