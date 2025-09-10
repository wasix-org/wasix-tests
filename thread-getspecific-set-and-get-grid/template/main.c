#include <pthread.h>
#include "thread-keys.h"
#include <assert.h>
#include <stdio.h>
#if defined(SET_DATA_PROXY_DIRECT) || defined(SET_DATA_PROXY_SHARED)
#include "set-data-proxy.h"
#endif
#if defined(GET_DATA_PROXY_DIRECT) || defined(GET_DATA_PROXY_SHARED)
#include "get-data-proxy.h"
#endif
#if defined(SET_DATA_PROXY_DYNAMIC) || defined(GET_DATA_PROXY_DYNAMIC)
#include "dlfcn.h"
#include <stdlib.h>
#endif

pthread_key_t key_a;
pthread_key_t key_b;

void run_test() {
    // Set thread specific data
#if defined(SET_DATA_PROXY_DYNAMIC)
    void* handle_set_data_proxy = dlopen("./libset-data-proxy.so", RTLD_LAZY);
    if(handle_set_data_proxy == NULL) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        exit(1);
    }
    typedef void (*set_data_proxy_func_t)();
    set_data_proxy_func_t set_data_proxy = (set_data_proxy_func_t)dlsym(handle_set_data_proxy, "set_data_proxy");
    if (set_data_proxy == NULL) {
        fprintf(stderr, "dlsym failed: %s\n", dlerror());
        exit(1);
    }
#endif
    set_data_proxy();

    // Get thread specific data
#if defined(GET_DATA_PROXY_DYNAMIC)
    void* handle_get_data_proxy = dlopen("./libget-data-proxy.so", RTLD_LAZY);
    if(handle_get_data_proxy == NULL) {
        fprintf(stderr, "dlopen failed: %s\n", dlerror());
        exit(1);
    }
    typedef void (*get_data_proxy_func_t)();
    get_data_proxy_func_t get_data_proxy = (get_data_proxy_func_t)dlsym(handle_get_data_proxy, "get_data_proxy");
    if (get_data_proxy == NULL) {
        fprintf(stderr, "dlsym failed: %s\n", dlerror());
        exit(1);
    }
#endif
    get_data_proxy();

    // Terminate the output with a newline
    printf("\n");
}

int main() {
    int res = pthread_key_create(&key_a, NULL);
    assert(res == 0);
    assert(pthread_getspecific(key_a) == NULL);
    res = pthread_key_create(&key_b, NULL);
    assert(res == 0);
    assert(pthread_getspecific(key_b) == NULL);

    run_test();

    pthread_key_delete(key_a);
    pthread_key_delete(key_b);
    return 0;
}
