-- Holds a basic example panel

local panel_ids = require "panel_manager.panel_ids"
local updater = require "basic_panel.updater"
local draw = require "basic_panel.draw" 

local basic_panel = {}
basic_panel.next_active_panel =  panel_ids.basic_panel
basic_panel.panel_id = panel_ids.basic_panel


function basic_panel.load()
    print("loaded basic panel")

end

function basic_panel.update(dt)
    updater.update_basic(dt)
end

function basic_panel.draw()
    draw.draw_basic()
end

return basic_panel