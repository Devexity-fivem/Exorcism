local alphametics = {}

-- Solve the alphametics puzzle.
-- Returns a table mapping each letter to the corresponding digit.
function alphametics.solve(puzzle)
    -- Collect all unique uppercase letters in the puzzle
    local lettersSet, lettersList = {}, {}
    for letter in puzzle:gmatch("%u") do
        if not lettersSet[letter] then
            lettersSet[letter] = true
            table.insert(lettersList, letter)
        end
    end

    -- Determine which letters cannot be zero (leading letters)
    local firstLetters = {}
    for word in puzzle:gmatch("(%u+)") do
        local first = word:sub(1, 1)
        firstLetters[first] = true
    end

    -- Assignment of letters to digits and which digits are already used
    local assignment, usedDigits = {}, {}

    -- Evaluate the puzzle once all letters have been assigned
    local function evalAssignment()
        -- Replace each letter in the puzzle with its assigned digit
        local replaced = puzzle:gsub("%u", function(c)
            return tostring(assignment[c])
        end)
        -- Use Lua's arithmetic/equality operators; prefix with 'return' to evaluate as an expression
        local chunk, err = load("return " .. replaced)
        if not chunk then
            return false
        end
        local ok, result = pcall(chunk)
        -- We consider the assignment valid only if the expression returns true
        return ok and result == true
    end

    -- Backtracking search to assign digits to letters
    local function backtrack(index)
        if index > #lettersList then
            -- All letters assigned; test if this assignment satisfies the puzzle
            if evalAssignment() then
                local result = {}
                for k, v in pairs(assignment) do
                    result[k] = v
                end
                return result
            end
            return nil
        end
        local letter = lettersList[index]
        -- Try each digit (0–9) that isn't already used
        for d = 0, 9 do
            if not usedDigits[d] and not (d == 0 and firstLetters[letter]) then
                assignment[letter] = d
                usedDigits[d] = true
                local res = backtrack(index + 1)
                if res then
                    return res
                end
                -- Backtrack
                assignment[letter] = nil
                usedDigits[d] = nil
            end
        end
        return nil
    end

    return backtrack(1)
end

return alphametics
