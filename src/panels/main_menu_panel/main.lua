local selection_menu = require "selection_menu.selection_menu"
local assets_handler = require "asset_handlers.panel_assets_handler"
local panel_ids = require "panel_manager.panel_ids"
local panel = require "panel_manager.panel"
local visualizer = require "visualizer"

local main_menu_panel_class = {}

local START_GAME_TEXT = "Play"
local QUIT_TEXT = "Quit game"
local SELECTION_MENU_ITEMS = {START_GAME_TEXT, QUIT_TEXT}
local TITLE_TEXT = "Space Invaders"

function main_menu_panel_class.construct(panel_id)
    local main_menu_panel = panel.construct(panel_id)

    function main_menu_panel.__init__()
        main_menu_panel.assets_handler = assets_handler.construct(panel_ids.main_menu_panel)
        main_menu_panel.selection_menu = selection_menu.construct(
            SELECTION_MENU_ITEMS, main_menu_panel.on_selection
        )
        main_menu_panel.visualizer = visualizer.construct()
    end

    function main_menu_panel.update(_dt)
        main_menu_panel.selection_menu.update()
    end

    function main_menu_panel.draw()
        main_menu_panel.visualizer.draw_title(TITLE_TEXT)
        main_menu_panel.selection_menu.draw()
    end

    function main_menu_panel.on_selection(selection)
        main_menu_panel.assets_handler.stop_music()
        if selection == START_GAME_TEXT then
            main_menu_panel.next_active_panel = panel_ids.game_panel
        elseif selection == QUIT_TEXT then
            love.event.quit()
        else
            main_menu_panel.next_active_panel = panel_ids.basic_panel
        end
    end

    function main_menu_panel.on_activation(previous_panel_id, notification)
        main_menu_panel.assets_handler.play_music()
    end
    main_menu_panel.__init__()
    return main_menu_panel
end




return main_menu_panel_class