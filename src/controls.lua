local panel_ids = require "panel_manager.panel_ids"

local controls = {}

local menu_controls = {}
menu_controls.move_up = {"up", "w"}
menu_controls.move_down = {"down", "s"}
menu_controls.select = {"return", "space"}

controls[panel_ids.selection_menu] = menu_controls

local game_panel_controls = {}
game_panel_controls.shoot = { "space" }
game_panel_controls.move_left = { "left", "a" }
game_panel_controls.move_right = { "right", "d" }

controls[panel_ids.game_panel] = game_panel_controls

return controls
