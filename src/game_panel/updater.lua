-- Holds the basic panel the functionailty during update
local panel_ids = require "panel_manager.panel_ids"
local object_types = require "game_objects.object_types"
local level_factory = require "level_manager.level_factory"

local updater = {}

function updater.update_game(dt, game)
    updater.select_active_level(game)
    updater.update_game_objects(dt, game.object_handler)
    -- updater.check_if_game_over(game)
end

function updater.update_game_objects(dt, object_handler)
    local all_objects = object_handler.get_all_objects()
    for _, object in pairs(all_objects) do
        object.update(dt)
        updater.handle_object_collision(object, all_objects)
        -- Check (and destroy) if dead
        object_handler.add_objects(object.collect_constructed_game_objects())
    end
end

function updater.handle_object_collision(object, targets)
    for _, target in pairs(targets) do
        if (
            object.division ~= target.division
            and updater.check_for_collision(object, target)
        ) then
            print(target.type, object.type)
            updater.handle_object_combat(object, target)
        end
    end
end

function updater.handle_object_combat(object, target)
    object.lives = object.lives - target.strength
    target.lives = target.lives - object.strength
end

-- function updater.check_if_game_over(game)
--     -- enemies reached earth
--     -- player is dead
--     if (
--         -- not updater.check_if_tag_in_objects(object_types.player, game.objects) 
--         updater.check_if_enemies_reached_earth(game.objects)
--     ) then
--         updater.handle_game_over(game)
--     end
-- end
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

--         if bullet.tag == object_types.enemy and updater.check_for_collision(bullet, player) then
--             updater.handle_game_over(game)
--         end

--         if bullet.tag == object_types.player then
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
    if game.object_handler.enemies_alive() then return end

    game.current_level = game.current_level + 1
    local level_objects = level_factory.construct_level(game.current_level)
    if not level_objects then
        updater.handle_game_over(game)
        return
    end

    game.object_handler.add_objects(level_objects)
end

-- function updater.check_if_enemies_reached_earth(objects)
--     for _, object in pairs(objects) do
--         if (
--             object.coordinates.y + object.height > love.graphics.getHeight()
--             and object.tag == object_types.enemy
--         ) then
--             return true
--         end
--     end
--     return false
-- end

function updater.handle_game_over(game)
    game.objects = {}
    game.current_level = 0
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