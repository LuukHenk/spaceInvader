local config = require "config.game_config"
local player = require "config.player"
local draw = require "draw"

-- states
local RUNNING_STATE = "running"
local PAUSE_STATE = "pause"
local LEVEL_OVER_STATE = "level_over"
local GAME_OVER_STATE = "game_over"
local GAME_WON_STATE = "game_won"

local game = {}

function game.load(controls)
    game.state = LEVEL_OVER_STATE
    game.current_level = 0
    game.enemies = {}
    game.bullets = {}
    game.player = player.construct()
    game.controls = controls
end

function game.update(dt)
    if game.state == LEVEL_OVER_STATE then
        game.go_to_next_level()
    elseif game.state == RUNNING_STATE then
        game.update_game_objects(dt)
    end
end

function game.draw()
    if game.state == RUNNING_STATE then
        game.draw_game_objects()
    elseif game.state == GAME_OVER_STATE then
        draw.draw_centered_text("Game over")
    end
end

function game.draw_game_objects()
    for _, bullet in pairs(game.bullets) do
        draw.draw_rectangle(bullet)
    end
    draw.draw_rectangle(game.player)
    for _, enemy in pairs(game.enemies) do
        draw.draw_rectangle(enemy)
    end
end

function game.update_game_objects(dt)
    -- TODO collision update
    -- TODO player update
    local player_bullet = game.player.update(dt, game.controls)
    if player_bullet then table.insert(game.bullets, player_bullet) end
    for _, enemy in pairs(game.enemies) do
        local enemy_bullet = enemy.update(dt)
        if enemy_bullet then table.insert(game.bullets, enemy_bullet) end
        if enemy.coordinates.y + enemy.height > love.graphics.getHeight() then
            game.state = GAME_OVER_STATE
        end
    end

    for _, bullet in pairs(game.bullets) do
        bullet.update(dt)
    end
end

function game.go_to_next_level()
    game.current_level = game.current_level + 1
    local level_config = config.levels[game.current_level]
    if not level_config then
        game.state = GAME_WON_STATE
        return
    end

    game.construct_level(level_config)

    game.state = RUNNING_STATE
end

function game.construct_level(level_config)
    for _, enemy in pairs(level_config.enemies) do
        table.insert(game.enemies, enemy)
    end
end

return game
