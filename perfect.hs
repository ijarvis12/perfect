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

test :: Integer -> Integer
test y = forLoop y [1] 2

{-
test :: Integer -> Integer
test y = do
  let m = map (y `mod`) [1 .. (div y 2)]
  let f = zip [1..] m
  let fltr = fst (unzip (filter ((==0).snd) f))
  sum fltr
-}

perfect :: Integer -> String
perfect x = do
  let y = 2^(x)*(2^(x+1)-1)
  let z = test y
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
