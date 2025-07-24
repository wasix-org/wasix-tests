#include <stdio.h>
#include <string.h>
#include <unistd.h> // for getpass
#include <assert.h>

int main() {
    // Prompt the user
    char *password = getpass("Enter password: ");
    
    // Check for null return
    assert(password != NULL);

    // Basic test: simulate expected behavior
    if (strlen(password) == 0) {
        printf("Password entry was empty.\n");
        return 1;
    }

    if (strcmp(password, "test123") != 0) {
        printf("Password does not match expected value.\n");
        return 1;
    }
    
    printf("Password matches expected value.\n");
    return 0;
}