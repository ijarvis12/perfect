#!/usr/bin/env python3

##                                     ##
## program that finds perfect numbers  ##
##                                     ##

from math import sqrt

print("")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print(" This program finds perfect numbers using Mersenne Primes ")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("")

# Lucas-Lehmer prime test for odd p > 2
def LLT(p):
    s = 4
    M = (1<<p) - 1
    for n in range(0,p-1):
        s = ((s * s) - 2) % M;
        if(s == 0):
            return False
    return True

print("The perfect numbers:")
print(6)

# find the perfect numbers
p = 1
while True:
    p += 2

#   LLT check
    if LLT(p):
        continue

#   summation var of divisors
    psum = 1

#   the potential perfect number
####perfect = 2**(p-1)*(2**(p)-1)
    perfect = (1<<(2*p-1))-(1<<(p-1))

#   the limit to search to
    sqrtp = int(sqrt(perfect))

#   add up all the divisors into psum
    for n in range(2,sqrtp+1):
        if perfect % n == 0:
            psum += n
            psum += perfect // n

#   get rid of possible extra summation
    if sqrtp**2 == perfect:
        psum -= sqrtp

#   if psum is equal to the potenial perfect number, we have a match
    if psum == perfect:
        print(perfect)
