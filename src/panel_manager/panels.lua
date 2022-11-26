-- Holds all panels

local panel_ids = require "panel_manager.panel_ids"
local basic_panel = require "panels.basic_panel.main"
local game_panel = require "panels.game_panel.main"
local game_over_panel = require "panels.game_over_panel.main"
local main_menu_panel = require "panels.main_menu_panel.main"
local pause_panel = require "panels.pause_panel.main"

local panels = {}

panels[panel_ids.basic_panel] = basic_panel
panels[panel_ids.game_panel] = game_panel
panels[panel_ids.game_over_panel] = game_over_panel
panels[panel_ids.main_menu_panel] = main_menu_panel
panels[panel_ids.pause_panel] = pause_panel

return panels