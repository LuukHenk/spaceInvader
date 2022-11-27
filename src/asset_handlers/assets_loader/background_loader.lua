
local basic_loader = require "asset_handlers.assets_loader.basic_loader" 

local FOLDER = "backgrounds/"
local EXTENSION_TYPE = ".png"


local background_loader_class = {}

function background_loader_class.construct()
    local loader = basic_loader.construct(
        FOLDER,
        EXTENSION_TYPE,
        background_loader_class.__load_background
    )
    return loader
end

function background_loader_class.__load_background(path)
    return love.graphics.newImage(path)
end

return background_loader_class