local object_types = require "game_objects.object_types"
local player = require "game_objects.player.player"
local object_handler = {}

object_handler.player = nil
object_handler.enemies = {}
object_handler.bullets = {}
object_handler.other_objects = {}

function object_handler.spawn_player(controls)
    object_handler.player = player.construct(controls)
end

function object_handler.add_objects(game_objects)
    for _, object in pairs(game_objects) do
        if object.type == object_types.enemy then
            table.insert(object_handler.enemies, object)
        elseif object.type == object_types.bullet then
            table.insert(object_handler.bullets, object)
        else
            table.insert(object_handler.other_objects, object)
        end
    end
end

function object_handler.enemies_alive()
    -- Check if there is any enemy in the game
    for _, _enemy in pairs(object_handler.enemies) do
        return true
    end
    return false
end

function object_handler.get_all_objects()
    local all_objects = {object_handler.player}

    for _, enemy in pairs(object_handler.enemies) do
        table.insert(all_objects, enemy)
    end

    for _, bullet in pairs(object_handler.bullets) do
        table.insert(all_objects, bullet)
    end

    for _, other in pairs(object_handler.other_objects) do
        table.insert(all_objects, other)
    end

    return all_objects
end


return object_handler
