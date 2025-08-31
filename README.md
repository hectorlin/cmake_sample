# C++ Curl Sample Project

This project demonstrates how to dynamically load and use `libcurl.so` in a C++ application.

## Project Structure

```
cmake_sample/
├── bin/          # Binary output directory
├── inc/          # Header files
├── lib/          # Library files
├── src/          # Source files
├── CMakeLists.txt
├── Makefile
└── README.md
```

## Features

- Dynamically loads `libcurl.so` at runtime
- C++ wrapper class for curl functionality
- HTTP GET request example
- CMake and Makefile build support

## Prerequisites

- GCC/G++ compiler with C++17 support
- CMake 3.10 or higher
- Make
- libcurl development libraries

## Installation

### Fedora/RHEL/CentOS
```bash
sudo dnf install gcc-c++ make cmake libcurl-devel
```

### Ubuntu/Debian
```bash
sudo apt-get install g++ make cmake libcurl4-openssl-dev
```

## Building

### Using CMake
```bash
mkdir build
cd build
cmake ..
make
```

### Using Makefile
```bash
make
```

## Running

After building, the executable will be in the `bin/` directory:

```bash
./bin/curl_sample
```

## How It Works

1. **Dynamic Loading**: The program uses `dlopen()` to load `libcurl.so` at runtime
2. **Function Pointers**: Gets function pointers using `dlsym()` for all required curl functions
3. **Wrapper Class**: Provides a clean C++ interface to the dynamically loaded curl library
4. **HTTP Request**: Demonstrates making an HTTP GET request to httpbin.org

## Important Notes

- The program expects `libcurl.so` to be available in the system library path
- SSL verification is disabled for demo purposes
- Error handling is included for robust operation
- The wrapper automatically cleans up resources in the destructor

## Troubleshooting

If you get "Failed to load libcurl.so" error:
1. Check if libcurl is installed: `ldconfig -p | grep curl`
2. Install libcurl development package if missing
3. Ensure the library is in the system library path

## License

This is a sample project for educational purposes. 