local basic_object = require "basic_object"

local selection_menu_item = {}

function selection_menu_item.construct(text, x_coord, y_coord)
    local item = basic_object.construct(text, x_coord, y_coord)

    item.selected = false
    item.border = {}
    item.border.left = 0
    item.border.top = 0
    item.border.right = 0
    item.border.bottom = 0

    item.color.red = 1
    item.color.green = 1
    item.color.blue = 1

    item.selected_color = {}
    item.selected_color.red = 1
    item.selected_color.green = 0
    item.selected_color.blue = 0
    item.selected_color.alpha = 1

    function item.set_border(border_size)
        item.border.left = border_size
        item.border.top = border_size
        item.border.right = border_size
        item.border.bottom = border_size
    end

    return item
end

return selection_menu_item