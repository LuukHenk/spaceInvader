
local asset_types         = require "asset_handlers.assets_loader.asset_types"
local music_loader        = require "asset_handlers.assets_loader.music_loader"
local sound_effect_loader = require "asset_handlers.assets_loader.sound_effect_loader"
local background_loader   = require "asset_handlers.assets_loader.background_loader"
local sprite_loader       = require "asset_handlers.assets_loader.sprite_loader"
local font_loader         = require "asset_handlers.assets_loader.font_loader"


local assets_loader_class = {}

function assets_loader_class.construct()
    local assets_loader = {}

    function assets_loader.__init()
        assets_loader.loaders = assets_loader.__construct_asset_loaders()
    end

    function assets_loader.get_asset(asset_type, asset_name)
        return assets_loader.loaders[asset_type].load_asset(asset_name)
    end

    function assets_loader.__construct_asset_loaders()
        local loaders = {}
        loaders[asset_types.MUSIC] = music_loader.construct()
        loaders[asset_types.SOUND_EFFECTS] = sound_effect_loader.construct()
        loaders[asset_types.BACKGROUND] = background_loader.construct()
        loaders[asset_types.SPRITE] = sprite_loader.construct()
        loaders[asset_types.FONT] = font_loader.construct()
        return loaders
    end

    assets_loader.__init()
    return assets_loader
end

return assets_loader_class