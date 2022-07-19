--compile with ghc -Ox -threaded --make perfect2.hs [where x is # of threads]
--run with ./perfect2 +RTS -Nx [where x is the number from above]

--program that finds perfect numbers using Mersenne Primes
--multiprocessed

import Data.List
import Control.Monad
import Control.Parallel


test2 :: Integer -> [Integer] -> Integer -> Integer
test2 p primes psum = do
    let s = snd (unzip (filter ((==0).fst) (zip (map (mod p) primes) [0..])))
    let psum2 = psum + sum s
    let psum3 = psum2 + sum (map (div p) primes)
    psum3

test :: Integer -> Integer -> [Integer]
test n p = [p `mod` n]

sieveloopinner :: Integer -> Integer -> [Bool] -> [Bool]
sieveloopinner j i a = do
    let lena = fromIntegral (length a) :: Integer
    if j >= lena then
        a
    else do
        let b = (genericTake (j) a) ++ [False] ++ (genericDrop (j+1) a)
        sieveloopinner (j+i) i b

sieveloop :: Integer -> [Bool] -> [Bool]
sieveloop i a = do
    let lena = length a
    let sq = (ceiling (sqrt (fromIntegral lena))) + 1
    if i >= sq then
        a
    else do
        let b = sieveloopinner (i*i) i a
        sieveloop (i+1) b

-- Sieve for primes
sieve :: Integer -> [Integer]
sieve p = do
    let b = [False,True]
    let sq = (ceiling (sqrt (fromIntegral p))) + 1
    let c = replicate (length [2..sq]) True
    let a = b ++ c
    let sl = zip [0..] (sieveloop 2 a)
    let primes = fst (unzip (filter ((==True).snd) sl))
    primes

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

-- main loop
loop :: Integer -> IO ()
loop x = do
    when (llt 0 4 x) $ loop (x+2)
    let p = 2^(x-1)*(2^(x)-1)
--    let y = (div p 2) + 2  :: Integer
--    let z = forM [1..y] $ \n -> test n p
--    let m = zip (head z) [1..]
--    let fltr = snd (unzip (filter ((==0).fst) m))
    let primes = sieve p
    let psum = test2 p primes 0
    print psum
--    let sq = (ceiling (sqrt (fromIntegral p))) + 1
--    let lst = zip primes [2..sq]
--    let y = snd (unzip (filter (\lst -> (fst lst) /=  (snd lst)) lst))
--    print y
--    let z = forM y $ \n -> test n p
--    let m = zip (head z) [1..]
--    let fltr = snd (unzip (filter ((==0).fst) m))
--    when (2*p == ((sum fltr)+psum)) $ print p
--    loop (x+2)

-- starting point
main :: IO ()
main = do
    putStrLn $ id "Computing perfect numbers: "
    print 6
    print 28
    loop 5
