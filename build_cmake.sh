#!/bin/bash

# C++ Curl Sample Project - CMake Build and Test Script
# C++ Curl 示例项目 - CMake 构建和测试脚本

echo "=== C++ Curl Sample Project CMake Build and Test ==="
echo "=== C++ Curl 示例项目 CMake 构建和测试 ==="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "CMakeLists.txt" ]; then
    print_error "CMakeLists.txt not found. Please run this script from the project root directory."
    exit 1
fi

# Check if cmake is available
if ! command -v cmake &> /dev/null; then
    print_error "cmake not found. Please install cmake first."
    exit 1
fi

# Check if make is available
if ! command -v make &> /dev/null; then
    print_error "make not found. Please install make first."
    exit 1
fi

print_status "Starting CMake build process..."

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    print_status "Creating build directory..."
    mkdir -p build
fi

# Navigate to build directory
cd build

# Configure with CMake
print_status "Configuring with CMake..."
if cmake ..; then
    print_success "CMake configuration successful"
else
    print_error "CMake configuration failed"
    exit 1
fi

# Build the project
print_status "Building project..."
if make; then
    print_success "Build successful"
else
    print_error "Build failed"
    exit 1
fi

# Check if executable was created
if [ ! -f "bin/curl_sample" ]; then
    print_error "Executable not found after build"
    exit 1
fi

print_success "Build completed successfully"
echo

# Test the program/home/wilson/Downloads/cmake_sample/build/bin
print_status "Testing the program..."
echo

# Go back to root directory for testing
cd ..

# Set LD_LIBRARY_PATH and run the program
print_status "Setting LD_LIBRARY_PATH and running curl_sample..."
export LD_LIBRARY_PATH="$(pwd)/lib:$LD_LIBRARY_PATH"
print_status "Current LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo

# Run the program
print_status "Running curl_sample..."
echo "----------------------------------------"
if ./build/bin/curl_sample; then
    echo "----------------------------------------"
    print_success "Program test completed successfully!"
else
    echo "----------------------------------------"
    print_error "Program test failed!"
    exit 1
fi

echo
print_success "CMake build and test completed successfully!"
print_status "You can now run the program with:"
print_status "export LD_LIBRARY_PATH=$(pwd)/lib:\$LD_LIBRARY_PATH"
print_status "./build/bin/curl_sample"
print_status ""
print_status "Or use CMake targets:"
print_status "cd build && make run_ld_path"
print_status "cd build && make show_ld_path"

# Show build information
echo
print_status "Build information:"
ls -lh build/bin/curl_sample 