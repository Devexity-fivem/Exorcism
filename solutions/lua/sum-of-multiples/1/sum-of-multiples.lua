local sum_of_multiples = {}

function sum_of_multiples.to(base_values)
    return function(limit)
        local unique_multiples = {}

        -- Find multiples for each base value
        for _, base in ipairs(base_values) do
            for i = base, limit - 1, base do
                unique_multiples[i] = true  -- Store unique multiples
            end
        end

        -- Calculate the sum of unique multiples
        local sum = 0
        for k, _ in pairs(unique_multiples) do
            sum = sum + k
        end

        return sum
    end
end

return function(numbers)
    return setmetatable({}, { __index = function(_, key)
        if key == "to" then
            return sum_of_multiples.to(numbers)  -- Return the function for the limit
        end
    end })
end
