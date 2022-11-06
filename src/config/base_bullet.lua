local base_object = require "config.base_object"

local base_bullet = {}
local BULLET_TAG = "bullet"


base_bullet.BASE_BULLET_WIDTH = 10 * ScreenWidhtScalingFactor
function base_bullet.construct(
    owner --[[str]] , x_coord --[[float]] , y_coord --[[float]] , friendly_fire --[[bool]]
)
    local bullet = base_object.construct(BULLET_TAG, x_coord, y_coord)
    bullet.owner = owner
    bullet.color.blue = 1
    bullet.width = base_bullet.BASE_BULLET_WIDTH
    bullet.height = 10 * ScreenHeightScalingFactor
    bullet.speed = 100 * ScreenHeightScalingFactor

    function bullet.update(dt)
        bullet.move(dt)
    end

    function bullet.move(dt)
        bullet.coordinates.y = bullet.coordinates.y + bullet.speed * dt
    end

    return bullet
end

return base_bullet
