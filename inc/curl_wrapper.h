#ifndef CURL_WRAPPER_H
#define CURL_WRAPPER_H

#include <string>
#include <dlfcn.h>

class CurlWrapper {
private:
    void* curl_handle;
    void* curl_lib;
    
    // Function pointers for curl functions
    void* (*curl_easy_init_func)();
    void (*curl_easy_cleanup_func)(void*);
    int (*curl_easy_setopt_func)(void*, int, ...);
    int (*curl_easy_perform_func)(void*);
    const char* (*curl_easy_strerror_func)(int);

public:
    CurlWrapper();
    ~CurlWrapper();
    
    bool init();
    bool performHttpGet(const std::string& url, std::string& response);
    void cleanup();
};

#endif // CURL_WRAPPER_H 