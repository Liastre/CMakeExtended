# Created by Vasily Lobaskin (Liastre).
# Redistribution and use of this file is allowed according to the terms of the MIT license.

#.rst:
# FindGLFW3
# -------
#
# Search of the GLFW3 library.
#
# The following variables will be defined:
#
#   GLFW3_FOUND         - true if library found
#   GLFW3_INCLUDE_DIRS  - path to library headers
#   GLFW3_LIBRARIES     - path to library itself
#   GLFW3_DEPENDENCIES  - additional dependencies

#===================================
#=========== VARIABLES =============
#===================================
# search paths
set(GLFW3_PATHS
    /opt/graphics/OpenGL
    /opt/graphics/OpenGL/contrib/libglfw
    /usr
    /usr/local
    /usr/openwin
    /usr/X11R6
    /usr/include/X11
    /usr/include/GL
    /usr/lib/w32api
    /usr/openwin/share
    )

# dependencies
if(UNIX)
    set(GLFW3_DEPENDENCIES X11 Xrandr Xi Xcursor Xinerama)
endif()

#===================================
#========= SEARCH HEADERS ==========
#===================================
find_path(GLFW3_INCLUDE_DIR
    NAMES
        GLFW/glfw3.h
    HINTS
        ${GLFW3_LOCATION}
        $ENV{GLFW3_LOCATION}
    PATHS
        "$ENV{PROGRAMFILES}/GLFW"
        ${OPENGL_INCLUDE_DIR}
        ${GLFW3_PATHS}
    PATH_SUFFIXES
        include
    DOC
        "GLFW headers"
    )

#===================================
#======== SEARCH LIBRARIES =========
#===================================
find_library(GLFW3_LIBRARY
    NAMES
        glfw
        glfw3
        glfw32
        glfw32s
    HINTS
        ${GLFW3_LOCATION}
        $ENV{GLFW3_LOCATION}
    PATHS
        "$ENV{PROGRAMFILES}/GLFW"
        "${OPENGL_LIBRARY_DIR}"
        ${GLFW3_PATHS}
    PATH_SUFFIXES
        lib
        lib64
        lib-msvc110
        lib-vc2012
        lib/x11
        # OS X
        lib/cocoa
        lib/${CMAKE_LIBRARY_ARCHITECTURE}
    DOC
        "GLFW library"
    )

#===================================
#========= PARSE VERSION ===========
#===================================
set(GLFW3_HEADER "${GLFW3_INCLUDE_DIR}/GLFW/glfw3.h")

# function to parse GLFW header
function(parseversion FILENAME VARNAME)
    set(PATTERN "^#define ${VARNAME}.*$")
    file(STRINGS "${GLFW3_INCLUDE_DIR}/${FILENAME}" TMP REGEX ${PATTERN})
    string(REGEX MATCHALL "[0-9]+" TMP "${TMP}")
    set(${VARNAME} ${TMP} PARENT_SCOPE)
endfunction()

# get GLFW version
if(GLFW3_INCLUDE_DIR)
    if(EXISTS "${GLFW3_INCLUDE_DIR}/GLFW/glfw3.h")
        parseversion(GLFW/glfw3.h GLFW3_VERSION_MAJOR)
        parseversion(GLFW/glfw3.h GLFW3_VERSION_MINOR)
        parseversion(GLFW/glfw3.h GLFW3_VERSION_REVISION)
    endif()

    if(GLFW3_VERSION_MAJOR AND GLFW3_VERSION_MINOR AND GLFW3_VERSION_REVISION)
        set(GLFW3_VERSION "${GLFW3_VERSION_MAJOR}.${GLFW3_VERSION_MINOR}.${GLFW3_VERSION_REVISION}")
    endif()
endif()

#===================================
#========== SET UP OUTPUT ==========
#===================================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLFW3
    REQUIRED_VARS
        GLFW3_LIBRARY
        GLFW3_INCLUDE_DIR
    VERSION_VAR
        GLFW3_VERSION
    )
mark_as_advanced(
    GLFW3_INCLUDE_DIR
    GLFW3_LIBRARY
    )

if(GLFW3_FOUND)
    set(GLFW3_INCLUDE_DIRS ${GLFW3_INCLUDE_DIR})
    set(GLFW3_LIBRARIES ${GLFW3_LIBRARY})
endif()
