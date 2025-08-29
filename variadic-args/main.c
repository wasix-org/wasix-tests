#include <stdio.h>
#include <unistd.h>
#include <ctype.h>

extern void custom_printf(const char *format, ...);

static int GLOBAL = 42;

int main() {
    custom_printf("Printing %i, %i, %p, %d\n", 5, 6, 0, GLOBAL);
    return 0;
}