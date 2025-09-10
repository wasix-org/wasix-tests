#include <pthread.h>
#include <assert.h>
#include "thread-keys.h"
#include <stdio.h>

void set_data() {
    void* valueA = (void*)0x12345;
    void* valueB = (void*)0x67890;
    int res = pthread_setspecific(key_a, valueA);
    assert(res == 0);
    res = pthread_setspecific(key_b, valueB);
    assert(res == 0);
    fprintf(stdout, "set");
}