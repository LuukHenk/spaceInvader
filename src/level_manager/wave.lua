local wave_class = {}

function wave_class.construct(start_time, enemies_to_spawn)
    local wave = {}
    wave.start_time = start_time
    wave.enemies_to_spawn = enemies_to_spawn
    wave.wave_over = false

    function wave.ready_to_spawn(current_level_timestamp)
        if wave.wave_over or wave.start_time > current_level_timestamp then
            return false
        end
        return true
    end

    function wave.spawn()
        local wave_objects = {}
        for _, enemies_to_spawn in pairs(wave.enemies_to_spawn) do
            table.insert(wave_objects, enemies_to_spawn.spawn())
        end
        wave.wave_over = true
        return wave_objects
    end

    return wave
end

return wave_class