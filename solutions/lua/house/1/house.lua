
local parts = {
    { subject = "house that Jack built." },
    { subject = "malt", action = "lay in" },
    { subject = "rat", action = "ate" },
    { subject = "cat", action = "killed" },
    { subject = "dog", action = "worried" },
    { subject = "cow with the crumpled horn", action = "tossed" },
    { subject = "maiden all forlorn", action = "milked" },
    { subject = "man all tattered and torn", action = "kissed" },
    { subject = "priest all shaven and shorn", action = "married" },
    { subject = "rooster that crowed in the morn", action = "woke" },
    { subject = "farmer sowing his corn", action = "kept" },
    { subject = "horse and the hound and the horn", action = "belonged to" },
}

local house = {}

-- Generate a single verse
function house.verse(n)
    local lines = {}
    lines[1] = "This is the " .. parts[n].subject
    for k = n, 2, -1 do
        local action = parts[k].action
        local subj = parts[k - 1].subject
        lines[#lines + 1] = "that " .. action .. " the " .. subj
    end
    return table.concat(lines, "\n")
end

-- Generate the full song
function house.recite()
    local result = {}
    for i = 1, #parts do
        result[#result + 1] = house.verse(i)
    end
    return table.concat(result, "\n")
end

return house
