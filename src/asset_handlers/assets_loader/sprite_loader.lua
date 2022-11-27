
local basic_loader = require "asset_handlers.assets_loader.basic_loader" 

local FOLDER = "sprites/"
local EXTENSION_TYPE = ".png"


local sprite_loader_class = {}

function sprite_loader_class.construct()
    local loader = basic_loader.construct(
        FOLDER,
        EXTENSION_TYPE,
        sprite_loader_class.__load_sprite
    )
    return loader
end

function sprite_loader_class.__load_sprite(path)
    return love.graphics.newImage(path)
end

return sprite_loader_class