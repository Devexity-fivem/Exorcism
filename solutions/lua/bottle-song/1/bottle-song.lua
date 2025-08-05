local BottleSong = {}

function BottleSong.recite(start_bottles, take_down)
    local numbers = { "zero", "one", "two", "three", "four", "five", "six",
                      "seven", "eight", "nine", "ten" }

    local function number_word(n, capitalize)
        local word
        if n == 0 then
            word = "no"
        elseif n <= 10 then
            word = numbers[n + 1]
        else
            word = tostring(n)
        end
        if capitalize then
            word = word:sub(1,1):upper() .. word:sub(2)
        end
        return word
    end

    local lines = {}
    for i = start_bottles, start_bottles - take_down + 1, -1 do
        local first_word = number_word(i, true)
        local bottle_word = (i == 1) and "green bottle" or "green bottles"
        table.insert(lines, first_word .. " " .. bottle_word .. " hanging on the wall,\n")
        table.insert(lines, first_word .. " " .. bottle_word .. " hanging on the wall,\n")
        table.insert(lines, "And if one green bottle should accidentally fall,\n")
        local next_i = i - 1
        local next_word = number_word(next_i, false)
        local next_bottle_word = (next_i == 1) and "green bottle" or "green bottles"
        if next_i == 0 then
            next_word = "no"
            next_bottle_word = "green bottles"
        end
        table.insert(lines,
            "There'll be " .. next_word .. " " .. next_bottle_word .. " hanging on the wall.\n")
        if i > start_bottles - take_down + 1 then
            table.insert(lines, "\n")
        end
    end
    return table.concat(lines)
end

return BottleSong
