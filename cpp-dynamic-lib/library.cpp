#include <iostream>

extern "C" void cpp_function() {
    std::cout << "Hello world from C++" << std::endl;
}
