return {
    value = function(colors)
        -- Define a table to map colors to their corresponding numeric values
        local color_codes = {
            black = 0,
            brown = 1,
            red = 2,
            orange = 3,
            yellow = 4,
            green = 5,
            blue = 6,
            violet = 7,
            grey = 8,
            white = 9
        }
        
        -- Get the first two colors and their numeric values
        local first_color = color_codes[colors[1]]
        local second_color = color_codes[colors[2]]
        
        -- Check if both colors are valid
        if first_color == nil or second_color == nil then
            return nil -- Return nil if invalid colors are provided
        end
        
        -- Combine the two values into a two-digit number
        return first_color * 10 + second_color
    end
}
