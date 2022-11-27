local asset_types = require "asset_handlers.assets_loader.asset_types"
local assets_loader = require "asset_handlers.assets_loader.assets_loader"

local fonts_class = {}

local FONT_NAME = "generic_font"
function fonts_class.construct()
    local fonts = {}

    function fonts.__init__()
        fonts.assets_loader = assets_loader.construct()
        fonts.font_name = fonts.assets_loader.get_asset(asset_types.FONT, FONT_NAME)
        fonts.title_font = love.graphics.newFont(fonts.font_name, 60)
        fonts.header_font = love.graphics.newFont(fonts.font_name, 15)
    end

    function fonts.set_title_font()
        love.graphics.setFont(fonts.title_font)
    end
    fonts.__init__()
    return fonts
end
return fonts_class