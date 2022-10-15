#!/usr/bin/env dart

/*
 * program that finds perfect numbers
*/

import 'dart:math';
import 'dart:io';

// Lucas-Lehmer prime test for odd p > 2
bool LLT(int p) {
        BigInt s = BigInt.two + BigInt.two;
        BigInt M = BigInt.two.pow(p) - BigInt.one;
        for(int n = 0; n < p-2; n += 1) {
                s = ((s * s) - BigInt.two) % M;
                if(s == BigInt.zero) {
                        return false;
                }
        }
        return true;
}

// Newton's method for square roots
BigInt NewtonSqrt(BigInt perfect) {
        double? root,check;
        double x = perfect / BigInt.two;
        double n = x;
        while(true) {
                root = 0.5 * (x + (n / x));
                check = root - x;
                if(check > 0 && check < 1) {
                        break;
                }
                else if(check < 0 && check > -1) {
                        break;
                }
                x = root;
        }
        return (BigInt.from(root) + BigInt.two); 
}

void main() {
        print("");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(" This program finds perfect numbers using Mersenne Primes ");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print("");

        print("The perfect numbers:");
        print(6);

        // find the perfect numbers
        for(int p = 3; p < 21; p+=2) {

                // LLT test
                if(LLT(p)) {
                        continue;
                }

                BigInt psum = BigInt.one;

                // the potential perfect number
                BigInt perfect = BigInt.two.pow(p-1)*(BigInt.two.pow(p) - BigInt.one);

                // use Newton's method for sqrt for stopping point
                BigInt stop = NewtonSqrt(perfect);

                // add up all the divisors into psum
                for(BigInt n = BigInt.two; n < stop; n = n + BigInt.one) {
                        if(perfect % n == BigInt.zero) {
                                psum = psum + n;
                                psum = psum + BigInt.from(perfect / n);
                        }
                }

                // get rid of extra possible summation
                if(stop*stop == perfect) {
                        psum = psum - stop;
                }


                // if psum is equal to the potenial perfect number, we have a match
                if(psum == perfect) {
                        print(perfect);
                }
        }
}
