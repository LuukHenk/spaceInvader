--Holds the functionality for drawing the basic panel

local global_draw = require "draw"
local game_draw = {}

function game_draw.draw_game_objects(objects)
    global_draw.draw_multiple_rectangles(objects.bullets)
    global_draw.draw_rectangle(objects.player)
    global_draw.draw_multiple_rectangles(objects.enemies)
end

return game_draw