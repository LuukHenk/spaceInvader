local config = require "config.game_config"
local drawer = require "draw"

-- states
local RUNNING_STATE = "running"
local PAUSE_STATE = "pause"
local LEVEL_OVER_STATE = "level_over"
local GAME_OVER_STATE = "game_over"
local GAME_WON_STATE = "game_won"

local game = {}

function game.load()
    game.state = LEVEL_OVER_STATE
    game.current_level = 0
    game.enemies = {}
    game.bullets = {}
end

function game.update(dt)
    if game.state == LEVEL_OVER_STATE then
        game.go_to_next_level()
    elseif game.state == RUNNING_STATE then
        game.update_game_objects(dt)
    elseif game.state == GAME_OVER_STATE then

    elseif game.state == PAUSE_STATE then
    end
end

function game.draw()
    for _, bullet in pairs(game.bullets) do
        drawer.draw_rectangle(bullet)
    end
    for _, enemy in pairs(game.enemies) do
        drawer.draw_rectangle(enemy)
    end


end

function game.update_game_objects(dt)
    -- TODO player update
    for _, enemy in pairs(game.enemies) do
        local enemy_bullet = enemy.update(dt)
        if enemy_bullet then table.insert(game.bullets, enemy_bullet) end
    end

    for _, bullet in pairs(game.bullets) do
        bullet.update(dt)
    end
    -- TODO bullet update
    -- TODO collision update
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
