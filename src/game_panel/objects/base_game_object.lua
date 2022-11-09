local basic_object = require "basic_object"

local base_game_object = {}

function base_game_object.construct(tag, x_coord, y_coord)
    local object = basic_object.construct(tag, x_coord, y_coord)
    object.speed = 0
    return object
end

return base_game_object
