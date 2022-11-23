local level_base_class = {}

function level_base_class.construct(assets)
    local level = {}
    level.assets = assets
    level.start_time = os.clock()
    level.in_level_time = os.clock() - level.start_time
    level.objects = {}

    -- Abstract
    function level.update(dt)
    end

    -- Pass asset objects
    function level.get_background()
        return assets.get_background()
    end

    function level.play_music()
        assets.play_music()
    end

    return level
end


return level_base_class

