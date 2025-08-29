#include <assert.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <stdio.h>

int main() {
	void* handle_a = dlopen("./a/libside.so", RTLD_NOW);
	if (!handle_a) {
		printf("dlopen a/libside.so failed: %s\n", dlerror());
		return 1;
	}
	void* handle_b = dlopen("./b/libside.so", RTLD_NOW);
	if (!handle_b) {
		printf("dlopen b/libside.so failed: %s\n", dlerror());
		return 1;
	}
	assert(handle_a != handle_b);

	char (*module_name_a)() = (char (*)())dlsym(handle_a, "module_name");
	if (!module_name_a) {
		printf("loading module_name from a/libside.so failed: %s\n", dlerror());
		return 1;
	}
	char (*module_name_b)() = (char (*)())dlsym(handle_b, "module_name");
	if (!module_name_b) {
		printf("loading module_name from b/libside.so failed: %s\n", dlerror());
		return 1;
	}
	assert(handle_a != handle_b);

	char name_a = module_name_a();
	char name_b = module_name_b();

	printf("The dynamic library A returned: %c\n", name_a);
	printf("The dynamic library B returned: %c\n", name_b);
	
	assert(name_a == 'A');
	assert(name_b == 'B');
	exit(0);
}