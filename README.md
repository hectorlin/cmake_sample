# C++ Curl Sample Project

A professional C++ project demonstrating dynamic loading of `libcurl.so` with comprehensive build system support.

## 🚀 Features

- **Dynamic Library Loading**: Uses `dlopen()` to load `libcurl.so` at runtime
- **Professional Build System**: CMake with multiple build types (Debug/Release)
- **Multiple Build Methods**: CMake and GCC direct compilation
- **LD_LIBRARY_PATH Support**: Professional library path management
- **HTTP Client**: Demonstrates HTTP GET requests to external APIs
- **Error Handling**: Comprehensive error handling and resource management
- **Cross-platform**: Works on Linux systems with curl support

## 📁 Project Structure

```
cmake_sample/
├── build/              # CMake build directory
├── build_gcc/          # GCC build directory
├── inc/                # Header files
│   └── curl_wrapper.h  # Curl wrapper class header
├── lib/                # Library files
│   ├── libcurl.so -> libcurl.so.4.8.0
│   └── libcurl.so.4.8.0
├── src/                # Source files
│   ├── main.cpp        # Main program
│   └── curl_wrapper.cpp # Curl wrapper implementation
├── build_cmake.sh      # CMake build script
├── build_gcc.sh        # GCC build script
├── CMakeLists.txt      # CMake configuration
└── README.md           # This file
```

## 🛠️ Prerequisites

### Required Software
- **GCC/G++**: C++17 compatible compiler
- **CMake**: Version 3.10 or higher
- **Make**: Build tool
- **libcurl**: Development libraries

### Installation Commands

#### Fedora/RHEL/CentOS
```bash
sudo dnf install gcc-c++ make cmake libcurl-devel
```

#### Ubuntu/Debian
```bash
sudo apt-get install g++ make cmake libcurl4-openssl-dev
```

#### Arch Linux
```bash
sudo pacman -S gcc make cmake curl
```

## 🔨 Building the Project

### Method 1: CMake Build (Recommended)

#### Quick Build and Test
```bash
./build_cmake.sh
```

#### Manual CMake Build
```bash
# Create build directory
mkdir build && cd build

# Configure (Debug build by default)
cmake ..

# Or specify build type
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
cmake -DCMAKE_BUILD_TYPE=MinSizeRel ..

# Build
make

# Run
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH
./bin/curl_sample
```

#### Available Build Types
- **Debug** (default): `-g -O0 -Wall -Wextra -DDEBUG`
- **Release**: `-O3 -DNDEBUG`
- **RelWithDebInfo**: `-O2 -g -DNDEBUG`
- **MinSizeRel**: `-Os -DNDEBUG`

### Method 2: GCC Direct Build

```bash
./build_gcc.sh
```

## 🎯 CMake Targets

After building with CMake, you can use these targets:

```bash
cd build

# Run program with LD_LIBRARY_PATH set
make run_ld_path

# Run with debug information
make debug_run

# Show setup instructions
make show_ld_path

# Clean all build files
make clean_all
```

## 🔧 Configuration

### LD_LIBRARY_PATH Setup

The project automatically manages `LD_LIBRARY_PATH` for the curl library:

```bash
# Automatic (recommended)
./build_cmake.sh
./build_gcc.sh

# Manual setup
export LD_LIBRARY_PATH=/path/to/cmake_sample/lib:$LD_LIBRARY_PATH
```

### Environment Variables

- `CMAKE_BUILD_TYPE`: Controls build type (Debug/Release/RelWithDebInfo/MinSizeRel)
- `LD_LIBRARY_PATH`: Library search path for curl

## 📊 Build Comparison

| Build Type | File Size | Optimization | Debug Info | Use Case |
|------------|-----------|--------------|------------|----------|
| **Debug** | ~123K | None (-O0) | Full (-g) | Development |
| **Release** | ~23K | Maximum (-O3) | None | Production |
| **RelWithDebInfo** | ~45K | High (-O2) | Full (-g) | Testing |
| **MinSizeRel** | ~20K | Size (-Os) | None | Embedded |

## 🧪 Testing

### Automated Testing
All build scripts include automatic testing:
- Compilation verification
- Library loading test
- HTTP request test
- Response validation

### Manual Testing
```bash
# Test CMake build
./build/bin/curl_sample

# Test GCC build
./build_gcc/curl_sample

# Expected output
=== C++ Curl Sample Program ===
Loading libcurl.so dynamically...
Curl library loaded successfully from system path
Curl wrapper initialized successfully!
Making HTTP GET request to: http://httpbin.org/get
Request successful!
Response length: 221 characters
...
```

## 🔍 Troubleshooting

### Common Issues

#### 1. "Failed to load libcurl.so"
```bash
# Check if libcurl is installed
ldconfig -p | grep curl

# Install development package
sudo dnf install libcurl-devel  # Fedora/RHEL
sudo apt-get install libcurl4-openssl-dev  # Ubuntu/Debian
```

#### 2. "Permission denied"
```bash
# Make scripts executable
chmod +x *.sh

# Check file permissions
ls -la *.sh
```

#### 3. "CMake not found"
```bash
# Install CMake
sudo dnf install cmake  # Fedora/RHEL
sudo apt-get install cmake  # Ubuntu/Debian
```

#### 4. "g++ not found"
```bash
# Install GCC
sudo dnf install gcc-c++  # Fedora/RHEL
sudo apt-get install g++  # Ubuntu/Debian
```

### Debug Information

Enable debug output by using Debug build type:
```bash
cmake -DCMAKE_BUILD_TYPE=Debug ..
make debug_run
```

## 📚 Technical Details

### Architecture
- **Dynamic Loading**: Uses `dlopen()` and `dlsym()` for runtime library loading
- **RAII**: Automatic resource management with destructors
- **Error Handling**: Comprehensive error checking and reporting
- **Callback System**: Custom write callback for HTTP response handling

### Dependencies
- **libdl**: Dynamic linking support
- **libcurl**: HTTP client library
- **C++17**: Modern C++ features

### Compilation Flags
- **Debug**: `-g -O0 -Wall -Wextra -DDEBUG`
- **Release**: `-O3 -DNDEBUG`
- **Standard**: `-std=c++17`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is provided as a sample for educational purposes.

## 🆘 Support

If you encounter issues:

1. Check the troubleshooting section
2. Verify prerequisites are installed
3. Check build type and configuration
4. Review error messages for specific details

## 🔄 Version History

- **v1.0.0**: Initial release with CMake and GCC build support
- Debug and Release build types
- LD_LIBRARY_PATH management
- Comprehensive build scripts
- Professional project structure

---

**Happy Coding! 🎉** 