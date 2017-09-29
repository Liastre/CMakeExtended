#===================================
#============= SYSTEM ==============
#===================================
cmake_minimum_required(VERSION 3.2)
set(CMAKE_CXX_STANDARD 98)

#===================================
#============ PROJECT ==============
#===================================
project(SimpleExecutable CXX)

#===================================
#============ COMPILER =============
#===================================
# MinGW flags to statically link environment libraries
if (MINGW)
    set(cxx_compile_flags -static)
endif()

#===================================
#============ SOURCES ==============
#===================================
set(sources
    main.cpp
    )

#===================================
#============= BUILD ===============
#===================================
add_executable(${CMAKE_PROJECT_NAME} ${sources})
target_link_libraries(${CMAKE_PROJECT_NAME} ${cxx_compile_flags})
