local level_config = {}

function level_config.construct_level(level_id)
    local level = {}
    level.id = level_id
    level.enemies = {}

    function level.add_enemy(enemy)
        table.insert(level.enemies, enemy)
    end

    return level
end

return level_config