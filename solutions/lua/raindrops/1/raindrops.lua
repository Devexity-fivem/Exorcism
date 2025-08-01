return function(n)
  local result = ""

  if n % 3 == 0 then
    result = result .. "Pling"
  end
  if n % 5 == 0 then
    result = result .. "Plang"
  end
  if n% 7 == 0 then
    result = result .. "Plong"
  end
  
  if result == "" then
    return tostring(n) -- returns the number as a string if no sounds added
  else
    return result
  end
end
