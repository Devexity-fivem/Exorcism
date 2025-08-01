local Darts = {}

function Darts.score(x, y)
    -- Calculate the distance from the center (0, 0)
    local distance = math.sqrt(x^2 + y^2)

    -- Determine score based on the distance
    if distance > 10 then
        return 0  -- Outside the target
    elseif distance > 5 then
        return 1  -- Outer circle
    elseif distance > 1 then
        return 5  -- Middle circle
    else
        return 10  -- Inner circle
    end
end

return Darts
