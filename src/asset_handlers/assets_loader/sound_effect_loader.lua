
local basic_loader = require "asset_handlers.assets_loader.basic_loader" 

local FOLDER = "sound_effects/"
local EXTENSION_TYPE = ".wav"


local sound_effect_loader_class = {}

function sound_effect_loader_class.construct()
    local loader = basic_loader.construct(
        FOLDER,
        EXTENSION_TYPE,
        sound_effect_loader_class.__load_sound_effect
    )
    return loader
end

function sound_effect_loader_class.__load_sound_effect(path)
    return love.audio.newSource(path, "static")
end

return sound_effect_loader_class