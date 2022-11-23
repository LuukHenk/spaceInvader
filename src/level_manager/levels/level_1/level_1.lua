local base_level = require "level_manager.levels.level"
local wave_1 = require "level_manager.levels.level_1.wave_1"
local wave_2 = require "level_manager.levels.level_1.wave_2"
local wave_3 = require "level_manager.levels.level_1.wave_3"
local level_1_class = {}




function level_1_class.construct(assets)
    local level_1 = base_level.construct(assets)

    level_1.waves = {
        wave_1.construct(),
        wave_2.construct(),
        wave_3.construct(),
    }

    return level_1
end

return level_1_class