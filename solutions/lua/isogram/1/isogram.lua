return function(s)
    s = s:lower()
    local seen = {}

    for char in s:gmatch("%a") do -- Only check letters
        if seen[char] then
            return false
        end
        seen[char] = true
    end

    return true
end
