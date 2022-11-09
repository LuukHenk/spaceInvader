-- Manages the current active panel

local panel_ids = require "panel_manager.panel_ids"
local panels = require "panel_manager.panels"

local active_panel_manager = {}
local default_active_panel =  panel_ids.game_over_panel
active_panel_manager.active_panel = panels[default_active_panel]

function active_panel_manager.load()
    active_panel_manager.active_panel.load()
end

function active_panel_manager.update(dt)
    active_panel_manager.select_next_active_panel()
    active_panel_manager.active_panel.update(dt)
end

function active_panel_manager.draw()
    active_panel_manager.active_panel.draw()
end


function active_panel_manager.select_next_active_panel()
    -- Selects the next panel, and loads the panel if there is a new panel
    local panel = active_panel_manager.active_panel
    if panel.next_active_panel ~= panel.panel_id then
        local new_panel = panels[panel.next_active_panel]
        new_panel.next_active_panel = new_panel.panel_id
        active_panel_manager.active_panel = new_panel
        love.load()
    end
end
return active_panel_manager