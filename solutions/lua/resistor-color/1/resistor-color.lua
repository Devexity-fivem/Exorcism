return {
    color_code = function(color)
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
        
        -- Return the numeric value for the provided color, or nil if the color is not found
        return color_codes[color]
    end
}
