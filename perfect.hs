#!/usr/bin/env runhaskell

--program that finds perfect numbers using Mersenne Primes

test :: Integer -> Integer
test y = do
  let m = map (y `mod`) [1 .. (div y 2)]
  let f = zip [1..] m
  let fltr = fst (unzip (filter ((==0).snd) f))
  sum fltr
    

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
  putStrLn "Computing perfect numbers: "
  let x = 1 :: Integer
  loop x
