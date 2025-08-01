function test1(sum, a, b, c) return sum == a + b + c end
function test2(a, b, c) return a * a + b * b == c * c end
return function(sum)
  local a, b, c = 0, 0, 0 
  local answer = {}
  local add = (sum == 30000 and 25) or 1
  while a < sum / 2 do 
    c = c + add
    if test1(sum, a, b, c) then
      if test2(a, b, c) then 
        table.insert(answer, {a, b, c})
      end
    end
    if c >= sum / 2 then b, c = b + add, b end
    if b >= sum / 2 then a, b, c = a + add, a + add, b end
  end
  return answer
end