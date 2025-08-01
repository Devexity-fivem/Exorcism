local function find_combinations(target, length, start, current, results)
    if #current == length then
        if target == 0 then
            table.insert(results, { table.unpack(current) })
        end
        return
    end

    for i = start, target do
        table.insert(current, i)
        find_combinations(target - i, length, i + 1, current, results)
        table.remove(current)
    end
end

local function combinations(sum, size, exclude)
    local results = {}
    find_combinations(sum, size, 1, {}, results)

    if not exclude then return results end

    local exclude_set = {}
    for _, num in ipairs(exclude) do
        exclude_set[num] = true
    end

    local filtered = {}
    for _, sublist in ipairs(results) do
        local should_exclude = false
        for _, num in ipairs(sublist) do
            if exclude_set[num] then
                should_exclude = true
            end
        end

        if not should_exclude then
            table.insert(filtered, sublist)
        end
    end

    return filtered

end

return { combinations = combinations }