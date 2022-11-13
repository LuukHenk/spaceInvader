local controls = require "controls"
local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"

local updater = require "game_panel.updater"
local draw = require "draw" 
local object_handler = require "game_panel.object_handler"

local game_panel = panel_factory.construct_panel(panel_ids.game_panel)

game_panel.controls = controls[game_panel.panel_id]

function game_panel.load()
    game_panel.object_handler = object_handler.construct(game_panel.controls)
    game_panel.current_level = 0
end

function game_panel.update(dt)
    updater.update_game(dt, game_panel)
end

function game_panel.draw()
    draw.draw_multiple_rectangles(game_panel.object_handler.get_all_objects())
end

return game_panel