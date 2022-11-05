local enemies_config = require "config.enemies_config"

local game_config = {}

-- Construct levels
local level_1 = {}
level_1.id = "level 1"
level_1.enemies = {
    enemies_config.construct_basic_enemy(0, 0),
    enemies_config.construct_basic_enemy(50, 0),
    enemies_config.construct_basic_enemy(100, 0)
}

game_config.levels = { level_1 }

return game_config
