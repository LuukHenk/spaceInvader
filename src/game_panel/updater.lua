local panel_ids = require "panel_manager.panel_ids"

local updater = {}

function updater.update_game(dt, game)
    updater.select_active_level(game)
    updater.update_level(dt, game)
    updater.update_game_objects(dt, game.object_handler)
    updater.check_if_game_over(game)
end

function updater.update_level(dt, game)
    if game.current_level then
        game.current_level.update(dt)
        game.object_handler.add_objects(game.current_level.collect_constructed_enemies())
    end
end

function updater.update_game_objects(dt, object_handler)
    local all_objects = object_handler.get_all_objects()
    for _, object in pairs(all_objects) do
        object.update(dt)
        updater.handle_object_collision(object, object_handler.get_all_objects())
        updater.remove_if_dead(object, object_handler)
        object_handler.add_objects(object.collect_constructed_game_objects())

        if not object_handler.player then return end
    end
end

function updater.handle_object_collision(object, targets)
    for _, target in pairs(targets) do
        if (
            object.division ~= target.division
            and updater.check_for_collision(object, target)
        ) then
            updater.handle_object_combat(object, target)
        end
    end
end

function updater.handle_object_combat(object, target)
    object.lives = object.lives - target.strength
    target.lives = target.lives - object.strength
end

function updater.remove_if_dead(object, object_handler)
    if object.lives <= 0 then
        object_handler.remove_object_by_id(object.id)
    end
end

function updater.check_if_game_over(game)
    if (
        not game.object_handler.player
        or updater.check_if_enemies_reached_earth(game.object_handler.enemies)
    ) then
        updater.handle_game_over(game)
    end
end

function updater.check_if_enemies_reached_earth(enemies)
    for _, enemy in pairs(enemies) do
        if enemy.coordinates.y > love.graphics.getHeight() then
            return true
        end
    end
    return false
end

function updater.select_active_level(game)
    -- Switches level if needed. Switches panel if all levels are done
    if not updater.check_if_level_over(game) then return end

    game.current_level_id = game.current_level_id + 1
    love.audio.stop()
    game.current_level = game.level_factory.construct_level(game.current_level_id)

    if not game.current_level then
        updater.handle_game_over(game)
        return
    end
    game.current_level.play_music()
end

function updater.check_if_level_over(game)
    if (
        not game.current_level
        or not game.object_handler.enemies_alive() and game.current_level.all_waves_spawned
    ) then
        return true
    end
    return false
end

function updater.handle_game_over(game)
    game.object_handler.reset()
    game.current_level_id = 0
    love.audio.stop()
    game.next_active_panel = panel_ids.game_over_panel
end

function updater.check_for_collision(object, target)
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

return updater