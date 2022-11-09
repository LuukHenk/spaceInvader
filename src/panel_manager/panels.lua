-- Holds all panels

local panel_ids = require "panel_manager.panel_ids"
local basic_panel = require "basic_panel.main"
local game_panel = require "game_panel.main"
local game_over_panel = require "game_over_panel.main"


local panels = {}

panels[panel_ids.basic_panel] = basic_panel
panels[panel_ids.game_panel] = game_panel
panels[panel_ids.game_over_panel] = game_over_panel

return panels