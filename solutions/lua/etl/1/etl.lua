return {
  transform = function(dataset)
    local transformed = {}

    for points, letters in pairs(dataset) do
      for _, letter in ipairs(letters) do
        transformed[letter:lower()] = tonumber(points)
      end
    end

    return transformed
  end
}
