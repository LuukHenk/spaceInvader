local drawer = {}


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

return drawer
