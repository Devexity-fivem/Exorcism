local leap_year = function(number)
    if number % 4 == 0 then
        if number % 100 == 0 then
            if number % 400 == 0 then
                return true  -- Leap year
            else
                return false -- Not a leap year
            end
        else
            return true  -- Leap year
        end
    else
        return false -- Not a leap year
    end
end

return leap_year
