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
  let y = 2^(x)*(2^(x+1)-1)
  let z = forLoop y [1] 2
  if y == z then
      show y
  else []

loop :: Integer -> IO ()
loop x = do
  let perf = perfect x
  if not (null perf) then do
      putStrLn perf
      loop (x+1)
  else
      loop (x+1)

main :: IO ()
main = do
  putStrLn "Computing perfect numbers: \n6\n28"
  loop 1
