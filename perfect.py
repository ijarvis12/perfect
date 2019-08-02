#!/usr/bin/python3

# function perfect finds perfect numbers given inputs
# inputs: numprocs: number of processes the computer has
#             proc: process number
#                p: number to see if perfect
#      return_dict: dictionary of return values
def perfect(numprocs,proc,p,return_dict):
#   variable start is the starting point
    start = p*proc//(2*numprocs)
    if start < 1:
        start = 1

#   variable end is the ending point
    end = p*(proc+1)//(2*numprocs)
    if end < 2:
        end = 2

#   add up all divisors into variable psum
    for n in range(start,end+1):
        if p%n == 0:
            return_dict[n] = n
            

##                                                           ##
## main process that spawns jobs to look for perfect numbers ##
##                                                           ##
if __name__ == '__main__':

    import multiprocessing
    from time import sleep

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
    if maxn < 1:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
        exit()

    print("The perfect numbers:")

#   shared dictionary between processes
    return_dict = multiprocessing.Manager().dict()

#   start loop to find perect numbers
    for n in range(1,maxn):

#       start the jobs
        jobs = []
        return_dict.clear()
        p = 2**(n)*(2**(n+1)-1)
        
        for proc in range(numprocs):
            job = multiprocessing.Process(target=perfect, args=(numprocs,proc,p,return_dict,))
            jobs.append(job)
            job.start()

#       wait for jobs to finish
        for job in jobs:
            job.join()

#       add up values in return_dict to see if perfect number
        psum = 0
        for key,value in return_dict.items():
            psum += key
        if psum == p:
            print(p)

    garbage = input("Press <Enter> to end program")
