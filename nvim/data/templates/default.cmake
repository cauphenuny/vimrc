cmake_minimum_required (VERSION 3.5)
project (
    unnamed
    VERSION 0.1.0
    LANGUAGES CXX
)
add_definitions (-DVERSION="${VERSION_STRING}")
aux_source_directory (${PROJECT_SOURCE_DIR} SRC_LIST)
add_executable (main ${SRC_LIST})
add_custom_target (run COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/main DEPENDS main)
