
local basic_loader = require "asset_handlers.assets_loader.basic_loader" 

local FOLDER = "assets/music/"
local EXTENSION_TYPE = ".mp3"

local music_loader_class = {}

function music_loader_class.construct()
    local loader = basic_loader.construct(
        FOLDER,
        EXTENSION_TYPE,
        music_loader_class.__load_music
    )
    return loader
end

function music_loader_class.__load_music(path)
    return love.audio.newSource(path, "stream")
end

return music_loader_class