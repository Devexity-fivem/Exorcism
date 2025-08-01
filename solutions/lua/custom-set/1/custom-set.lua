local function Set(...)
  local arg = {...}
  local my_set = {}
  local set_values = {}
  for i,v in pairs(arg) do
    set_values[v] = true
  end
  
  local mt = {values = set_values}
  mt.__index = mt
  
  mt.is_empty = function(self)
    return (self:get_length() == 0) 
  end
  
  mt.contains = function(self, item)
    return (self.values[item] ~= nil)
  end
  
  mt.is_subset = function(self, test_set)
    local subset = true
    
    for k, _ in pairs(self.values) do
      if not test_set:contains(k) then
        subset = false
        break
      end
    end
    return subset
  end
  
  mt.is_disjoint = function(self, test_set)
    local subset = true
    
    for k, _ in pairs(self.values) do
      if test_set:contains(k) then
        subset = false
        break
      end
    end
    return subset
  end
  mt.get_length = function(self)
    local count = 0
    for _,_ in pairs(self.values) do
      count = count + 1
    end
    return count
  end
  mt.equals = function(self, test_set)
    local subset = (self:get_length() == test_set:get_length())
    
    if subset then 
      for k, _ in pairs(self.values) do
        if not test_set:contains(k) then
          subset = false
          break
        end
      end
    end
    return subset
  end
  
  mt.add = function(self, item)
    self.values[item] = true
  end
  
  mt.intersection = function(self, test_set)
    local common_set = Set()
    for k, _ in pairs(self.values) do
      if test_set:contains(k) then
        common_set:add(k)
      end
    end
    return common_set
  end
  
  mt.difference = function(self, test_set)
    local difference_set = Set()
    
    for k, _ in pairs(self.values) do
      if not test_set:contains(k) then
        difference_set:add(k)
      end
    end
    return difference_set
  end
  
  mt.union = function(self, test_set)
    local union_set = Set()
    
    for k, _ in pairs(self.values) do
      union_set:add(k)
    end
    
    for k, _ in pairs(test_set.values) do
      union_set:add(k)
    end    
    return union_set
  end
  
  setmetatable(my_set, mt)
  return my_set
end
return Set