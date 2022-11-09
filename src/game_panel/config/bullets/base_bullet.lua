local base_object = require "game_panel.config.base_object"

local base_bullet = {}
local BULLET_TAG = "bullet"


function base_bullet.construct(
    owner --[[str]] , x_coord --[[float]] , y_coord --[[float]]
)
    local bullet = base_object.construct(BULLET_TAG, x_coord, y_coord)
    bullet.owner = owner

    function bullet.move(dt, direction --[[1 is down, -1 is up]])
        bullet.coordinates.y = bullet.coordinates.y + bullet.speed * dt * direction
    end

    return bullet
end

return base_bullet
