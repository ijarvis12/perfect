--compile with ghc -Ox -threaded --make perfect2.hs [where x is # of threads]
--run with ./perfect2 +RTS -Nx [where x is the number from above]

--program that finds perfect numbers using Mersenne Primes
--multiprocessed

import Data.List
import Control.Monad
import Control.Parallel

test :: Integer -> Integer -> [Integer]
test n p = do
    [p `mod` n]

loop :: Integer -> IO ()
loop x = do
    let p = 2^(x)*(2^(x+1)-1)
    let y = div p 2
    let z = forM [1..y] $ \n -> test n p
    let m = zip (head z) [1..]
    let fltr = snd (unzip (filter ((==0).fst) m))
    when (p == sum fltr) $ print p
    loop (x+1)

main :: IO ()
main = do
    putStrLn $ id "Computing perfect numbers: "
    let x = 1 :: Integer
    loop x
