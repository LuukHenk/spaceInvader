local base_object = require "game_panel.objects.base_object"
local base_bullet = require "game_panel.objects.bullets.base_bullet"

local base_shooting_object_class = {}


function base_shooting_object_class.construct(tag, x_coord, y_coord)
    local base_shooting_object = base_object.construct(tag, x_coord, y_coord)

    base_shooting_object.bullet = base_bullet
    base_shooting_object.bullet_timeout = 0
    base_shooting_object.bullet_cooldown = 0
    base_shooting_object.parent_functions = {}

    function base_shooting_object.parent_functions.shoot()
        -- Let the base object shoot
        if base_shooting_object.bullet_cooldown > 0 then
            return nil
        end

        base_shooting_object.bullet_cooldown = base_shooting_object.bullet_timeout
        x_coord = base_shooting_object.coordinates.x + base_shooting_object.width / 2 -
            base_shooting_object.bullet.WIDTH / 2
        return base_shooting_object.bullet.construct(base_shooting_object.tag, x_coord,
            base_shooting_object.coordinates.y)
    end

    return base_shooting_object
end

return base_shooting_object_class
