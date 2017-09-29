# Created by Vasily Lobaskin (Liastre).
# Redistribution and use of this file is allowed according to the terms of the MIT license.

#.rst:
# FindSDL2
# -------
#
# Search of the SDL2 library.
#
# The following variables will be defined:
#
#   SDL2_FOUND         - true if library found
#   SDL2_INCLUDE_DIRS  - path to library headers
#   SDL2_LIBRARIES     - path to library itself
#   SDL2_DEPENDENCIES  - additional dependencies
#   SDL2_DEFINITIONS   - compiler definitions

#===================================
#=========== VARIABLES =============
#===================================
# search paths
set(SDL2_PATHS
    $ENV{include}
    ~/Library/Frameworks
    /Library/Frameworks
    /usr/local
    /usr
    # Fink
    /sw
    # DarwinPorts
    /opt/local
    # Blastwave
    /opt/csw
    /opt
    )

# environment
if(MINGW)
    set(ENVIRONMENT_LIBRARIES ${ENVIRONMENT_LIBRARIES} mingw32)
endif()

# dependencies
if(WIN32)
    set(SDL2_DEPENDENCIES
        winmm
        imm32
        version
        )
endif(WIN32)

#===================================
#========= SEARCH HEADERS ==========
#===================================
find_path(SDL2_INCLUDE_DIR
    NAMES
        SDL2/SDL.h
    HINTS
        "${SDL2_LOCATION}"
        "$ENV{SDL2_LOCATION}"
    PATHS
        ${SDL2_PATHS}
    PATH_SUFFIXES
        include
    )

#===================================
#======== SEARCH LIBRARIES =========
#===================================
find_library(SDL2_LIBRARY
    NAMES
        SDL2
    HINTS
        "${SDL2_LOCATION}"
        "$ENV{SDL2_LOCATION}"
    PATHS
        ${SDL2_PATHS}
    PATH_SUFFIXES
        bin
        lib
        lib64
    )

find_library(SDL2MAIN_LIBRARY
    NAMES
        SDL2main
    HINTS
        "${SDL2_LOCATION}"
        "$ENV{SDL2_LOCATION}"
    PATHS
        ${SDL2_PATHS}
    PATH_SUFFIXES
        lib
        lib64
    )

#===================================
#========== SET UP OUTPUT ==========
#===================================
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SDL2
    REQUIRED_VARS
        SDL2_LIBRARY
        SDL2MAIN_LIBRARY
        SDL2_INCLUDE_DIR
    )
mark_as_advanced(SDL2_INCLUDE_DIR SDL2_LIBRARY)

if(SDL2_FOUND)
    set(SDL2_INCLUDE_DIRS ${SDL2_INCLUDE_DIR})
    set(SDL2_LIBRARIES ${ENVIRONMENT_LIBRARIES} ${SDL2MAIN_LIBRARY} ${SDL2_LIBRARY})
else()
    set(SDL2_LIBRARIES ${ENVIRONMENT_LIBRARIES})
endif()
