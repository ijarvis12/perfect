#!/usr/bin/env python3

# function perfect finds perfect numbers given inputs
# inputs: numprocs: number of processes the computer has
#             proc: process number
#                p: number to see if perfect
#             psum: summation of divisors
def perfect(numprocs,proc,p,psum):
#   variable start is the starting point
    start = int(sqrt(p))*proc//numprocs
    if start < 1:
        start = 1

#   variable end is the ending point
    end = int(sqrt(p))*(proc+1)//numprocs
    if end < 2:
        end = 2

#   add all divisors into return variable
    for n in range(start,end):
        if p % n == 0:
            psum.value += n
            psum.value += p//n

    return


##                                                           ##
## main process that spawns jobs to look for perfect numbers ##
##                                                           ##
if __name__ == '__main__':

    import multiprocessing
    from math import sqrt

#   variable that holds the number of processes the computer has
    numprocs = multiprocessing.cpu_count()

    print("")
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print(" This program finds perfect numbers using Mersenne Primes ")
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    print("")

#   Lucas-Lehmer prime test for odd p > 2
    def LLT(p):
        s = 4
        M = (1<<p) - 1
        for n in range(0,p-1):
            s = ((s * s) - 2) % M;
            if(s == 0):
                return False
        return True

    print("The perfect numbers:")
#   print the first two perfect numbers (too hard to get the program to compute on its own)
    print(6)
    print(28)

#   start loop to find perfect numbers
    n = 1
    while True:
        n += 2

#       LLT check
        if LLT(n):
            continue

#       jobs list
        jobs = []

#       shared list between processes
#       return_list = multiprocessing.Manager().list()
#       shared summation variable of divisors
        psum = multiprocessing.Manager().Value('i',0)

#       the perfect number
#       p = 2**(n-1)*(2**(n)-1)
        p = (1<<(2*n-1))-(1<<(n-1))

#       start the jobs
        for proc in range(numprocs):
            job = multiprocessing.Process(target=perfect, args=(numprocs,proc,p,psum,))
            jobs.append(job)
            job.start()

#       wait for jobs to finish
        for job in jobs:
            job.join()

#       see if we have a perfect number
        if psum.value == (p*2):
            print(p)
