#include <stdio.h>
#include <assert.h>

extern int get_value();

int main() {
    int side_value = get_value();
    printf("The shared library returned: %i\n", side_value);
    assert(side_value == 42);
    return 0;
}