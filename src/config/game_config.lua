local base_enemy = require "config.base_enemy"
local level_config = require "config.level_config"

local game_config = {}

-- Construct levels
local level_1 = level_config.construct_level("level 1")
level_1.add_enemy(base_enemy.construct(0, 0))
level_1.add_enemy(base_enemy.construct(0, 50))
level_1.add_enemy(base_enemy.construct(0, 100))
game_config.levels = { level_1 }

return game_config
