#!/usr/bin/python3

print("")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print(" This program finds perfect numbers using Mersenne Primes ")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("")

maxn = input("Enter max exponent #: ")

if len(maxn) > 0:
    try:
        maxn = int(maxn)
    except:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
else:
    exit()

if maxn <= 1:
    print("Bad input")
    garbage = input("Press <Enter> to end program")
    exit()

print("The perfect numbers:")

for p in range(1,maxn):
    psum = 0
    perfect = 2**(p)*(2**(p+1)-1)

    for n in range(1,perfect):
        if perfect%n == 0:
            psum += n

    if psum == perfect:
        print(perfect)

garbage = input("Press <Enter> to end program")
