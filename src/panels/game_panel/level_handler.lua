local level_factory = require "level_manager.level_factory"

local level_class = {}

function level_class.construct()
    local level_handler = {}
    function level_handler.__init__()
        level_handler.level_factory = level_factory.construct()
        level_handler.current_level_id = 0
        level_handler.current_level = nil
    end

    function level_handler.select_active_level(enemies_alive)
        -- Returns false if the level selection failed
        if not level_handler.__check_if_level_over(enemies_alive) then
            return true
        end
        local current_level_id = level_handler.current_level_id + 1
        local current_level = level_handler.level_factory.construct_level(
            current_level_id
        )

        if not current_level then
            level_handler.reset()
            return false
        end

        love.audio.stop()
        current_level.play_music()
        level_handler.current_level = current_level
        level_handler.current_level_id = current_level_id
        return true
    end

    function level_handler.update_current_level(dt)
        if not level_handler.current_level then return end
        level_handler.current_level.update(dt)
    end

    function level_handler.collect_constructed_enemies()
        if not level_handler.current_level then return {} end
        return level_handler.current_level.collect_constructed_enemies()
    end

    function level_handler.pause_level()
        if not level_handler.current_level then return end
        level_handler.current_level.pause()
    end

    function level_handler.continue_current_level()
        if not level_handler.current_level then return end
        level_handler.current_level.continue()
    end

    function level_handler.reset()
        if level_handler.current_level then
            level_handler.current_level.stop_music()
        else
            love.audio.stop()
        end
        level_handler.current_level = nil
        level_handler.current_level_id = 0
    end

    function level_handler.draw_background()
        if not level_handler.current_level then return end
        level_handler.current_level.draw_background()
    end

    function level_handler.__check_if_level_over(enemies_alive)
        return (
            not level_handler.current_level
            or not enemies_alive and level_handler.current_level.all_waves_spawned
        )
    end

    level_handler.__init__()
    return level_handler
end



return level_class