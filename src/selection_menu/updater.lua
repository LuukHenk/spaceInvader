


local updater = {}

function updater.check_selected_item(selection_menu)
    if (
        selection_menu.item_count < 2
        or not selection_menu.selected_item
    ) then
        return
    end

    if not selection_menu.key_down then
        if love.keyboard.isDown(selection_menu.controls.select) then
            selection_menu.key_down = true
            updater.on_select(selection_menu)
        elseif love.keyboard.isDown(selection_menu.controls.move_down) then
            selection_menu.key_down = true
            updater.go_to_next_item(selection_menu)
        elseif love.keyboard.isDown(selection_menu.controls.move_up) then
            selection_menu.key_down = true
            updater.go_to_previous_item(selection_menu)
        end
    end
end

function updater.go_to_next_item(selection_menu)
    if selection_menu.selected_item == selection_menu.item_count then
        selection_menu.selected_item = 1
    else
        selection_menu.selected_item = selection_menu.selected_item + 1
    end
    updater.update_selected_item(selection_menu)
end

function updater.go_to_previous_item(selection_menu)
    if selection_menu.selected_item == 1 then 
        selection_menu.selected_item = selection_menu.item_count
    else
        selection_menu.selected_item = selection_menu.selected_item - 1
    end
    updater.update_selected_item(selection_menu)
end

function updater.on_select(selection_menu)
    for item_index, item in pairs(selection_menu.items) do
        if item_index == selection_menu.selected_item then
            selection_menu.on_select_function(item.tag)
        end
    end
end

function updater.update_selected_item(selection_menu)
    for item_index, item in pairs(selection_menu.items) do
        if item_index == selection_menu.selected_item then
            item.selected = true
        else
            item.selected = false
        end
    end
end

return updater