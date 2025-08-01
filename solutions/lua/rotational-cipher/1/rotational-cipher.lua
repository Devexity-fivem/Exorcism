return {
  rotate = function(input, key)
    local function rotate_character(char, key)
      local byte = string.byte(char)
      
      if byte >= string.byte('a') and byte <= string.byte('z') then
        -- Rotate lowercase letters
        return string.char(((byte - string.byte('a') + key) % 26) + string.byte('a'))
      elseif byte >= string.byte('A') and byte <= string.byte('Z') then
        -- Rotate uppercase letters
        return string.char(((byte - string.byte('A') + key) % 26) + string.byte('A'))
      else
        -- Non-alphabetic characters remain unchanged
        return char
      end
    end

    local result = {}

    for i = 1, #input do
      table.insert(result, rotate_character(input:sub(i, i), key))
    end

    return table.concat(result)
  end
}
