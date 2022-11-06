local base_bullet = require "config.bullets.base_bullet"

local base_player_bullet = {}
base_player_bullet.WIDTH = 10 * ScreenWidhtScalingFactor

function base_player_bullet.construct(owner, x_coord, y_coord)
    local bullet = base_bullet.construct(owner, x_coord, y_coord)

    bullet.color.blue = 1

    bullet.height = 10 * ScreenHeightScalingFactor
    bullet.width = 10 * ScreenWidhtScalingFactor
    bullet.speed = 100 * ScreenHeightScalingFactor

    function bullet.update(dt)
        bullet.move(dt, -1)
    end

    return bullet
end

return base_player_bullet
