#include "../inc/curl_wrapper.h"
#include <iostream>
#include <string>

int main() {
    std::cout << "=== C++ Curl Sample Program ===" << std::endl;
    std::cout << "Loading libcurl.so dynamically..." << std::endl;
    
    CurlWrapper curl;
    
    if (!curl.init()) {
        std::cerr << "Failed to initialize curl wrapper" << std::endl;
        return 1;
    }
    
    std::cout << "Curl wrapper initialized successfully!" << std::endl;
    
    // Test with a simple HTTP GET request
    std::string url = "http://httpbin.org/get";
    std::string response;
    
    std::cout << "Making HTTP GET request to: " << url << std::endl;
    
    if (curl.performHttpGet(url, response)) {
        std::cout << "Request successful!" << std::endl;
        std::cout << "Response length: " << response.length() << " characters" << std::endl;
        std::cout << "First 200 characters of response:" << std::endl;
        std::cout << "----------------------------------------" << std::endl;
        std::cout << response.substr(0, 200) << std::endl;
        if (response.length() > 200) {
            std::cout << "..." << std::endl;
        }
        std::cout << "----------------------------------------" << std::endl;
    } else {
        std::cerr << "Request failed!" << std::endl;
        return 1;
    }
    
    std::cout << "Program completed successfully!" << std::endl;
    return 0;
} 