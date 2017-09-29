#===================================
#============ SOURCES ==============
#===================================
set(lib_sources
    simple_library.cpp
    )

#===================================
#============= BUILD ===============
#===================================
add_library(${CMAKE_PROJECT_NAME} ${SIMPLELIBRARY_LINKAGE} ${lib_sources})
target_link_libraries(${CMAKE_PROJECT_NAME} ${cxx_compile_flags})
