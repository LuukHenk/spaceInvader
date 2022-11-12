-- Holds the basic panel the functionailty during update
local config = require "game_panel.config.game_config"
local panel_ids = require "panel_manager.panel_ids"
local object_tags = require "game_panel.objects.object_tags"

local updater = {}

function updater.update_game(dt, game)
    updater.select_active_level(game)
    updater.handle_player(dt, game)
    updater.handle_enemies(dt, game)
    updater.handle_bullets(dt, game)
end

function updater.handle_player(dt, game)
    local player = game.objects.player
    player.move(dt, game.controls)
    local bullet = player.shoot(dt, game.controls)
    if bullet then table.insert(game.objects.bullets, bullet) end
end

function updater.handle_enemies(dt, game)
    local enemies = game.objects.enemies
    local bullets = game.objects.bullets

    for _, enemy in pairs(enemies) do
        enemy.move(dt)
        local enemy_reaches_world =  enemy.coordinates.y + enemy.height > love.graphics.getHeight()
        if enemy_reaches_world or updater.check_for_collision(enemy, game.objects.player) then
            updater.handle_game_over(game)
            return
        end

        local bullet = enemy.shoot(dt)
        if bullet then table.insert(bullets, bullet) end
    end
end

function updater.handle_bullets(dt, game)
    local bullets = game.objects.bullets
    local player = game.objects.player
    local enemies = game.objects.enemies

    for _, bullet in pairs(bullets) do

        if bullet.tag == object_tags.enemy and updater.check_for_collision(bullet, player) then
            updater.handle_game_over(game)
        end

        if bullet.tag == object_tags.player then
            updater.remove_enemy_on_collision(enemies, bullet)
        end

        bullet.update(dt)
    end
end

function updater.remove_enemy_on_collision(enemies, target)
    for id, enemy in pairs(enemies) do
        if updater.check_for_collision(enemy, target) then
            table.remove(enemies, id)
        end
    end
end

function updater.select_active_level(game)
    -- Switches level if needed. Switches panel if all levels are done
    if game.objects.check_active_enemies() then
        return
    end

    game.current_level = game.current_level + 1
    local level_config = config.levels[game.current_level]
    if not level_config then
        updater.handle_game_over(game)
        return
    end

    updater.construct_level(game, level_config)
end

function updater.construct_level(game, level_config)
    -- Constructs the next active level
    game.objects.enemies = {}
    game.objects.bullets = {}

    for _, enemy in pairs(level_config.enemies) do
        table.insert(game.objects.enemies, enemy)
    end
end

function updater.handle_game_over(game)
    game.objects.clear()
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