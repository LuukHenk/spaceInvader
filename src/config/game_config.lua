local base_enemy = require "config.base_enemy"
local level_config = require "config.level_config"

local game_config = {}

-- Construct levels
local level_1 = level_config.construct_level("level 1")
local total_enemies = 9
local generated_enemies = 0

local enemy_spacing = 192 * ScreenWidhtScalingFactor

repeat
    generated_enemies = generated_enemies + 1
    level_1.add_enemy(base_enemy.construct(enemy_spacing * generated_enemies, 0))
until (generated_enemies == total_enemies)

game_config.levels = { level_1 }

return game_config
