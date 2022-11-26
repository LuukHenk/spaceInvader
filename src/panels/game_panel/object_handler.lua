local assets_factory = require "assets.game_object_assets_handler.game_object_assets_factory"
local object_names = require "game_objects.game_object_names"
local object_types = require "game_objects.object_types"
local player = require "game_objects.player.player"
local object_handler_class = {}

function object_handler_class.construct(player_controls)
    local object_handler = {}

    function object_handler.__init__()
        object_handler.assets = assets_factory.get_all_game_object_assets()
        object_handler.player_controls = player_controls
        object_handler.player = object_handler.__construct_player()
        object_handler.enemies = {}
        object_handler.bullets = {}
        object_handler.other_objects = {}
    end

    function object_handler.__construct_player()
        local player_ = player.construct(object_handler.player_controls)
        player_.assets = object_handler.assets.get_game_object_assets(object_names.player)
        return player_
    end


    function object_handler.reset()
        object_handler.player = object_handler.__construct_player()
        object_handler.enemies = {}
        object_handler.bullets = {}
        object_handler.other_objects = {}
    end

    function object_handler.add_objects(game_objects)
        for _, object in pairs(game_objects) do
            object.assets = object_handler.assets.get_game_object_assets(object.name)
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

        for _, bullet in pairs(object_handler.bullets) do
            table.insert(all_objects, bullet)
        end
        
        for _, enemy in pairs(object_handler.enemies) do
            table.insert(all_objects, enemy)
        end

        for _, other in pairs(object_handler.other_objects) do
            table.insert(all_objects, other)
        end

        return all_objects
    end

    function object_handler.remove_player()
        object_handler.player = nil
    end

    function object_handler.remove_object_by_id(object_id)
        if object_handler.player.id == object_id then
            object_handler.remove_player()
            return
        end

        for i, enemy in ipairs(object_handler.enemies) do
            if enemy.id == object_id then
                table.remove(object_handler.enemies, i)
                return
            end
        end
        for i, bullet in ipairs(object_handler.bullets) do
            if bullet.id == object_id then
                table.remove(object_handler.bullets, i)
                return
            end
        end
        for i, other in ipairs(object_handler.other_objects) do
            if other.id == object_id then
                table.remove(object_handler.other_objects, i)
                return
            end
        end

        local error_message = "Invalid id: " .. object_id
        error(error_message)
    end

    object_handler.__init__()

    return object_handler
end

return object_handler_class
