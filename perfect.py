#!/usr/bin/python3

# function perfect finds perfect numbers given inputs
# inputs: numprocs: number of processes the computer has
#             proc: process number
#             maxn: maximum number to search to
def perfect(numprocs,proc,maxn):
#   setup the correct range to search within
    for p in range(int(float(maxn*proc)/float(numprocs)),int(float(maxn*(proc+1))/float(numprocs))):
        psum = 0
#       the potential perfect number
        perfect = 2**(p)*(2**(p+1)-1)

#       add up all divisors into variable psum
        for n in range(1,perfect):
            if perfect%n == 0:
                psum += n

#       if the sum of the divisors equals the potenial perfect number, we have a match
        if psum == perfect:
            print(perfect)

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
    maxn = input("Enter max exponent #: ")

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
    if maxn < 0:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
        exit()

    print("The perfect numbers:")

#   start the jobs
    jobs = []
    for proc in range(numprocs):
        job = multiprocessing.Process(target=perfect, args=(numprocs,proc,maxn,))
        jobs.append(job)
        job.start()
#       sleep the main process to let the job start before spawning another
        sleep(0.1)
#   wait for jobs to finish
    for job in jobs:
        job.join()

    garbage = input("Press <Enter> to end program")
