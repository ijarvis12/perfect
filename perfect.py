#!/usr/bin/python3

def perfect(numprocs,proc,maxn):
    for p in range(int(float(maxn*proc)/float(numprocs)),int(float(maxn*(proc+1))/float(numprocs))):
        psum = 0
        perfect = 2**(p)*(2**(p+1)-1)

        for n in range(1,perfect):
            if perfect%n == 0:
                psum += n

        if psum == perfect:
            print(perfect)


if __name__ == '__main__':

    import multiprocessing
    from time import sleep

    numprocs = multiprocessing.cpu_count()

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
            exit()
    else:
        exit()

    if maxn < 0:
        print("Bad input")
        garbage = input("Press <Enter> to end program")
        exit()

    print("The perfect numbers:")

    jobs = []
    for proc in range(numprocs):
        job = multiprocessing.Process(target=perfect, args=(numprocs,proc,maxn,))
        jobs.append(job)
        job.start()
        sleep(0.1)
    for job in jobs:
        job.join()

    garbage = input("Press <Enter> to end program")
