local EliudsEggs = {}

function EliudsEggs.egg_count(number)
    local count = 0
    while number > 0 do
        count = count + (number % 2)  -- Add 1 if the last bit is 1
        number = math.floor(number / 2)  -- Shift right by dividing by 2
    end
    return count
end

return EliudsEggs
