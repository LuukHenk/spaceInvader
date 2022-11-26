local global_draw = require "draw"
local game_draw = {}

function game_draw.draw_game(game_panel)
    if not game_panel.current_level then
        return
    end
    game_panel.current_level.draw_background()
    game_draw.draw_objects(game_panel.object_handler.get_all_objects())
end

function game_draw.draw_objects(game_objects)
    for _, object in pairs(game_objects) do
        if DEBUG then
            global_draw.draw_rectangle(object)
        end
        if object.assets and object.assets.get_sprite() then
            global_draw.draw_sprite(object.assets.get_sprite(), object)           
        else
            global_draw.draw_rectangle(object)
        end
    end
end

return game_draw