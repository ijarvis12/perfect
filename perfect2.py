#!/usr/bin/python3

##                                     ##
## program that finds perfect numbers  ##
##                                     ##

from math import sqrt

print("")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print(" This program finds perfect numbers using Mersenne Primes ")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("")

# variable maxn is the maximum number to search to
maxn = input("Enter max exponent #: ")

# if maxn exists, attempt to make it an integer, else exit
if len(maxn) > 0:
    try:
        maxn = int(maxn)
    except:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
else:
    exit()

# check if maxn is sane
if maxn <= 1:
    print("Bad input")
    garbage = input("Press <Enter> to end program")
    exit()

print("The perfect numbers:")

# find the perfect numbers
for p in range(1,maxn):
    psum = 0
#   the potential perfect number
    perfect = 2**(p)*(2**(p+1)-1)

#   the limit to search to
    sqrtp = int(sqrt(perfect))

#   add up all the divisors into psum
    for n in range(1,sqrtp+1):
        if perfect % n == 0:
            psum += n
            psum += perfect // n

#   get rid of possible extra summation
    if sqrtp**2 == perfect:
        psum -= sqrtp

#   if psum is equal to the potenial perfect number, we have a match
    if psum == 2*perfect:
        print(perfect)

garbage = input("Press <Enter> to end program")
