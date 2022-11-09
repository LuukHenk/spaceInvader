--Holds the functionality for drawing the basic panel

local global_draw = require "draw"
local basic_draw = {}

function basic_draw.draw_game()
    global_draw.draw_centered_text("This is the game panel")
end

return basic_draw