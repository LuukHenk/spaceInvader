local base_bullet = require "config.bullets.base_bullet"

local base_enemy_bullet = {}
base_enemy_bullet.WIDTH = 10 * ScreenWidhtScalingFactor

function base_enemy_bullet.construct(owner, x_coord, y_coord)
    local bullet = base_bullet.construct(owner, x_coord, y_coord)
    bullet.color.blue = 1
    bullet.color.green = 0.92

    bullet.height = 10 * ScreenHeightScalingFactor
    bullet.width = 10 * ScreenWidhtScalingFactor
    bullet.speed = 100 * ScreenHeightScalingFactor

    function bullet.update(dt)
        bullet.move(dt, 1)
    end

    return bullet
end

return base_enemy_bullet
