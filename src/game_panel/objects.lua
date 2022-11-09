-- Holds the game objects

local player = require "game_panel.config.player"
local game_objects = {}

function game_objects.check_active_enemies()
    -- checks if there are still enemies active. Returns true if there are still
    -- enemies active
    for _ in pairs(game_objects.enemies) do return true end
    return false
end

function game_objects.clear()
    game_objects.player = player.construct()
    game_objects.enemies = {}
    game_objects.bullets = {}
end

game_objects.clear()
return game_objects