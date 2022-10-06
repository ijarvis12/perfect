--compile with ghc -Ox -threaded --make perfect2.hs [where x is # of threads]
--run with ./perfect2 +RTS -Nx [where x is the number from above]

--program that finds perfect numbers using Mersenne Primes
--multiprocessed

import Control.Monad

test :: Integer -> Integer -> [Integer]
test n p = [p `mod` n]

-- Lucas-Lehmer prime test for odd x > 2
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
    let y = ceiling (sqrt (fromIntegral p)) + 1  :: Integer
    let z = forM [1..y] $ \n -> test n p
    let fltr = snd . unzip . filter ((==0).fst) $ zip (head z) [1..]
    let fltr2 = map (div p) fltr
    when (2*p == ((sum fltr)+(sum fltr2))) $ print p
    loop (x+2)

-- starting point
main :: IO ()
main = do
    putStrLn $ id "Computing perfect numbers: "
    print 6
    print 28
    loop 5
