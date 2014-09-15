// main.cpp - example program using factorial function
#include <iostream>
using namespace std;

#include "factorial.h"

int main( int argc, const char* argv[] ) {
    int result = Factorial(6);
    cout << "The factorial of 6 is " << result << endl;
    return 0;
}
