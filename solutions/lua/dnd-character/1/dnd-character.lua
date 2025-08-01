local Character = {}


local function modifier(score)
    return math.floor((score - 10) / 2)
end


local function ability(scores)
    table.sort(scores)
    return scores[2] + scores[3] + scores[4]
end


local function roll_dice()
    local rolls = {}
    for i = 1, 4 do
        table.insert(rolls, math.random(1, 6))
    end
    return rolls
end


function Character:new(name)
    local obj = {
        name = name,
        strength = ability(roll_dice()),
        dexterity = ability(roll_dice()),
        constitution = ability(roll_dice()),
        intelligence = ability(roll_dice()),
        wisdom = ability(roll_dice()),
        charisma = ability(roll_dice())
    }
    obj.hitpoints = 10 + modifier(obj.constitution)
    setmetatable(obj, self)
    self.__index = self
    return obj
end

return {
    Character = Character,
    modifier = modifier,
    ability = ability,
    roll_dice = roll_dice
}
