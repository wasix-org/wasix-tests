#include <stdio.h>
#include <assert.h>

extern int get_value();

// Currently broken on wasix, because wasm-ld does not support linking against the library that is being built yet.
int main() {
    int side_value = get_value();
    printf("The shared library returned: %i\n", side_value);
    assert(side_value == 42);
    return 0;
}