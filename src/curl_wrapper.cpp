#include "../inc/curl_wrapper.h"
#include <iostream>
#include <cstring>
#include <cstdlib>

// Curl option constants
#define CURLOPT_URL 10002
#define CURLOPT_WRITEFUNCTION 20011
#define CURLOPT_WRITEDATA 10001
#define CURLOPT_FOLLOWLOCATION 52
#define CURLOPT_SSL_VERIFYPEER 64
#define CURLOPT_SSL_VERIFYHOST 81

// Curl error codes
#define CURLE_OK 0

// Static callback function
static size_t WriteCallback(void* contents, size_t size, size_t nmemb, std::string* userp) {
    userp->append((char*)contents, size * nmemb);
    return size * nmemb;
}

CurlWrapper::CurlWrapper() : curl_handle(nullptr), curl_lib(nullptr) {
    // Initialize function pointers
    curl_easy_init_func = nullptr;
    curl_easy_cleanup_func = nullptr;
    curl_easy_setopt_func = nullptr;
    curl_easy_perform_func = nullptr;
    curl_easy_strerror_func = nullptr;
}

CurlWrapper::~CurlWrapper() {
    cleanup();
}

bool CurlWrapper::init() {
    // Try to load the curl library from system path first
    curl_lib = dlopen("libcurl.so", RTLD_LAZY);
    
    // If not found, try with version
    if (!curl_lib) {
        curl_lib = dlopen("libcurl.so.4", RTLD_LAZY);
    }
    
    // If still not found, try with specific version
    if (!curl_lib) {
        curl_lib = dlopen("libcurl.so.4.8.0", RTLD_LAZY);
    }
    
    if (!curl_lib) {
        std::cerr << "Failed to load libcurl.so from system path: " << dlerror() << std::endl;
        std::cerr << "Please ensure libcurl is installed and LD_LIBRARY_PATH is set correctly" << std::endl;
        std::cerr << "You can set it with: export LD_LIBRARY_PATH=/path/to/curl/lib:$LD_LIBRARY_PATH" << std::endl;
        return false;
    }
    
    // Get function pointers
    curl_easy_init_func = (void* (*)())dlsym(curl_lib, "curl_easy_init");
    curl_easy_cleanup_func = (void (*)(void*))dlsym(curl_lib, "curl_easy_cleanup");
    curl_easy_setopt_func = (int (*)(void*, int, ...))dlsym(curl_lib, "curl_easy_setopt");
    curl_easy_perform_func = (int (*)(void*))dlsym(curl_lib, "curl_easy_perform");
    curl_easy_strerror_func = (const char* (*)(int))dlsym(curl_lib, "curl_easy_strerror");
    
    if (!curl_easy_init_func || !curl_easy_cleanup_func || 
        !curl_easy_setopt_func || !curl_easy_perform_func || !curl_easy_strerror_func) {
        std::cerr << "Failed to get curl function pointers: " << dlerror() << std::endl;
        dlclose(curl_lib);
        curl_lib = nullptr;
        return false;
    }
    
    // Initialize curl handle
    curl_handle = curl_easy_init_func();
    if (!curl_handle) {
        std::cerr << "Failed to initialize curl handle" << std::endl;
        dlclose(curl_lib);
        curl_lib = nullptr;
        return false;
    }
    
    std::cout << "Curl library loaded successfully from system path" << std::endl;
    return true;
}

bool CurlWrapper::performHttpGet(const std::string& url, std::string& response) {
    if (!curl_handle) {
        std::cerr << "Curl not initialized" << std::endl;
        return false;
    }
    
    response.clear();
    
    // Set URL
    if (curl_easy_setopt_func(curl_handle, CURLOPT_URL, url.c_str()) != CURLE_OK) {
        std::cerr << "Failed to set URL" << std::endl;
        return false;
    }
    
    // Set write callback
    if (curl_easy_setopt_func(curl_handle, CURLOPT_WRITEFUNCTION, WriteCallback) != CURLE_OK) {
        std::cerr << "Failed to set write function" << std::endl;
        return false;
    }
    
    // Set write data
    if (curl_easy_setopt_func(curl_handle, CURLOPT_WRITEDATA, &response) != CURLE_OK) {
        std::cerr << "Failed to set write data" << std::endl;
        return false;
    }
    
    // Follow redirects
    if (curl_easy_setopt_func(curl_handle, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK) {
        std::cerr << "Failed to set follow location" << std::endl;
        return false;
    }
    
    // Disable SSL verification for demo purposes
    if (curl_easy_setopt_func(curl_handle, CURLOPT_SSL_VERIFYPEER, 0L) != CURLE_OK) {
        std::cerr << "Failed to set SSL verify peer" << std::endl;
        return false;
    }
    
    if (curl_easy_setopt_func(curl_handle, CURLOPT_SSL_VERIFYHOST, 0L) != CURLE_OK) {
        std::cerr << "Failed to set SSL verify host" << std::endl;
        return false;
    }
    
    // Perform the request
    int result = curl_easy_perform_func(curl_handle);
    if (result != CURLE_OK) {
        std::cerr << "Curl perform failed: " << curl_easy_strerror_func(result) << std::endl;
        return false;
    }
    
    return true;
}

void CurlWrapper::cleanup() {
    if (curl_handle) {
        curl_easy_cleanup_func(curl_handle);
        curl_handle = nullptr;
    }
    
    if (curl_lib) {
        dlclose(curl_lib);
        curl_lib = nullptr;
    }
} 