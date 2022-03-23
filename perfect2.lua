#!/usr/bin/env lua

--[[ program that finds perfect numbers --]]

require("math")

print("")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print(" This program finds perfect numbers using Mersenne Primes ")
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("")

-- variable maxn is the maximum number to search to
print("Enter max exponent #: ")
maxn = io.read()

-- if maxn exists, attempt to make it an integer, else exit
if #maxn > 0 then
    local function maxnToNum()
        maxn = tonumber(maxn)
        return true
    end
    if not(pcall(maxnToNum)) then
        print("Bad input")
        print("Press <Enter> to end program")
        _ = io.read()
        os.exit()
    end
else
    os.exit()
end

-- check if maxn is sane
if maxn <= 1 then
    print("Bad input")
    print("Press <Enter> to end program")
    _ = io.read()
    os.exit()
end

-- find the perfect numbers
for p = 1,maxn,1 do
    psum = 0
--  the potential perfect number
    perfect = 2^(p)*(2^(p+1)-1)

--  the limit to search to
    sqrtp = math.ceil(math.sqrt(perfect))

--  add up all the divisors into psum
    for n = 1,sqrtp,1 do
        if perfect % n == 0 then
            psum = psum + n
            psum = psum + (perfect / n)
        end
    end

--  get rid of possible extra summation
    if sqrtp^2 == perfect then
        psum = psum - sqrtp
    end

--  if psum is equal to the potenial perfect number, we have a match
    if psum == 2*perfect then
        print(perfect)
    end
end

-- end program
print("Press <Enter> to end program")
_ = io.read()
