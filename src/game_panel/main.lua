-- Holds the game panel

local panel_ids = require "panel_manager.panel_ids"
local updater = require "game_panel.updater"
local draw = require "game_panel.draw" 

local game_panel = {}
game_panel.next_active_panel =  panel_ids.game_panel
game_panel.panel_id = panel_ids.game_panel


local counter = 0

function game_panel.load()
    print("loaded game panel")
end

function game_panel.update(dt)
    updater.update_game(dt)

    counter = counter + 1* dt

    if counter > 5 then
        game_panel.next_active_panel = panel_ids.basic_panel
    end
end

function game_panel.draw()
    draw.draw_game()
end

return game_panel