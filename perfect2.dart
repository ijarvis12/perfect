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

// Sieve of Eratosthenes
List<int> Sieve() {
        List<bool> A = [true,true];
        int stop = 100000000;
        for(int n = 2; n < stop; n++) {
                A.add(true);
        }
        int stop2 = sqrt(stop).round();
        for(int i = 2; i < stop2; i++) {
                if(A[i]) {
                        for(int j = i*i; j < stop; j = j + i) {
                                A[j] = false;
                        }
                }
        }
        List<int> primes = [];
        for(int k = 1; k < A.length; k++) {
                if(A[k]) {
                        primes.add(k);
                }
        }
        return primes;
}

void main() {
        print("");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(" This program finds perfect numbers using Mersenne Primes ");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print("");

        print("The perfect numbers:");
        print(6);

        // prime sieve list
        //List<int> primes = Sieve();
        //BigInt pri;

        // find the perfect numbers
        for(int p = 3; p < 21; p+=2) {

                // LLT test
                if(LLT(p)) {
                        continue;
                }

                BigInt psum = BigInt.zero;

                // the potential perfect number
                BigInt perfect = BigInt.two.pow(p-1)*(BigInt.two.pow(p) - BigInt.one);

                // use Newton's method for sqrt for stopping point
                BigInt stop = NewtonSqrt(perfect);

                // add up all the divisors into psum
                for(BigInt n = BigInt.one; n < stop; n = n + BigInt.one) {
                        if(perfect % n == BigInt.zero) {
                                psum = psum + n;
                                psum = psum + BigInt.from(perfect / n);
                        }
                }

                /*int count = 0;
                for(BigInt pri = BigInt.from(primes[0]); pri < stop; pri = BigInt.from(primes[++count])) {
                        print("pri $pri ,perfect $perfect");
                        if(perfect % pri == BigInt.zero) {
                                psum = psum + pri;
                                psum = psum + BigInt.from(perfect / pri);
                        }
                        for(BigInt x = pri; x < BigInt.from(primes[count+1]); x = x + BigInt.one) {
                                if(perfect % x == BigInt.zero) {
                                        psum = psum + x;
                                        psum = psum + BigInt.from(perfect / x);
                                        break;
                                }
                        }
                }*/

                // get rid of extra possible summation
                if(stop*stop == perfect) {
                        psum = psum - stop;
                }


                // if psum is equal to the potenial perfect number, we have a match
                if(psum == BigInt.two*perfect) {
                        print(perfect);
                }
        }
}
