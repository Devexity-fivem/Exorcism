local SquareRoot = {}

function SquareRoot.square_root(radicand)
    local low, high = 1, radicand
    
    while low <= high do
        local mid = math.floor((low + high) / 2)
        local square = mid * mid

        if square == radicand then
            return mid
        elseif square < radicand then
            low = mid + 1
        else
            high = mid - 1
        end
    end
end

return SquareRoot
