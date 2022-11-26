local controls = {}

function controls.__init__()
    controls.selection_menu_controls = controls.__construct_menu_controls()
    controls.game_panel_controls = controls.__construct_game_panel_controls()
end

function controls.get_selection_menu_controls()
    return controls.selection_menu_controls
end

function controls.get_game_panel_controls()
    return controls.game_panel_controls
end


function controls.__construct_menu_controls()
    local menu_controls = {}
    menu_controls.move_up = {"up", "w"}
    menu_controls.move_down = {"down", "s"}
    menu_controls.select = {"return", "space"}

    menu_controls.all = controls.__get_all_control_keys_of_object(menu_controls)
    return menu_controls
end

function controls.__construct_game_panel_controls()
    local game_panel_controls = {}
    game_panel_controls.shoot = { "space" }
    game_panel_controls.move_left = { "left", "a" }
    game_panel_controls.move_right = { "right", "d" }

    game_panel_controls.all = controls.__get_all_control_keys_of_object(game_panel_controls)
    return game_panel_controls
end

function controls.__get_all_control_keys_of_object(controlable_object)
    local object_keys = {}
    for _, key_set in pairs(controlable_object) do
        for _, key in pairs(key_set) do
            table.insert(object_keys, key)
        end
    end
    return object_keys
end

controls.__init__()
return controls
