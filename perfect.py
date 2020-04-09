#!/usr/bin/python3

# function perfect finds perfect numbers given inputs
# inputs: numprocs: number of processes the computer has
#             proc: process number
#                p: number to see if perfect
#      return_list: list of return values
def perfect(numprocs,proc,p,return_list):
#   variable start is the starting point
    start = int(sqrt(p))*proc//numprocs
    if start < 1:
        start = 1

#   variable end is the ending point
    end = int(sqrt(p))*(proc+1)//numprocs
    if end < 2:
        end = 2

#   add up all divisors into variable psum
    for n in range(start,end+1):
        if p%n == 0:
            return_list.append(n)
            return_list.append(p//n)


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

#   maximum number to search to
    maxn = input("Enter max Mersenne prime power: ")

#   if maxn has input, attempt to make it an integer, else exit
    if len(maxn) > 0:
        try:
            maxn = int(maxn)
        except:
            print("Bad input")
            garbage = input("Press <Enter> to end program")
            exit()
    else:
        exit()

#   check to see if maxn is sane
    if maxn < 3:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
        exit()

    print("The perfect numbers:")

#   print the first perfect number (too hard to get the program to compute on its own)
    print(6)

#   start loop to find perect numbers
    for n in range(2,maxn):

#       jobs list
        jobs = []
        
#       shared list between processes
        return_list = multiprocessing.Manager().list()
        
#       the perfect number
        p = 2**(n)*(2**(n+1)-1)

#       start the jobs
        for proc in range(numprocs):
            job = multiprocessing.Process(target=perfect, args=(numprocs,proc,p,return_list,))
            jobs.append(job)
            job.start()

#       wait for jobs to finish
        for job in jobs:
            job.join()

#       add up values in return_dict to see if perfect number
        psum = 0
        for l in return_list:
            psum += l
        if psum == p*2:
            print(p)

    garbage = input("Press <Enter> to end program")
