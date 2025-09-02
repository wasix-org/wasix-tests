#include <cstdio>
#ifdef THROW_VIA_PROXY
#include "proxy.hpp"
#include "thrower.hpp"
#else
#include "thrower.hpp"
#endif

void catch_exception() {
    try {
#ifdef THROW_VIA_PROXY
        // throw_exception_proxy();
        throw_exception();
#else
        throw_exception();
#endif
    } catch (const char* msg) {
        printf("Caught exception: %s\n", msg);
    }
}