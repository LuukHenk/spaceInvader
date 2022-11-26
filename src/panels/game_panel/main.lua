local controls = require "controls"
local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"
local level_factory = require "level_manager.level_factory"
    
local draw = require "panels.game_panel.draw"
local updater = require "panels.game_panel.updater"
local object_handler = require "panels.game_panel.object_handler"

local game_panel = panel_factory.construct_panel(panel_ids.game_panel)

game_panel.controls = controls.get_game_panel_controls()

function game_panel.load()
    game_panel.object_handler = object_handler.construct(game_panel.controls)
    game_panel.level_factory = level_factory.construct()
    game_panel.current_level = nil
    game_panel.current_level_id = 0
end

function game_panel.update(dt)
    updater.update_game(dt, game_panel)
end

function game_panel.draw()
    draw.draw_game(game_panel)
end

return game_panel