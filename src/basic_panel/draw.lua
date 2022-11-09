--Holds the functionality for drawing the basic panel

local global_draw = require "draw"
local basic_draw = {}

function basic_draw.draw_basic()
    global_draw.draw_centered_text("This is a basic page")
end

return basic_draw