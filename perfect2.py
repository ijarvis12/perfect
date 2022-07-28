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
    M = 2**p - 1
    for n in range(0,p-2):
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
    psum = 0

#   LLT check
    if LLT(p):
        continue

#   the potential perfect number
    perfect = 2**(p-1)*(2**(p)-1)

#   the limit to search to
    sqrtp = int(sqrt(perfect))

#   Sieve for primes
    A = [False,True]
    for i in range(2,sqrtp+1):
        A.append(True)
    for i in range(2,int(sqrt(sqrtp))+1):
        if A[i]:
            for j in range(i*i,sqrtp+1,i):
                A[j] = False
    primes = []
    for i,a in enumerate(A):
        if a:
            primes.append(i)

#   add up all the divisors into psum
#    for n in range(1,sqrtp+1):
#        if perfect % n == 0:
#            psum += n
#            psum += perfect // n

    for pri in primes:
        if perfect % pri == 0:
            psum += pri
            psum += perfect // pri
        elif pri != primes[-1]:
            n = pri
#            stop = primes[primes.index(pri)+1]
#            while True:
#                if n >= stop:
#                    break
#                n += 1
            for n in range(pri,primes[primes.index(pri)+1]):
                if perfect % n == 0:
                    psum += n
                    psum += perfect // n
                    break

#   get rid of possible extra summation
    if sqrtp**2 == perfect:
        psum -= sqrtp

#   if psum is equal to the potenial perfect number, we have a match
    if psum == 2*perfect:
        print(perfect)
