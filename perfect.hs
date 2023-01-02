#!/usr/bin/env runhaskell

--program that finds perfect numbers using Mersenne Primes

-- for bit shifting
import Data.Bits

-- for 'when' stmts
import Control.Monad

check :: Integer -> Integer -> Bool
check p w = (mod p w) == 0

forLoop :: Integer -> [Integer] -> Bool -> Integer -> Integer
forLoop p lst b 1 = toInteger (sum lst)
forLoop p lst False w = do
    let b = check p (w-1)
    forLoop p lst b (w-1)
forLoop p lst True w = do
    let n = div p w
    let b = check p (w-1)
    forLoop p (lst ++ [w,n]) b (w-1)

perfect :: Int -> Integer -> IO ()
perfect x m = do
  let p = ((shiftL 1 (x-1)) :: Integer) * m
  let end = toInteger (ceiling (sqrt (fromIntegral p)))
  let b = check p end
  let z = forLoop p [1] b end
  let n = z - (end * (toInteger (fromEnum (end*end == z))))
  when (p == n) $ print p

-- Lucas-Lehmer prime test for odd x > 2
llt :: Integer -> Integer -> Integer -> Bool -> Bool
llt s m 0 False = False
llt s m end True = True
llt s m end False = do
    let y = ((s*s)-2) `mod` m
    llt y m (end-1) (y==m)

loop :: Int -> IO ()
loop x = do
    let m = ((shiftL 1 x) :: Integer) - 1
    let l = llt 4 m (m-2) False
    when l $ loop (x+2)
    perfect x m
    loop (x+2)

main :: IO ()
main = do
  putStrLn "Computing perfect numbers: \n6\n28"
  loop 5
