local level_base_class = {}

function level_base_class.construct(assets)
    local level = {}
    level.assets = assets
    level.objects = {}
    return level
end


return level_base_class

