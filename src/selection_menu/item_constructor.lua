local selection_menu_item = require "selection_menu.selection_menu_item"
local fonts = require "asset_handlers.fonts.fonts"
local item_constructor_class = {}

function item_constructor_class.construct()
    local item_constructor = {}
    function item_constructor.__init__()
        item_constructor.font = item_constructor.__load_selection_menu_font()
        item_constructor.item_border_size = 10
        item_constructor.default_selection = 1
    end

    function item_constructor.get_default_selection()
        return item_constructor.default_selection
    end
    function item_constructor.create_centered_selection_menu_items(texts, menu_x_coordinate_center, menu_y_coordinate)
        local selection_menu_items = {}
        local y_coordinates_start = menu_y_coordinate
        for item_index, text in pairs(texts) do
            local text_width = item_constructor.font:getWidth(text)
            local x_coordinates_start = (
                menu_x_coordinate_center -
                text_width / 2 -
                item_constructor.item_border_size
            )
            local selection_item = selection_menu_item.construct(
                text, x_coordinates_start, y_coordinates_start
            )
            selection_item.set_border(item_constructor.item_border_size)
            selection_item.width = text_width + item_constructor.item_border_size * 2
            selection_item.height = item_constructor.font:getHeight() + item_constructor.item_border_size * 2

            y_coordinates_start = (
                y_coordinates_start +
                item_constructor.font:getHeight() +
                item_constructor.item_border_size * 2
            )

            if item_index == item_constructor.default_selection then
                selection_item.selected = true
            end

            table.insert(selection_menu_items, selection_item)
        end

        return selection_menu_items
    end

    function item_constructor.__load_selection_menu_font()
        local fonts_handler = fonts.construct()
        fonts_handler.set_selection_menu_font()
        local font = love.graphics.getFont()
        fonts_handler.reset_font()
        return font
    end

    item_constructor.__init__()
    return item_constructor
end

return item_constructor_class