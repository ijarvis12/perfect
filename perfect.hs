#!/usr/bin/env runhaskell

--program that finds perfect numbers using Mersenne Primes

-- for bit shifting
import Data.Bits

check :: Integer -> Integer -> Bool
check p w = (mod p w) == 0

forLoop :: Integer -> [Integer] -> Bool -> Integer -> Integer
forLoop _ lst _ 1 = toInteger (sum lst)
forLoop p lst False w = do {let b = check p (w-1); forLoop p lst b (w-1)}
forLoop p lst True w = do
    let n = div p w
    let b = check p (w-1)
    forLoop p (lst ++ [w,n]) b (w-1)

prnt :: Integer -> Bool -> IO ()
prnt _ False = return ()
prnt p True = print p

perfect :: Integer -> IO ()
perfect p = do
  let end = toInteger (ceiling (sqrt (fromIntegral p)))
  let b = check p end
  let z = forLoop p [1] b end
  let n = z - (end * (toInteger (fromEnum (end*end == z))))
  prnt p (p==n)

-- Lucas-Lehmer prime test for odd x > 2
llt :: Int -> Integer -> Integer -> Integer -> Bool -> IO () 
llt x _ m 0 False = perfect (((shiftL 1 (x-1)) :: Integer) * m)
llt _ _ _ _ True = return ()
llt x s m end False = do
    let y = ((s*s)-2) `mod` m
    llt x y m (end-1) (y==m)

loop :: Int -> IO ()
loop x = do
    let m = ((shiftL 1 x) :: Integer) - 1
    llt x 4 m (m-2) False
    loop (x+2)

main :: IO ()
main = do
  putStrLn "Computing perfect numbers: \n6\n28"
  loop 5
