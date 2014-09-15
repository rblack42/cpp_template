//! Demonstration function
#include "factorial.h"

unsigned int Factorial( unsigned int number) {
    //! Integer factorial function
    /*!
        \sa Factorial
        \param number  the number whose factorial you want
    */
    return number <= 1 ? number : Factorial(number-1) * number;
}


