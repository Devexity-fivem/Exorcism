return function(s)
  local reversed = {}
  for i = #s, 1, -1 do
    table.insert(reversed, s:sub(i, i))
  end
  return table.concat(reversed)
end
