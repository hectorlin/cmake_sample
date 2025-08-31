#!/bin/bash

# C++ Curl Sample Project - Run with LD_LIBRARY_PATH
# C++ Curl 示例项目 - 使用 LD_LIBRARY_PATH 运行

echo "=== C++ Curl Sample Project - Run with LD_LIBRARY_PATH ==="
echo "=== C++ Curl 示例项目 - 使用 LD_LIBRARY_PATH 运行 ==="
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

# Check if executable exists
if [ ! -f "bin/curl_sample" ]; then
    print_error "Executable not found. Please build the project first with ./build_gcc.sh"
    exit 1
fi

# Get current directory
CURRENT_DIR=$(pwd)

# Set LD_LIBRARY_PATH to include the lib directory
print_status "Setting LD_LIBRARY_PATH to include current lib directory..."
export LD_LIBRARY_PATH="${CURRENT_DIR}/lib:${LD_LIBRARY_PATH}"

print_status "Current LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo

# Check if libcurl.so exists in lib directory
if [ ! -f "lib/libcurl.so" ]; then
    print_warning "lib/libcurl.so not found in current directory"
    print_status "Trying to use system libcurl..."
else
    print_success "Found libcurl.so in lib directory"
fi

# Run the program
print_status "Running curl_sample with updated LD_LIBRARY_PATH..."
echo "----------------------------------------"
if ./bin/curl_sample; then
    echo "----------------------------------------"
    print_success "Program completed successfully!"
else
    echo "----------------------------------------"
    print_error "Program failed!"
    exit 1
fi

echo
print_success "Program run completed!"
print_status "You can also run manually with:"
print_status "export LD_LIBRARY_PATH=${CURRENT_DIR}/lib:\$LD_LIBRARY_PATH"
print_status "./bin/curl_sample" 