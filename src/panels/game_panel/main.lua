local controls = require "controls"
local notifications = require "panel_manager.notifications"
local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local level_factory = require "level_manager.level_factory"
    
local draw = require "panels.game_panel.draw"
local updater = require "panels.game_panel.updater"
local object_handler = require "panels.game_panel.object_handler"

local game_panel_class = {}

function game_panel_class.construct(panel_id)
    local game_panel = panel.construct(panel_id)

    function game_panel.__init__()
        game_panel.controls = controls.get_game_panel_controls()
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

    function game_panel.on_activation(previous_panel_id, notification)
        if (
            previous_panel_id == panel_ids.pause_panel 
            and notification == notifications.RESUME 
            and game_panel.current_level 
        ) then 
            game_panel.current_level.continue()
            return
        end
        updater.reset_game(game_panel)
    end

    game_panel.__init__()
    return game_panel
end

return game_panel_class