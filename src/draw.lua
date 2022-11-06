local drawer = {}

local font = love.graphics.getFont()

function drawer.draw_rectangle(object)
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

function drawer.draw_centered_text(text)
    love.graphics.setColor(1, 1, 1)
    local x_coord = love.graphics.getWidth() / 2 - font:getWidth(text) / 2
    local y_coord = love.graphics.getHeight() / 2 - font:getHeight() / 2
    love.graphics.print(text, x_coord, y_coord)
end

return drawer
