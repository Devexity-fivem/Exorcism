local SpaceAge = {}

local orbital_periods = {
  mercury = 0.2408467,
  venus = 0.61519726,
  earth = 1.0,
  mars = 1.8808158,
  jupiter = 11.862615,
  saturn = 29.447498,
  uranus = 84.016846,
  neptune = 164.79132
}

local earth_year_seconds = 31557600

local function round(num)
  return math.floor(num * 100 + 0.5) / 100
end

-- Handle colon call (SpaceAge:new(...)) by ignoring the implicit "self" parameter
function SpaceAge.new(_, seconds)
  local instance = {
    seconds = seconds,
    earth_years = seconds / earth_year_seconds
  }

  -- Attach methods directly to the instance
  for planet, period in pairs(orbital_periods) do
    instance["on_" .. planet] = function()
      return round(instance.earth_years / period)
    end
  end

  return instance
end

return SpaceAge