-- collatz-conjecture.lua

-- Return the number of steps required to reach 1 using the Collatz Conjecture.
-- If n is not a positive integer, this function throws an error.
return function(n)
    -- Only positive numbers are allowed.
    if n == nil or n < 1 then
        error("Only positive numbers are allowed")
    end

    -- Count steps until n becomes 1.
    local steps = 0
    while n > 1 do
        if n % 2 == 0 then
            -- n is even: divide by 2.
            n = n / 2
        else
            -- n is odd: multiply by 3 and add 1.
            n = 3 * n + 1
        end
        steps = steps + 1
    end

    return steps
end
