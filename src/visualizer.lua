local fonts = require "asset_handlers.fonts.fonts"

local visualizer_class = {}

function visualizer_class.construct()
    local visualizer = {}

    function visualizer.__init__()
        visualizer.fonts = fonts.construct()
    end

    function visualizer.draw_multiple_rectangles(objects)
        for _, object in pairs(objects) do
            visualizer.draw_rectangle(object)
        end
    end

    function visualizer.draw_rectangle(object)
        love.graphics.setColor(
            object.color.red,
            object.color.green,
            object.color.blue,
            object.color.alpha
        )
        love.graphics.rectangle(
            object.mode,
            object.coordinates.x,
            object.coordinates.y,
            object.width,
            object.height
        )
    end

    function visualizer.draw_title(text)
        visualizer.fonts.set_title_font()
        visualizer.draw_text(text)
        visualizer.fonts.reset_font()
    end

    function visualizer.draw_header(text)
        visualizer.fonts.set_header_font()
        visualizer.draw_text(text)
        visualizer.fonts.reset_font()
    end

    function visualizer.draw_text(text)
        local font = love.graphics.getFont()
        local scaling_factor = 1
        local x_coord = love.graphics.getWidth() * 0.5 - font:getWidth(text)*scaling_factor / 2
        local y_coord = love.graphics.getHeight() * 0.2 - font:getHeight() / 2
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(text, x_coord, y_coord, 0, scaling_factor, scaling_factor)
    end

    function visualizer.draw_background(image)
        love.graphics.setColor(0.4, 0.4, 0.4, 1)
        love.graphics.draw(image, 0, 0, 0, ScreenWidhtScalingFactor, ScreenHeightScalingFactor)
    end

    function visualizer.draw_sprite(image, object)
        love.graphics.setColor(
            object.color.red,
            object.color.green,
            object.color.blue,
            object.color.alpha
        )
        love.graphics.draw(
            image,
            object.coordinates.x,
            object.coordinates.y,
            0,
            ScreenWidhtScalingFactor,
            ScreenHeightScalingFactor
        )
    end

    visualizer.__init__()
    return visualizer
end
return visualizer_class
