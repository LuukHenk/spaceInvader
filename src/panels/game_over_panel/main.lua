local selection_menu = require "selection_menu.main"
local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local visualizer = require "visualizer"
local notifications = require "panel_manager.notifications"

local GAME_OVER_TEXT = "Earth has been captured by aliens."
local GAME_WON_TEXT = "You have saved earth!"
local RETURN_TO_MAIN_MENU_TEXT = "Return to main menu"
local START_OVER_TEXT = "Start over"
local SELECTION_MENU_ITEMS = {RETURN_TO_MAIN_MENU_TEXT, START_OVER_TEXT}

local game_over_panel_class = {}

function game_over_panel_class.construct(panel_id)
    local game_over_panel = panel.construct(panel_id)

    function game_over_panel.__init__()
        game_over_panel.selection_menu = selection_menu.construct(
            SELECTION_MENU_ITEMS, game_over_panel.on_selection
        )
        game_over_panel.title = GAME_OVER_TEXT
        game_over_panel.visualizer = visualizer.construct()
    end
    function game_over_panel.update(dt)
        game_over_panel.selection_menu.update()
    end
    
    function game_over_panel.draw()
        game_over_panel.visualizer.draw_header(game_over_panel.title)
        game_over_panel.selection_menu.draw()
    end
    
    function game_over_panel.on_selection(selection)
        if selection == START_OVER_TEXT then
            game_over_panel.next_active_panel = panel_ids.game_panel
        elseif selection ==RETURN_TO_MAIN_MENU_TEXT then
            game_over_panel.next_active_panel = panel_ids.main_menu_panel
        else
            game_over_panel.next_active_panel = panel_ids.basic_panel
        end
    end
    
    function game_over_panel.on_activation(previous_panel_id, notification)
        if notification == notifications.GAME_WON then
            game_over_panel.title = GAME_WON_TEXT
        elseif notification == notifications.GAME_LOST then
            game_over_panel.title = GAME_OVER_TEXT
        else
            game_over_panel.title = "Ummm did you win? I don't know"
        end
    end
    game_over_panel.__init__()
    return game_over_panel
end

return game_over_panel_class