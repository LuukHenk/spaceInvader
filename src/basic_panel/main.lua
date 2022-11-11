local panel_ids = require "panel_manager.panel_ids"
local panel_factory = require "panel_manager.panel_factory"
local draw = require "draw"

local basic_panel = panel_factory.construct_panel(panel_ids.basic_panel)

function basic_panel.load()
    print("loaded basic panel")
end

function basic_panel.draw()
    draw.draw_panel_title("This is a basic page")
end

return basic_panel