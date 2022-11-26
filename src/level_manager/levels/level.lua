local level_base_class = {}

function level_base_class.construct(assets)
    local level = {}

    function level.__init__()
        level.assets = assets
        level.start_time = love.timer.getTime()
        level.pause_time = 0
        level.start_pause_timer = nil
        level.in_level_time = level.__calculate_in_level_time()

        level.all_waves_spawned = false
        level.constructed_enemies = {}
    end

    function level.update(dt)
        level.in_level_time = level.__calculate_in_level_time() * dt
        level.__spawn_new_enemies()
        level.__check_if_all_waves_spawned()
    end

    function level.pause()
        assets.pause_music()
        level.start_pause_timer = love.timer.getTime()
    end

    function level.continue()
        assets.play_music()
        level.pause_time = level.pause_time + love.timer.getTime() - level.start_pause_timer
    end

    function level.__calculate_in_level_time()
        return love.timer.getTime() - level.start_time - level.pause_time
    end

    function level.__spawn_new_enemies()
        for _, wave in pairs(level.waves) do
            if wave.ready_to_spawn(level.in_level_time) then
                for _, enemy in pairs(wave.spawn()) do
                    table.insert(level.constructed_enemies, enemy)
                end
            end
        end
    end

    function level.__check_if_all_waves_spawned()
        local all_waves_spawned = true
        for _, wave in pairs(level.waves) do
            if not wave.wave_over then
                all_waves_spawned = false
            end
        end
        level.all_waves_spawned = all_waves_spawned
    end

    function level.collect_constructed_enemies()
        local constructed_enemies = level.constructed_enemies
        level.constructed_enemies = {}

        return constructed_enemies
    end


    -- Pass asset objects
    function level.draw_background()
        return assets.draw_background()
    end

    function level.play_music()
        assets.play_music()
    end

    function level.stop_music()
        assets.stop_music()
    end

    level.__init__()
    return level
end


return level_base_class

