
local function InputCell(initialValue)
  local value = initialValue
  local dependents = {}

  return {
    get_value = function()
      return value
    end,

    set_value = function(newValue)
      value = newValue
      for _, child in ipairs(dependents) do
        child._recalculate()
      end
      for _, child in ipairs(dependents) do
        child._notify()
      end
    end,

    _add_dependent = function(dependent)
      table.insert(dependents, dependent)
    end
  }
end


local function ComputeCell(...)
  local watchers = {}
  local dependents = {}
  local inputs = { ... }
  local computeFn = table.remove(inputs) 
  local cell = {}
  local value
  local previousValue

  local function calculate()
    local args = {}
    for _, input in ipairs(inputs) do
      table.insert(args, input.get_value())
    end
    return computeFn(table.unpack(args))
  end

  function cell.get_value()
    return value
  end

  function cell.watch(callback)
    table.insert(watchers, callback)
  end

  function cell.unwatch(callback)
    for i, fn in ipairs(watchers) do
      if fn == callback then
        table.remove(watchers, i)
        break
      end
    end
  end

  function cell._recalculate()
    value = calculate()
    for _, dependent in ipairs(dependents) do
      dependent._recalculate()
    end
  end

  function cell._notify()
    if value ~= previousValue then
      previousValue = value
      for _, fn in ipairs(watchers) do
        fn(value)
      end
    end
    for _, dependent in ipairs(dependents) do
      dependent._notify()
    end
  end

  function cell._add_dependent(dep)
    table.insert(dependents, dep)
  end

  value = calculate()
  previousValue = value
  for _, input in ipairs(inputs) do
    input._add_dependent(cell)
  end

  return cell
end


local function Reactor()
  return {
    InputCell = InputCell,
    ComputeCell = ComputeCell
  }
end

return { Reactor = Reactor }
