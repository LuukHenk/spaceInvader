local game_object = require "game_objects.game_object"

local shooting_object_class = {}

-- Abstract class
function shooting_object_class.construct(object_name, object_type, x_coord, y_coord)
    local shooting_object = game_object.construct(object_name, object_type, x_coord, y_coord)

    shooting_object.bullet = game_object
    shooting_object.shooting_cooldown_time = 0
    shooting_object.shooting_cooldown = 0

    function  shooting_object.shoot(dt, gun_inactive)
        -- Should be called every update tick
        if shooting_object.shooting_cooldown > 0 then
            shooting_object.shooting_cooldown = shooting_object.shooting_cooldown - 1 * dt
            return
        end
        if gun_inactive then return end
        shooting_object.shooting_cooldown = shooting_object.shooting_cooldown_time
        shooting_object.spawn_bullet()
    end

    function shooting_object.spawn_bullet()
        local x_coordinate = shooting_object.coordinates.x + shooting_object.width / 2
        local bullet = shooting_object.bullet.construct(
            shooting_object.type, x_coordinate, shooting_object.coordinates.y
        )

        -- Can only finetune bullet coordinates after init
        x_coordinate = x_coordinate - bullet.width / 2
        bullet.set_coordinates(x_coordinate, bullet.coordinates.y)
        table.insert(shooting_object.constructed_game_objects, bullet)
    end

    return shooting_object
end

return shooting_object_class