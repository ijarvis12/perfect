#!/usr/bin/env runhaskell

--program that finds perfect numbers using Mersenne Primes

forLoop :: Integer -> [Integer] -> Integer -> Integer
forLoop y lst w = do
  if (w > ((ceiling (sqrt (fromIntegral y))) + 1)) then
    sum lst
  else do
    let m = mod y w
    if (m == 0) then do
      let n = div y w
      forLoop y (lst ++ [w,n]) (w+1)
    else
      forLoop y lst (w+1)

perfect :: Integer -> String
perfect x = do
  let y = 2^(x-1)*(2^(x)-1)
  let z = forLoop y [1] 2
  if y == z then
    show y
  else []

-- Lucas-Lehmer prime test for odd p > 2
llt :: Integer -> Integer -> Integer -> Bool
llt i s x = do
    if i == (x-2) then
      True
    else do
      let m = 2^x - 1
      let y = ((s*s)-2) `mod` m
      if y == 0 then
        False
      else
        llt (i+1) y x

loop :: Integer -> IO ()
loop x = do
  if (llt 0 4 x) then
    loop (x+2)
  else do
    let perf = perfect x
    if not (null perf) then do
      putStrLn perf
      loop (x+2)
    else
      loop (x+2)

main :: IO ()
main = do
  putStrLn "Computing perfect numbers: \n6\n28"
  loop 5
