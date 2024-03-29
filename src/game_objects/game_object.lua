local basic_object = require "basic_object"

local game_object_class = {}

-- Abstract class
function game_object_class.construct(object_name, object_type, x_coord, y_coord)
    local game_object = basic_object.construct(object_name, object_type, x_coord, y_coord)

    game_object.speed = 0
    game_object.lives = 1
    game_object.strength = 1
    game_object.division = object_type
    game_object.assets = nil
    game_object.constructed_game_objects = {}

    --abstract
    function game_object.update(dt)
    end

    function game_object.play_die_sound()
        if game_object.assets then
            game_object.assets.play_die_sound()
        end
    end

    function game_object.play_shoot_sound()
        if game_object.assets then
            game_object.assets.play_shoot_sound()
        end
    end

    function game_object.collect_constructed_game_objects()
        local constructed_objects = game_object.constructed_game_objects
        game_object.constructed_game_objects = {}

        return constructed_objects
    end

    function game_object.move_down(dt)
        game_object.coordinates.y = (
            game_object.coordinates.y + game_object.speed * dt *ScreenHeightScalingFactor
        )
    end

    function game_object.move_up(dt)
        game_object.coordinates.y = (
            game_object.coordinates.y - game_object.speed * dt *ScreenHeightScalingFactor
        )
    end
    
    function game_object.move_right(dt)
        if game_object.width + game_object.coordinates.x >= love.graphics.getWidth() then
            return
         end
        game_object.coordinates.x = (
            game_object.coordinates.x + game_object.speed * dt *ScreenHeightScalingFactor
        )
    end

    function game_object.move_left(dt)
        if game_object.coordinates.x <= 0 then return end
        game_object.coordinates.x = (
            game_object.coordinates.x - game_object.speed * dt *ScreenHeightScalingFactor
        )
    end

    return game_object
end

return game_object_class