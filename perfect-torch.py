#!/usr/bin/env python3

##                                     ##
## program that finds perfect numbers  ##
##                                     ##

import torch
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

cpu = torch.device('cpu')
cuda = torch.device('cuda')

print("The perfect numbers:")
print(6)

# find the perfect numbers
p = 1
while p<30:
    p += 2

#   LLT check
    if LLT(p):
        continue

	with torch.cuda.device()

#       summation var of divisors
		psum = torch.tensor(0, device=cuda)
		
#       the potential perfect number
########perfect = 2**(p-1)*(2**(p)-1)
		perfect = torch.tensor((1<<(2*p-1))-(1<<(p-1))).cuda()
		
#       the limit to search to
		sqrtp = torch.tensor(int(sqrt(perfect))), device=cuda)
		
#       add up all the divisors into psum
		for n in range(1,sqrtp.item()+1):
			if perfect % n == 0:
			psum += n
			psum += perfect // n
		
#       send vars to cpu for further analysis
		sprtp.to(device=cpu)
		psum.to(device=cpu)
		perfect.to(device=cpu)
		
#   get rid of possible extra summation
	if sqrtp.item()**2 == perfect.item():
		psum -= sqrtp
	
#   if psum is equal to the potenial perfect number, we have a match
	if psum.item() == 2*perfect.item():
		print(perfect.item())

print()
_ = input('Press <Enter> to end program.')
