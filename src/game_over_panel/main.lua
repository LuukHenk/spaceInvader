-- Holds the game over panel

local selection_menu = require "selection_menu.main"
local panel_ids = require "panel_manager.panel_ids"
local draw = require "draw"

local game_over_panel = {}
game_over_panel.next_active_panel =  panel_ids.game_over_panel
game_over_panel.panel_id = panel_ids.game_over_panel

local RETURN_TO_MAIN_MENU_TEXT = "Return to main menu"
local START_OVER_TEXT = "Start over"
local SELECTION_MENU_ITEMS = {RETURN_TO_MAIN_MENU_TEXT, START_OVER_TEXT}
local GAME_OVER_TEXT = "Game over"

function game_over_panel.load()
    selection_menu.load(SELECTION_MENU_ITEMS)
end

function game_over_panel.update(dt)
    selection_menu.update(dt)
end

function game_over_panel.draw()
    draw.draw_panel_title(GAME_OVER_TEXT)
    selection_menu.draw()
end

return game_over_panel