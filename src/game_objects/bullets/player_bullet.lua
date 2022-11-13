local bullet_object = require "game_objects.bullet"
local player_bullet_class = {}

function player_bullet_class.construct(tag, x_coord, y_coord)
    local bullet = bullet_object.construct(tag, x_coord, y_coord)

    bullet.set_color(1, 0, 0, 1)
    bullet.resize(10, 10)
    bullet.speed = 100

    function bullet.update(dt)
        bullet.move_up(dt)
    end

    return bullet
end

return player_bullet_class