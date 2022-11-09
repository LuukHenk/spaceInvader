local base_game_object = require "game_panel.objects.base_game_object"
local object_tags = require "game_panel.objects.object_tags"

local base_bullet = {}


function base_bullet.construct(
    owner --[[str]] , x_coord --[[float]] , y_coord --[[float]]
)
    local bullet = base_game_object.construct(owner, x_coord, y_coord)

    function bullet.move(dt, direction --[[1 is down, -1 is up]])
        bullet.coordinates.y = bullet.coordinates.y + bullet.speed * dt * direction
    end

    return bullet
end

return base_bullet
