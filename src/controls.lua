local controls = {}

local menu_controls = {}
menu_controls.move_up = {"up", "w"}
menu_controls.move_down = {"down", "s"}
menu_controls.select = {"return", "space"}
controls.selection_menu_controls = menu_controls

local game_panel_controls = {}
game_panel_controls.shoot = { "space" }
game_panel_controls.move_left = { "left", "a" }
game_panel_controls.move_right = { "right", "d" }
controls.game_panel_controls = game_panel_controls

function controls.get_selection_menu_controls()
    return controls.selection_menu_controls
end

function controls.get_game_panel_controls()
    return controls.game_panel_controls
end

return controls
