local selection_menu = require "selection_menu.main"
local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local notifications = require "panel_manager.notifications"
local draw = require "draw"

local PAUSE_TEXT = "Game paused"
local CONTINUE_TEXT = "Continue"
local RESTART_TEXT = "Restart"
local RETURN_TO_MAIN_MENU_TEXT = "Return to main menu"
local SELECTION_MENU_ITEMS = {CONTINUE_TEXT, RESTART_TEXT, RETURN_TO_MAIN_MENU_TEXT}

local pause_panel_class = {}

function pause_panel_class.construct(panel_id)
    local pause_panel = panel.construct(panel_id)
    function pause_panel.__init__()
        pause_panel.selection_menu = selection_menu.construct(
            SELECTION_MENU_ITEMS, pause_panel.on_selection
        )
    end

    function pause_panel.update(dt)
        pause_panel.selection_menu.update()
    end

    function pause_panel.draw()
        draw.draw_panel_title(PAUSE_TEXT)
        pause_panel.selection_menu.draw()
    end

    function pause_panel.on_selection(selection)
        if selection == CONTINUE_TEXT then
            pause_panel.notification = notifications.RESUME
            pause_panel.next_active_panel = panel_ids.game_panel
        elseif selection == RESTART_TEXT then
            pause_panel.notification = notifications.RESET
            pause_panel.next_active_panel = panel_ids.game_panel
        elseif selection == RETURN_TO_MAIN_MENU_TEXT then
            pause_panel.next_active_panel = panel_ids.main_menu_panel
        else
            pause_panel.next_active_panel = panel_ids.basic_panel
        end
    end

    pause_panel.__init__()
    return pause_panel
end



return pause_panel_class