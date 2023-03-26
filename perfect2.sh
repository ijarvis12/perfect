#!/bin/bash

echo
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo " This program finds perfect numbers using Mersenne Primes "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

# Lucas-Lehmer prime test for odd p > 2
function LLT(){
    let "s = 4"
    let "M = (1<<$1) - 1"
    let "end = $1-1"
    for ((n=0; n<$end; n++)); do
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

echo "The perfect numbers:"
echo "6"

# find the perfect numbers
let "p = 1"
while true; do
    let "p += 2"

#   LLT check
    if [[ $(LLT $p) -eq 1 ]]; then
        continue
    fi

#   summation var of divisors
    let "psum = 1"

#   the potential perfect number
####perfect = 2**(p-1)*(2**(p)-1)
    let "perfect = (1<<(2*$p-1))-(1<<($p-1))"

#   the limit to search to
#   sqrtp = int(sqrt(perfect))
    sqrtp=$(bc <<< "sqrt($perfect)")

#   add up all the divisors into psum
    let "end = $sqrtp + 1"
    for ((n = 2 ; n < $end ; n++)); do
        let "cond = $perfect % $n"
        if [[ $cond -eq 0 ]]; then
            let "psum += $n"
            let "psum += $perfect / $n"
        fi
    done

#   get rid of possible extra summation
    let "cond = $sqrtp*$sqrtp"
    if [[ $cond -eq $perfect ]]; then
        let "psum -= $sqrtp"
    fi

#   if psum is equal to the potenial perfect number, we have a match
    if [[ $psum -eq $perfect ]]; then
        echo $perfect
    fi

done
