local Atbash = {}

-- Helper function to reverse letters
local function atbash_char(c)
    if c:match("%d") then
        return c -- Keep numbers unchanged
    elseif c:match("[a-z]") then
        return string.char(219 - string.byte(c)) -- Reverse letter (a=97 -> z=122)
    end
    return "" -- Ignore punctuation and spaces
end

-- Helper function to format into groups of 5
local function group_output(str)
    local grouped, count = {}, 0
    for i = 1, #str do
        table.insert(grouped, str:sub(i, i))
        count = count + 1
        if count == 5 and i < #str then
            table.insert(grouped, " ")
            count = 0
        end
    end
    return table.concat(grouped)
end

-- Encode function
function Atbash.encode(plaintext)
    local cleaned_text = plaintext:lower():gsub("%W", "") -- Remove non-alphanumeric characters
    local transformed = cleaned_text:gsub(".", atbash_char) -- Apply Atbash cipher
    return group_output(transformed) -- Format output in groups of 5
end

return Atbash
