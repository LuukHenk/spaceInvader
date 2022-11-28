local player = require "game_objects.player.player"
local assets_factory = require "asset_handlers.game_objects.factory"
local object_types = require "game_objects.object_types"
local visualizer = require "visualizer"
local utils = require "utils"
local game_object_names = require "game_objects.game_object_names"

local game_object_handler_class = {}

function game_object_handler_class.construct(player_controls)
    local game_object_handler = {}
    function game_object_handler.__init__()
        game_object_handler.assets_factory = assets_factory.construct()
        game_object_handler.objects = game_object_handler.__construct_game_objects()
        game_object_handler.visualizer = visualizer.construct()
    end

    function game_object_handler.update_all_objects(dt)
        for object_type_id, object_type in pairs(game_object_handler.objects) do
            for object_id, object in pairs(object_type) do
                game_object_handler.__update_object(dt, object)
                game_object_handler.__remove_object_if_dead(object_type_id, object_id)
                if not game_object_handler.__check_if_player_is_alive() then return end
            end
        end 
    end

    function game_object_handler.check_if_game_over()
        if (
            not game_object_handler.__check_if_player_is_alive()
            or game_object_handler.__check_if_enemies_reached_earth()
        ) then
            game_object_handler.__play_player_die_sound()
            return true
        end
        return false
    end

    function game_object_handler.reset()
        game_object_handler.objects = game_object_handler.__construct_game_objects()
    end

    function game_object_handler.add_objects(objects)
        for _, object in pairs(objects) do
            object.assets = game_object_handler.assets_factory.get_assets(object.name)
            if object.type == object_types.enemy then
                table.insert(game_object_handler.objects.enemies, object)
            elseif object.type == object_types.bullet then
                table.insert(game_object_handler.objects.bullets, object)
            else
                table.insert(game_object_handler.objects.other_objects, object)
            end
        end
    end

    function game_object_handler.check_if_enemies_alive()
        return utils.table_size(game_object_handler.objects.enemies) > 0
    end

    function game_object_handler.draw_objects()
        for _, object_type in pairs(game_object_handler.objects) do
            for _, object in pairs(object_type) do
                if DEBUG then
                    game_object_handler.visualizer.draw_rectangle(object)
                end
                if object.assets and object.assets.get_sprite() then
                    game_object_handler.visualizer.draw_sprite(object.assets.get_sprite(), object)
                else
                    game_object_handler.visualizer.draw_rectangle(object)
                end
            end
        end
    end

    function game_object_handler.__construct_game_objects()
        local objects = {}
        objects.players = {game_object_handler.__construct_player()}
        objects.enemies = {}
        objects.bullets = {}
        objects.other_objects = {}
        return objects
    end

    function game_object_handler.__check_if_player_is_alive()
        return utils.table_size(game_object_handler.objects.players) > 0
    end

    function game_object_handler.__play_player_die_sound()
        for _, player_ in pairs(game_object_handler.objects.players) do
            player_.play_die_sound()
            return
        end
    end

    function game_object_handler.__check_if_enemies_reached_earth()
        for _, enemy in pairs(game_object_handler.objects.enemies) do
            if enemy.coordinates.y + enemy.height > love.graphics.getHeight() then
                return true
            end
        end
        return false
    end

    function game_object_handler.__construct_player()
        local player_ = player.construct(player_controls)
        player_.assets = game_object_handler.assets_factory.get_assets(
            game_object_names.player
        )
        return player_
    end

    function game_object_handler.__update_object(dt, object)
        if not game_object_handler.__check_if_object_is_alive(object) then return end
        object.update(dt)
        game_object_handler.__handle_object_collision(object)
        game_object_handler.add_objects(object.collect_constructed_game_objects())
    end

    function game_object_handler.__check_if_object_is_alive(object)
        return object.lives > 0
    end

    function game_object_handler.__handle_object_collision(object)
        for _, target_type in pairs(game_object_handler.objects) do
            for _, target in pairs(target_type) do
                if (
                    object.division ~= target.division
                    and game_object_handler.__check_for_object_collision(object, target)
                ) then
                    game_object_handler.__handle_object_combat(object, target)
                end
            end
        end
    end

    function game_object_handler.__check_for_object_collision(object, target)
        if ((
                object.coordinates.x <= target.coordinates.x
                and object.coordinates.y <= target.coordinates.y
                and object.coordinates.x + object.width >= target.coordinates.x
                and object.coordinates.y + object.height >= target.coordinates.y
            ) or (
                object.coordinates.x <= target.coordinates.x
                and object.coordinates.y >= target.coordinates.y
                and object.coordinates.x + object.width >= target.coordinates.x
                and object.coordinates.y <= target.coordinates.y + target.height
            ) or (
                object.coordinates.x >= target.coordinates.x
                and object.coordinates.y <= target.coordinates.y
                and object.coordinates.x <= target.coordinates.x + target.width
                and object.coordinates.y + object.height >= target.coordinates.y
            ) or (
                object.coordinates.x >= target.coordinates.x
                and object.coordinates.y >= target.coordinates.y
                and object.coordinates.x <= target.coordinates.x + target.width
                and object.coordinates.y <= target.coordinates.y + target.height
            )
        ) then
            return true
        end
        return false
    end

    function game_object_handler.__handle_object_combat(object, target)
        object.lives = object.lives - target.strength
        target.lives = target.lives - object.strength
    end

    function game_object_handler.__remove_object_if_dead(object_table_id, object_id)
        local object = game_object_handler.objects[object_table_id][object_id]
        if game_object_handler.__check_if_object_is_alive(object) then return end
        object.play_die_sound()
        table.remove(game_object_handler.objects[object_table_id], object_id)
    end

    game_object_handler.__init__()
    return game_object_handler
end



return game_object_handler_class