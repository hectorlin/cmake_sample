#!/bin/bash

# C++ Curl Sample Project - GCC Build and Test Script
# C++ Curl 示例项目 - GCC 直接编译和测试脚本

echo "=== C++ Curl Sample Project GCC Build and Test ==="
echo "=== C++ Curl 示例项目 GCC 直接编译和测试 ==="
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
if [ ! -f "src/main.cpp" ] || [ ! -f "src/curl_wrapper.cpp" ] || [ ! -f "inc/curl_wrapper.h" ]; then
    print_error "Source files not found. Please run this script from the project root directory."
    exit 1
fi

# Check if g++ is available
if ! command -v g++ &> /dev/null; then
    print_error "g++ compiler not found. Please install g++ first."
    exit 1
fi

print_status "Starting GCC build process..."

# Create build_gcc directory for g++ builds
if [ ! -d "build_gcc" ]; then
    print_status "Creating build_gcc directory..."
    mkdir -p build_gcc
fi

# Clean previous build
print_status "Cleaning previous build..."
rm -f build_gcc/curl_sample

# Compile with g++
print_status "Compiling with g++..."
echo "g++ -std=c++17 -Wall -Wextra -Iinc -o build_gcc/curl_sample src/*.cpp -ldl"

if g++ -std=c++17 -Wall -Wextra -Iinc -o build_gcc/curl_sample src/*.cpp -ldl; then
    print_success "Compilation successful"
else
    print_error "Compilation failed"
    exit 1
fi

# Check if executable was created
if [ ! -f "build_gcc/curl_sample" ]; then
    print_error "Executable not found after compilation"
    exit 1
fi

print_success "Build completed successfully"
echo

# Test the program
print_status "Testing the program..."
echo

# Set LD_LIBRARY_PATH and run the program
print_status "Setting LD_LIBRARY_PATH and running curl_sample..."
export LD_LIBRARY_PATH="$(pwd)/lib:$LD_LIBRARY_PATH"
print_status "Current LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo

# Run the program
print_status "Running curl_sample..."
echo "----------------------------------------"
if ./build_gcc/curl_sample; then
    echo "----------------------------------------"
    print_success "Program test completed successfully!"
else
    echo "----------------------------------------"
    print_error "Program test failed!"
    exit 1
fi

echo
print_success "GCC build and test completed successfully!"
print_status "You can now run the program with:"
print_status "export LD_LIBRARY_PATH=$(pwd)/lib:\$LD_LIBRARY_PATH"
print_status "./build_gcc/curl_sample"

# Show file information
echo
print_status "Build information:"
ls -lh build_gcc/curl_sample 