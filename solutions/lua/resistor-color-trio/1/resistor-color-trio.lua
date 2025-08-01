return {
  decode = function(c1, c2, c3)
    local resistor_colors = {
      black = 0,
      brown = 1,
      red = 2,
      orange = 3,
      yellow = 4,
      green = 5,
      blue = 6,
      violet = 7,
      grey = 8,
      white = 9,
    }

    local prefixes = {
      [0] = " ohms",
      [1] = " ohms",
      [2] = " ohms",
      [3] = " kiloohms",
      [4] = " kiloohms",
      [5] = " megaohms",
      [6] = " megaohms",
      [7] = " gigaohms",
    }

    local first_digit = resistor_colors[c1]
    local second_digit = resistor_colors[c2]
    local zeros = resistor_colors[c3]

    -- Calculate the main value
    local main_value = first_digit * 10 + second_digit

    -- Calculate the total resistance value as a number
    local total_value = main_value * (10 ^ zeros)

    -- Determine the appropriate unit
    local unit
    if total_value >= 1e9 then
      total_value = total_value / 1e9
      unit = "gigaohms"
    elseif total_value >= 1e6 then
      total_value = total_value / 1e6
      unit = "megaohms"
    elseif total_value >= 1000 then
      total_value = total_value / 1000
      unit = "kiloohms"
    else
      unit = "ohms"
    end

    -- Return the final values
    return total_value, unit
  end
}
