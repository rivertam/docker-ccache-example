#include "lib.h"
#include <iostream>

#pragma message("compiling Doofus")
void Doofus::speak() const { std::cerr << "Doh" << std::endl; }
