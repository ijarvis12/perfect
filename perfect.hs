#!/usr/bin/env runhaskell

--program that finds perfect numbers using Mersenne Primes

import Control.Monad

check :: Integer -> Integer -> Bool
check y w = (mod y w) == 0

forLoop :: Integer -> [Integer] -> Bool -> Integer -> Integer
forLoop y lst b 1 = toInteger (sum lst)
forLoop y lst False w = do
    let b = check y (w-1)
    forLoop y lst b (w-1)
forLoop y lst True w = do
    let n = div y w
    let b = check y (w-1)
    forLoop y (lst ++ [w,n]) b (w-1)

perfect :: Integer -> Integer -> Bool
perfect x m = do
  let y = (2^(x-1)) * m
  let end = toInteger (ceiling (sqrt (fromIntegral y)))
  let b = check y end
  let z = forLoop y [1] b end
  let n = z - (end * (toInteger (fromEnum (end*end == z))))
  y == n

-- Lucas-Lehmer prime test for odd x > 2
llt :: Integer -> Integer -> Integer -> Bool -> Bool
llt s m 0 False = False
llt s m end True = True
llt s m end False = do
    let y = ((s*s)-2) `mod` m
    llt y m (end-1) (y==m)

loop :: Integer -> Bool -> IO ()
loop x True = do
    print (2^(x-1)*(2^(x)-1))
    loop (x+2) False
loop x False = do
    let m = 2^x - 1
    let l = llt 4 m (m-2) False
    when l $ loop (x+2) False
    let perf = perfect x m
    when perf $ loop x True
    loop (x+2) False

main :: IO ()
main = do
  putStrLn "Computing perfect numbers: \n6\n28"
  loop 5 True
