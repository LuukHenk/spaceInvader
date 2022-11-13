-- Constructs the requested level
local levels = require "level_manager.levels"
local level_factory = {}

function level_factory.construct_level(level_id)
    local level = levels[level_id]
    if not level then return nil end
    return level.construct()
end

return level_factory