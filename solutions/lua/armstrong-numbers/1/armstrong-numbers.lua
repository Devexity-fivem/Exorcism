local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
    -- Convert the number to a string to easily access its digits
    local str_num = tostring(number)
    local num_digits = #str_num
    local sum = 0

    -- Calculate the sum of each digit raised to the power of the number of digits
    for digit in str_num:gmatch(".") do
        sum = sum + tonumber(digit) ^ num_digits
    end

    -- Check if the sum equals the original number
    return sum == number
end

return ArmstrongNumbers
