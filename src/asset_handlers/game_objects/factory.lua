local game_object_names = require "game_objects.game_object_names"
local assets_loader = require "assets.assets_loader"
local game_object_assets_handler = require "asset_handlers.game_objects.handler"

local factory_class = {}

function factory_class.construct()
    local factory = {}

    function factory.__init__()
        factory.assets_loader = assets_loader.construct()
        factory.asset_objects = factory.__get_assets_for_all_game_objects()
    end

    function factory.get_assets(game_object_name)
        return factory.asset_objects[game_object_name]
    end

    function factory.__get_assets_for_all_game_objects()
        local objects = {}
        for _, name in pairs(game_object_names) do
            objects[name] = game_object_assets_handler.construct(name, factory.assets_loader)
        end
        return objects
    end

    factory.__init__()
    return factory
end

return factory_class
