--Holds the functionality for the current panel

local global_draw = require "draw"
local basic_draw = {}

function basic_draw.draw_basic()
    global_draw.draw_panel_title("This is a basic page")

    global_draw.draw_selection_menu({"first", "second", "third"}, 1)
end

return basic_draw