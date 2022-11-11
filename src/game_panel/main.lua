local controls = require "controls"
local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"

local updater = require "game_panel.updater"
local draw = require "game_panel.draw" 
local objects = require "game_panel.objects"

local game_panel = panel_factory.construct_panel(panel_ids.game_panel)

game_panel.next_active_panel =  panel_ids.game_panel
game_panel.panel_id = panel_ids.game_panel
game_panel.controls = controls[game_panel.panel_id]

function game_panel.load()
    game_panel.objects = objects
    game_panel.current_level = 0
end

function game_panel.update(dt)
    updater.update_game(dt, game_panel)
end

function game_panel.draw()
    draw.draw_game_objects(game_panel.objects)
end

return game_panel