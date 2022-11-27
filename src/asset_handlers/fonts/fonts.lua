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
        fonts.header_font = love.graphics.newFont(fonts.font_name, 40)
        fonts.selection_menu_font = love.graphics.newFont(fonts.font_name, 20)
        fonts.normal_font = love.graphics.newFont(fonts.font_name, 12)
        fonts.reset_font()
    end

    function fonts.set_title_font()
        love.graphics.setFont(fonts.title_font)
    end

    function fonts.set_header_font()
        love.graphics.setFont(fonts.header_font)
    end

    function fonts.set_selection_menu_font()
        love.graphics.setFont(fonts.selection_menu_font)
    end
    function fonts.reset_font()
        love.graphics.setFont(fonts.normal_font)
    end
    fonts.__init__()
    return fonts
end
return fonts_class