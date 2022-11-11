local selection_menu = require "selection_menu.main"
local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"
local draw = require "draw"

local game_over_panel = panel_factory.construct_panel(panel_ids.game_over_panel)

local GAME_OVER_TEXT = "Game over"
local RETURN_TO_MAIN_MENU_TEXT = "Return to main menu"
local START_OVER_TEXT = "Start over"
local SELECTION_MENU_ITEMS = {RETURN_TO_MAIN_MENU_TEXT, START_OVER_TEXT}

function game_over_panel.load()
    selection_menu.load(SELECTION_MENU_ITEMS, game_over_panel.on_selection)
end

function game_over_panel.update(dt)
    selection_menu.update(dt)
end

function game_over_panel.draw()
    draw.draw_panel_title(GAME_OVER_TEXT)
    selection_menu.draw()
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

return game_over_panel