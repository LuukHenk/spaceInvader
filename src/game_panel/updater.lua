-- Holds the basic panel the functionailty during update
local config = require "game_panel.config.game_config"
local panel_ids = require "panel_manager.panel_ids"

local updater = {}

function updater.update_game(dt, game)
    updater.select_active_level(game)

    -- TODO handle collision
    updater.handle_player(dt, game)
    updater.handle_enemies(dt, game)
    updater.handle_bullets(dt, game.objects.bullets)
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
        if enemy.coordinates.y + enemy.height > love.graphics.getHeight() then
            updater.handle_game_over(game)
            return
        end

        local bullet = enemy.shoot(dt)
        if bullet then table.insert(bullets, bullet) end
    end
end

function updater.handle_bullets(dt, bullets)
    for _, bullet in pairs(bullets) do
        bullet.update(dt)
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
        updater.handle_game_won(game)
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
    game.next_active_panel = panel_ids.basic_panel
end

function updater.handle_game_won(game)
    game.objects.clear()
    game.next_active_panel = panel_ids.basic_panel
end

return updater