-- states
local RUNNING_STATE = "running"
local PAUSE_STATE = "pause"
local LEVEL_OVER_STATE = "level_over"
local GAME_OVER_STATE = "game_over"

local game = {}

function game.load()
    game.state = LEVEL_OVER_STATE
    game.config = {}
    game.current_level = 0
end

function game.update()
    if game.state == LEVEL_OVER_STATE then
        game.current_level = game.current_level + 1
        game.construct_current_level()
        game.state = RUNNING_STATE
    elseif game.state == RUNNING_STATE then

    elseif game.state == GAME_OVER_STATE then

    elseif game.state == PAUSE_STATE then
    end
end

function game.draw()

end

function game.construct_current_level()
    print(game.current_level)
end

return game
