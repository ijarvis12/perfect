--compile with ghc -Ox -threaded --make perfect2.hs [where x is # of threads]
--run with ./perfect2 +RTS -Nx [where x is the number from above]

--program that finds perfect numbers using Mersenne Primes
--multiprocessed (only if Control.Parallel is uncommented and code uses forM)

--import Data.List
import Control.Monad
--import Control.Parallel


--summation :: Integer -> [Integer] -> Integer -> Integer
--summation p lst psum = do
--    let s = snd (unzip (filter ((==0).fst) (zip (map (mod p) lst) lst)))
--    let psum2 = psum + sum s
--    let psum3 = psum2 + sum (map (div p) s)
--    psum3

--test :: Integer -> Integer -> [Integer]
--test n p = [p `mod` n]

{-
sieveloopinner :: Integer -> Integer -> [Bool] -> [Bool]
sieveloopinner j i a = do
    let lena = fromIntegral (length a) :: Integer
    if j > lena then
        a
    else do
        let b = (genericTake (j-1) a) ++ [False] ++ (genericDrop (j) a)
        sieveloopinner (j+i) i b

sieveloop :: Integer -> [Bool] -> [Bool]
sieveloop i a = do
    let lena = length a
    let sq = (ceiling (sqrt (fromIntegral lena))) + 1
    if i > sq then
        a
    else do
        let b = sieveloopinner (i*i) i a
        sieveloop (i+1) b

-- Sieve for primes
--[sieve :: Integer -> [Bool]
sieve p = do
    let sq = (ceiling (sqrt (fromIntegral p))) + 1
    let a = replicate (length [2..sq]) True
    sieveloop 2 a
-}

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
    let p = 2^(x-1)*(2^(x)-1) :: Integer
--    let y = ceiling (sqrt (fromIntegral p)) + 1  :: Integer
--    let z = forM [1..y] $ \n -> test n p
--    let fltr = snd . unzip . filter ((==0).fst) $ zip (head z) [1..]
--    let fltr2 = map (div p) fltr
--    let primesb = sieve p
--    let primes = fst.unzip.filter ((==True).snd) $ zip [2..] primesb
    let divisors = 1 : filter ((==0) . rem p) [2 .. p `div` 2]
    when (p == (sum divisors)) $ print p
--    let y = map snd . filter ((==False).fst) $ zip primesb [1..]
--    let z = forM (sort (primes++y)) $ \n -> test n p
--    let fltr = snd.unzip.filter ((==0).fst) $ zip (head z) [1..]
--    let psum = summation p (head z) 0
--    let psum = summation p y 0
--    let psum2 = summation p primes psum
--    when (2*p == psum2) $ print p
--    when (2*p == ((sum fltr)+(sum fltr2))) $ print p
    loop (x+2)

-- starting point
main :: IO ()
main = do
    putStrLn $ id "Computing perfect numbers: "
    print 6
    print 28
    loop 5
