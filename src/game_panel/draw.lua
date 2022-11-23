local global_draw = require "draw"
local game_draw = {}

function game_draw.draw_game(game_panel)
    if not game_panel.current_level then
        return
    end
    game_draw.draw_background(game_panel.current_level.get_background())
    game_draw.draw_objects(game_panel.object_handler.get_all_objects())
end

function game_draw.draw_objects(game_objects)
    global_draw.draw_multiple_rectangles(game_objects)
end

function game_draw.draw_background(background)
    if background then
        global_draw.draw_background(background)
    end
end

return game_draw