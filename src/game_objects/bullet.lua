local game_object = require "game_objects.game_object"
local object_types = require "game_objects.object_types"
local bullet_class = {}

-- Abstract class
function bullet_class.construct(owner, x_coord, y_coord)
    local bullet = game_object.construct(object_types.bullet, x_coord, y_coord)
    bullet.division = owner

    return bullet
end

return bullet_class