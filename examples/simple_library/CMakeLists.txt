#===================================
#============= SYSTEM ==============
#===================================
cmake_minimum_required(VERSION 3.2)
set(CMAKE_CXX_STANDARD 11)

#===================================
#============ PROJECT ==============
#===================================
project(SimpleLibrary CXX)

#===================================
#============ COMPILER =============
#===================================
# MinGW flags to statically link environment libraries
if(MINGW)
    SET(cxx_compile_flags -static)
endif()

#===================================
#============= OPTIONS =============
#===================================
option(SIMPLELIBRARY_SHARED "Build shared library" ON)
option(SIMPLELIBRARY_BUILD_EXAMPLES "Build examples" ON)

#===================================
#============= OUTPUT ==============
#===================================
set(build_output_dir   ${CMAKE_BINARY_DIR})
set(binary_output_dir  ${CMAKE_BINARY_DIR}/binary)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${binary_output_dir})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${binary_output_dir})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${binary_output_dir})

#===================================
#========== DEPENDENCIES ===========
#===================================
include_directories(include)

#===================================
#============= SETUP ===============
#===================================
if(SIMPLELIBRARY_SHARED)
    set(SIMPLELIBRARY_LINKAGE SHARED)
else()
    set(SIMPLELIBRARY_LINKAGE STATIC)
endif()

#===================================
#============= BUILD ===============
#===================================
add_subdirectory(sources)
if(SIMPLELIBRARY_BUILD_EXAMPLES)
    add_subdirectory(examples)
endif()
