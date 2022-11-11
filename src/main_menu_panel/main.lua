local selection_menu = require "selection_menu.main"
local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"
local draw = require "draw"

local main_menu_panel = panel_factory.construct_panel(panel_ids.main_menu_panel)

local START_GAME_TEXT = "Play"
local SETTINGS_TEXT = "Settings"
local QUIT_TEXT = "Quit game"
local SELECTION_MENU_ITEMS = {START_GAME_TEXT, SETTINGS_TEXT, QUIT_TEXT}
local TITLE_TEXT = "Space invaders"

function main_menu_panel.load()
    selection_menu.load(SELECTION_MENU_ITEMS, main_menu_panel.on_selection)
end

function main_menu_panel.update(dt)
    selection_menu.update(dt)
end

function main_menu_panel.draw()
    draw.draw_panel_title(TITLE_TEXT)
    selection_menu.draw()
end

function main_menu_panel.on_selection(selection)
    if selection == START_GAME_TEXT then
        main_menu_panel.next_active_panel = panel_ids.game_panel
    elseif selection == QUIT_TEXT then
        love.event.quit()
    else
        main_menu_panel.next_active_panel = panel_ids.basic_panel
    end
end

return main_menu_panel