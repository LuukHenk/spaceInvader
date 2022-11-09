
local selection_menu_item = require "selection_menu.selection_menu_item"
local loader = {}
local font = love.graphics.getFont()
local text_heigt = font:getHeight()

function loader.add_items(selection_menu, items)
    local y_coord = selection_menu.y_coordinates
    for item_index, item in pairs(items) do
        local text_width = font:getWidth(item)
        local x_coord = love.graphics.getWidth() / 2 - text_width / 2 - selection_menu.border_size
        local selection_item = selection_menu_item.construct(item, x_coord, y_coord)

        selection_item.set_border(selection_menu.border_size)
        selection_item.width = text_width + selection_menu.border_size * 2
        selection_item.height = text_heigt + selection_menu.border_size * 2

        y_coord = y_coord + text_heigt + selection_menu.border_size * 2

        if item_index == 1 then
            selection_menu.selected_item = 1
            selection_item.selected = true
        end

        table.insert(selection_menu.items, selection_item)
    end
end

return loader