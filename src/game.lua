local config = require "config.game_config"

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
end

function game.update()
    if game.state == LEVEL_OVER_STATE then
        game.go_to_next_level()
    elseif game.state == RUNNING_STATE then

    elseif game.state == GAME_OVER_STATE then

    elseif game.state == PAUSE_STATE then
    end
end

function game.draw()
    if game.enemies then
        for _, enemy in pairs(game.enemies) do

            love.graphics.setColor(
                enemy.color.red,
                enemy.color.green,
                enemy.color.blue,
                enemy.color.alpha
            )
            print(enemy.color.red)
            love.graphics.rectangle(
                enemy.mode,
                enemy.coordinates.x,
                enemy.coordinates.y,
                enemy.width,
                enemy.height
            )
        end
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
    if level_config.enemies then
        for _, enemy in pairs(level_config.enemies) do
            print(enemy)
            table.insert(game.enemies, enemy)
        end
    end
end

return game
