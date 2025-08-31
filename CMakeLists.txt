cmake_minimum_required(VERSION 3.10)
project(CurlSample)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

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

# Compiler flags
target_compile_options(curl_sample PRIVATE -Wall -Wextra)

# Print build information
message(STATUS "Project: ${PROJECT_NAME}")
message(STATUS "C++ Standard: ${CMAKE_CXX_STANDARD}")
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

# Print LD_LIBRARY_PATH setup information
message(STATUS "")
message(STATUS "=== LD_LIBRARY_PATH Setup Instructions ===")
message(STATUS "After building, you can run the program with:")
message(STATUS "  make run_ld_path")
message(STATUS "Or manually with:")
message(STATUS "  export LD_LIBRARY_PATH=${CMAKE_SOURCE_DIR}/lib:\$LD_LIBRARY_PATH")
message(STATUS "  ./build/bin/curl_sample")
message(STATUS "==========================================")
message(STATUS "") 