local object_tags = require "game_objects.object_tags"

local object_handler = {}

-- object_handler.player = 
object_handler.enemies = {}
object_handler.bullets = {}
object_handler.other_objects = {}

function object_handler.add_objects(game_objects)
    for _, object in pairs(game_objects) do
        if object.tag == object_tags.enemy then
            table.insert(object_handler.enemies, object)
        elseif object.tag == object_tags.bullet then 
            table.insert(object_handler.bullets, object)
        else
            table.insert(object_handler.other_objects, object)
        end
    end
end

function object_handler.get_enemies()
    return object_handler.enemies
end

function object_handler.get_bullets()
    return object_handler.bullets
end

return object_handler
