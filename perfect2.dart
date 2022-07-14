/*
 * program that finds perfect numbers
*/

import 'dart:math';
import 'dart:io';

void main() {
        print("");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(" This program finds perfect numbers using Mersenne Primes ");
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print("");

        // variable maxn is the maximum number to search to
        print("Enter max exponent #: ");
        int? maxn = int.tryParse(stdin.readLineSync()!);

        // if maxn exists, attempt to make it an integer, else exit
        if(maxn == null) {
                print("Bad input");
                print("Press <Enter> to end program");
                String? _ = stdin.readLineSync()!;
                return;
        }

        // check if maxn is sane
        if(maxn <= 1) {
                print("Bad input");
                print("Press <Enter> to end program");
                String? _ = stdin.readLineSync()!;
                return;
        }

        print("The perfect numbers:");

        // find the perfect numbers
        for(int p = 1; p < maxn; p++) {
                BigInt psum = BigInt.zero;

                // the potential perfect number
                BigInt perfect = BigInt.two.pow(p)*(BigInt.two.pow(p+1) - BigInt.one);

                // stop is the stopping point
                // cant use sqrt because not implemented for BigInt
                BigInt stop = BigInt.from(perfect / BigInt.two) + BigInt.one;

                // add up all the divisors into psum
                for(BigInt n = BigInt.one; n < stop; n = n + BigInt.one) {
                        if(perfect % n == BigInt.zero) {
                                psum = psum + n;
                        }
                }

                if(stop*stop == perfect) {
                        psum = psum - stop;
                }

                // if psum is equal to the potenial perfect number, we have a match
                if(psum == perfect) {
                        print(perfect);
                }
        }

        print("Press <Enter> to end program");
        String? _ = stdin.readLineSync()!;
}
