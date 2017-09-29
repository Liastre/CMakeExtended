#===================================
#============= BUILD ===============
#===================================
add_executable(SimpleLibraryExample simple_library_example.cpp)
target_link_libraries(SimpleLibraryExample ${CMAKE_PROJECT_NAME})
