#!/usr/bin/env ghc

--program that finds perfect numbers using Mersenne Primes
--multiprocessed

import Data.List
import Control.Monad
import Control.Parallel
--import GHC.Conc (numCapabilities)

test :: Integer -> Integer
test y = do
    let m = map (y `mod`) [1 .. y-1]
    let f = zip [1..] m
    let fltr = fst (unzip (filter ((==0).snd) f))
    sum fltr

perfect :: Integer -> IO ()
perfect x = do
    let y = 2^(x)*(2^(x+1)-1)
    let z = test y
    if y == z then
        print (y)
    else print ""

main :: IO ()
main = do
    putStrLn $ id "Computing perfect numbers: "
    putStrLn "Enter highest power to search to: "
    i <- getLine
    let y = read i :: Integer
    let x = 1 :: Integer
    forM_ [x..y] $ \n -> (perfect n)
    putStrLn " "
