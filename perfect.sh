#!/bin/bash

echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This program finds perfect numbers using Mersenne Primes "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

# Lucas-Lehmer prime test for odd n > 2
function LLT(){
    let "s = 4"
    let "M = (1<<$1) - 1"
    let "end = $1-1"
    for (( i=0; i<$end; i++ )); do
        let "s = (($s * $s) - 2) % $M"
        if [[ $s -eq 0 ]]; then
            echo 0
            break
        fi
    done
    if [[ $s -ne 0 ]]; then
        echo 1
    fi
}

# function perfect finds perfect numbers given inputs
# inputs: $1: number of processes the computer has (numprocs)
#         $2: process number (proc)
#         $3: number to see if perfect (p)
function perfect(){
#   variable start is the starting point
    start=$(bc <<< "sqrt($3)*$2/$1")
    if [[ start -lt 2 ]]; then
        start=2
    fi
#   variable end is the ending point
    end=$(bc <<< "sqrt($3)*($2+1)/$1")
    if [[ end -lt 3 ]]; then
        end=3
    fi
#   add all divisors into return variable
    for (( i=$start; i<$end; i++ )); do
        let "cond = $3 % $i"
        if [[ $cond -eq 0 ]]; then
            # psum += i
            # psum += p//i
            echo $i'\n' >> $sync
            echo $((p/i))"\n" >> $sync
        fi
    done
}


# get number of cpus
numprocs=$(grep processor /proc/cpuinfo | wc -l)

# allocate a shared memory segment name for this process
# NOTE: WHEN ENEVITABLY YOU CTRL-C OUT OF THE INFINITE LOOP
# CLEANUP /dev/shm
sync=/dev/shm/syncmem-$$
echo "Using $sync"

# init the shm
echo '0\n' > $sync


echo "The perfect numbers:"
echo "6"
echo "28"

# start loop to find perfect numbers
let "n = 3"
while true; do
    let "n += 2"

#   LLT check
    if [[ $(LLT $n) -eq 1 ]]; then
        continue
    fi

#   the perfect number
####p = 2**(n-1)*(2**(n)-1)
    let "p = (1<<(2*$n-1))-(1<<($n-1))"


#   start the jobs
    for (( proc=0; proc<$numprocs; proc++ )); do
        perfect $numprocs $proc $p &
    done

    wait

#   last value
    let "psum = 1"
    sqrtp=$(bc <<< "sqrt($p)")
    if [[ $((p % sqrtp)) -eq 0 ]]; then
        let "psum += $sqrtp"
    fi

#   get values
    lines=$(cat $sync)

#   add values into psum
    for i in $lines; do
        let "psum += ${i::-2}"
    done

#   see if we have a perfect number
    if [[ $psum -eq $p ]]; then
        echo $p
    fi

#   clear $sync
    echo '' > $sync

# while loop done
done

# cleanup
rm $sync

exit 0
