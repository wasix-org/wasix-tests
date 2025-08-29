#include <assert.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <stdio.h>
#include <time.h>
#include <dlfcn.h>

typedef void (*func_t)();

int main() {
    void* handle = dlopen("liblibrary.so", RTLD_NOW);
    if (!handle) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        return 1;
    }
    func_t cpp_function = (func_t)dlsym(handle, "cpp_function");
    if (!cpp_function) {
        fprintf(stderr, "dlsym failed: %s\n", dlerror());
        return 1;
    }
    cpp_function();

    dlclose(handle);
    return 0;
}