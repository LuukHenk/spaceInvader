local basic_object = require "basic_object"

local game_object_class = {}

-- Abstract class
function game_object_class.construct(tag, x_coord, y_coord)
    local game_object = basic_object.construct(tag, x_coord, y_coord)

    game_object.speed = 0
    game_object.lives = 1
    game_object.constructed_game_objects = {}

    --abstract
    function game_object.update(dt)
    end

    function game_object.collect_constructed_game_objects()
        local constructed_objects = game_object.constructed_game_objects
        game_object.constructed_game_objects = {}

        return constructed_objects
    end

    function game_object.move_down(dt)
        game_object.coordinates.y = game_object.coordinates.y + game_object.speed * dt
    end

    return game_object
end

return game_object_class