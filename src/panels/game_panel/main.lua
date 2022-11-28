local controls = require "controls"
local notifications = require "panel_manager.notifications"
local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local visualizer = require "visualizer"
local level_handler = require "panels.game_panel.level_handler"

local draw = require "panels.game_panel.draw"
local updater = require "panels.game_panel.updater"
local object_handler = require "panels.game_panel.object_handler"

local game_panel_class = {}

function game_panel_class.construct(panel_id)
    local game_panel = panel.construct(panel_id)

    function game_panel.__init__()
        game_panel.visualizer = visualizer.construct()
        game_panel.controls = controls.get_game_panel_controls()
        game_panel.object_handler = object_handler.construct(game_panel.controls)
        game_panel.level_handler = level_handler.construct()
    end
    function game_panel.update(dt)
        game_panel.__check_for_pause()
        if not game_panel.level_handler.select_active_level(game_panel.object_handler.enemies_alive()) then
            game_panel.notification = notifications.GAME_WON
            updater.handle_game_over(game_panel)
            return
        end
        game_panel.level_handler.update_current_level(dt)
        game_panel.object_handler.add_objects(
            game_panel.level_handler.collect_constructed_enemies()
        )
        updater.update_game(dt, game_panel)
    end

    function game_panel.draw()
        game_panel.level_handler.draw_background()

        draw.draw_game(game_panel)
    end

    function game_panel.on_activation(previous_panel_id, notification)
        if (
            previous_panel_id == panel_ids.pause_panel
            and notification == notifications.RESUME
            and game_panel.current_level
        ) then 
            game_panel.level_handler.continue_current_level()
            return
        end
        game_panel.__reset_game()
    end

    function game_panel.__check_for_pause()
        if love.keyboard.isDown(unpack(game_panel.controls.pause)) then
            game_panel.next_active_panel = panel_ids.pause_panel
            game_panel.level_handler.pause_level()
        end
    end

    function game_panel.__reset_game()
        game_panel.level_handler.reset()
        updater.reset_game(game_panel)
    end

    game_panel.__init__()
    return game_panel
end

return game_panel_class