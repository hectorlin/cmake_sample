cmake_minimum_required(VERSION 3.10)
project(CurlSample VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Build type configuration
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build (Debug/Release/RelWithDebInfo/MinSizeRel)" FORCE)
endif()

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Include directories
include_directories(inc)

# Source files
set(SOURCES
    src/main.cpp
    src/curl_wrapper.cpp
)

# Create executable
add_executable(curl_sample ${SOURCES})

# Link with dl library for dynamic loading
target_link_libraries(curl_sample dl)

# Compiler flags based on build type
target_compile_options(curl_sample PRIVATE
    $<$<CONFIG:Debug>:-g -O0 -Wall -Wextra -DDEBUG>
    $<$<CONFIG:Release>:-O3 -DNDEBUG>
    $<$<CONFIG:RelWithDebInfo>:-O2 -g -DNDEBUG>
    $<$<CONFIG:MinSizeRel>:-Os -DNDEBUG>
)

# Debug-specific definitions
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_definitions(curl_sample PRIVATE DEBUG_BUILD)
    message(STATUS "Debug build enabled - adding debug symbols and verbose output")
endif()

# Print build information
message(STATUS "Project: ${PROJECT_NAME}")
message(STATUS "Version: ${PROJECT_VERSION}")
message(STATUS "C++ Standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Output Directory: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

# Add custom target to run with LD_LIBRARY_PATH
add_custom_target(run_ld_path
    COMMAND ${CMAKE_COMMAND} -E env LD_LIBRARY_PATH=${CMAKE_SOURCE_DIR}/lib:$ENV{LD_LIBRARY_PATH} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/curl_sample
    DEPENDS curl_sample
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Running curl_sample with LD_LIBRARY_PATH set to include lib directory..."
)

# Add custom target to show LD_LIBRARY_PATH setup
add_custom_target(show_ld_path
    COMMAND ${CMAKE_COMMAND} -E echo "To run the program manually, use:"
    COMMAND ${CMAKE_COMMAND} -E echo "export LD_LIBRARY_PATH=${CMAKE_SOURCE_DIR}/lib:\$LD_LIBRARY_PATH"
    COMMAND ${CMAKE_COMMAND} -E echo "./build/bin/curl_sample"
    COMMENT "Showing LD_LIBRARY_PATH setup instructions..."
)

# Add debug target with extra debug information
add_custom_target(debug_run
    COMMAND ${CMAKE_COMMAND} -E echo "=== Debug Run ==="
    COMMAND ${CMAKE_COMMAND} -E echo "Build Type: ${CMAKE_BUILD_TYPE}"
    COMMAND ${CMAKE_COMMAND} -E echo "Compiler: $<TARGET_PROPERTY:curl_sample,LINKER_LANGUAGE>"
    COMMAND ${CMAKE_COMMAND} -E echo "Source Dir: ${CMAKE_SOURCE_DIR}"
    COMMAND ${CMAKE_COMMAND} -E echo "Binary Dir: ${CMAKE_BINARY_DIR}"
    COMMAND ${CMAKE_COMMAND} -E echo "LD_LIBRARY_PATH: ${CMAKE_SOURCE_DIR}/lib"
    COMMAND ${CMAKE_COMMAND} -E env LD_LIBRARY_PATH=${CMAKE_SOURCE_DIR}/lib:$ENV{LD_LIBRARY_PATH} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/curl_sample
    DEPENDS curl_sample
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Running curl_sample in debug mode with detailed information..."
)

# Add clean target
add_custom_target(clean_all
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} -E echo "Build directory removed"
    COMMENT "Cleaning all build files..."
)

# Print LD_LIBRARY_PATH setup information
message(STATUS "")
message(STATUS "=== LD_LIBRARY_PATH Setup Instructions ===")
message(STATUS "After building, you can run the program with:")
message(STATUS "  make run_ld_path")
message(STATUS "  make debug_run")
message(STATUS "Or manually with:")
message(STATUS "  export LD_LIBRARY_PATH=${CMAKE_SOURCE_DIR}/lib:\$LD_LIBRARY_PATH")
message(STATUS "  ./build/bin/curl_sample")
message(STATUS "==========================================")
message(STATUS "")
message(STATUS "=== Available Targets ===")
message(STATUS "  curl_sample    - Main executable")
message(STATUS "  run_ld_path    - Run with LD_LIBRARY_PATH set")
message(STATUS "  debug_run      - Run with debug information")
message(STATUS "  show_ld_path   - Show setup instructions")
message(STATUS "  clean_all      - Clean all build files")
message(STATUS "========================")
message(STATUS "") 