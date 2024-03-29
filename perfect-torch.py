#!/usr/bin/env python3

##                                         ##
##    program that finds perfect numbers   ##
##                                         ##
## note: writes files in same directory if ##
##       numbers get too big to display    ##
##                                         ##

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
print('p = 2 : perfect = 6')

# find the perfect numbers
p = 1
while p<32:
	p += 2

#	LLT check
	if LLT(p):
		continue

#	use gpu
	with torch.cuda.device(cuda):

#		summation var of divisors
		psum = torch.tensor(1, device=cuda)
		
#		the potential perfect number
########perfect = 2**(p-1)*(2**(p)-1)
		perfect = torch.tensor((1<<(2*p-1))-(1<<(p-1)))
		
#		the limit to search to
		sqrtp = torch.tensor(int(sqrt(perfect.item())))
		
#		send to gpu
		perfect.to(device=cuda)
		sqrtp.to(device=cuda)
		
#		add up all the divisors into psum
		end = sqrtp.item() + 1
		for n in range(2,end):
			if perfect % n == 0:
				psum += n
				psum += perfect // n
		
#		send vars to cpu for further analysis
		sqrtp.to(device=cpu)
		psum.to(device=cpu)
		perfect.to(device=cpu)
		
#	get rid of possible extra summation
	if sqrtp.item()**2 == perfect.item():
		psum -= sqrtp
	
#	if psum is equal to the potenial perfect number, we have a match
	if psum.item() == perfect.item():
		print('p =',p,end='')
		try:
			print(' : perfect =',perfect.item())
#		for large perfect numbers too big to display (length > 4300 digits),
#		write to file instead
		except:
			print()
			with open('p='+str(p)+'.txt', 'w') as file:
				file.write(perfect.item())

print()
_ = input('Press <Enter> to end program.')
