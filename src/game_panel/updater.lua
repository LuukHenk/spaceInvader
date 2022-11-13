-- Holds the basic panel the functionailty during update
local panel_ids = require "panel_manager.panel_ids"
local object_tags = require "game_objects.object_tags"
local level_factory = require "level_manager.level_factory"

local updater = {}

function updater.update_game(dt, game)
    updater.select_active_level(game)
    updater.update_game_objects(dt, game.objects)
    updater.destroy_objects_with_no_lives(game.objects)
    updater.check_if_game_over(game)
    updater.spawn_new_game_objects(game.objects)
end

function updater.update_game_objects(dt, objects)
    for _, object in pairs(objects) do
        object.update(dt)
    end
end

function updater.spawn_new_game_objects(objects)
    local new_objects = {}
    for _, object in pairs(objects) do
        for _, new_object in pairs(object.collect_constructed_game_objects()) do
            table.insert(new_objects, new_object)
        end
    end
    for _, object in pairs(new_objects) do
        table.insert(objects, 0, object)
    end
end

function updater.destroy_objects_with_no_lives(objects)
    for i, object in pairs(objects) do
        if object.lives < 1 then
            table.remove(objects, i)
        end
    end
end

function updater.check_if_game_over(game)
    if (
        -- not updater.check_if_tag_in_objects(object_tags.player, game.objects) 
        updater.check_if_enemies_reached_earth(game.objects)
    ) then
        updater.handle_game_over(game)
    end
end
-- function updater.handle_player(dt, game)
--     local player = game.objects.player
--     player.move(dt, game.controls)
--     local bullet = player.shoot(dt, game.controls)
--     if bullet then table.insert(game.objects.bullets, bullet) end
-- end

-- function updater.handle_enemies(dt, game)
--     local enemies = game.objects.enemies
--     local bullets = game.objects.bullets

--     for _, enemy in pairs(enemies) do
--         enemy.move(dt)
--         local enemy_reaches_world =  enemy.coordinates.y + enemy.height > love.graphics.getHeight()
--         if enemy_reaches_world or updater.check_for_collision(enemy, game.objects.player) then
--             updater.handle_game_over(game)
--             return
--         end

--         local bullet = enemy.shoot(dt)
--         if bullet then table.insert(bullets, bullet) end
--     end
-- end

-- function updater.handle_bullets(dt, game)
--     local bullets = game.objects.bullets
--     local player = game.objects.player
--     local enemies = game.objects.enemies

--     for _, bullet in pairs(bullets) do

--         if bullet.tag == object_tags.enemy and updater.check_for_collision(bullet, player) then
--             updater.handle_game_over(game)
--         end

--         if bullet.tag == object_tags.player then
--             updater.remove_enemy_on_collision(enemies, bullet)
--         end

--         bullet.update(dt)
--     end
-- end

-- function updater.remove_enemy_on_collision(enemies, target)
--     for id, enemy in pairs(enemies) do
--         if updater.check_for_collision(enemy, target) then
--             table.remove(enemies, id)
--         end
--     end
-- end

function updater.select_active_level(game)
    -- Switches level if needed. Switches panel if all levels are done
    if updater.check_if_tag_in_objects(object_tags.enemy, game.objects) then return end

    game.current_level = game.current_level + 1
    local level_objects = level_factory.construct_level(game.current_level)
    if not level_objects then
        updater.handle_game_over(game)
        return
    end

    for _, object in pairs(level_objects) do
        table.insert(game.objects, object)
    end
end

function updater.check_if_tag_in_objects(tag, objects)
    for _, object in pairs(objects) do
        if object.tag == tag then
            return true
        end
    end
    return false
end

function updater.check_if_enemies_reached_earth(objects)
    for _, object in pairs(objects) do
        if (
            object.coordinates.y + object.height > love.graphics.getHeight()
            and object.tag == object_tags.enemy
        ) then
            return true
        end
    end
    return false
end

function updater.handle_game_over(game)
    game.objects = {}
    game.current_level = 0
    game.next_active_panel = panel_ids.game_over_panel
end

function updater.check_for_collision(object, target)
    -- Returns the target its tag if there is collision
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