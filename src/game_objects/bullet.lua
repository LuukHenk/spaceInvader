local game_object = require "game_objects.game_object"
local object_tags = require "game_objects.object_tags"
local bullet_class = {}

-- Abstract class
function bullet_class.construct(owner, x_coord, y_coord)
    local bullet = game_object.construct(object_tags.bullet, x_coord, y_coord)
    bullet.owner = owner

    return bullet
end

return bullet_class