local base_object = require "config.base_object"
local base_bullet = require "config.bullets.player_bullet"
local player = {}
local PLAYER_TAG = "player"

player.HEIGHT = 15 * ScreenHeightScalingFactor
player.WIDTH = 50 * ScreenWidhtScalingFactor
function player.construct()
    local y_coord = love.graphics.getHeight() - player.HEIGHT
    local x_coord = love.graphics.getWidth() / 2 - player.WIDTH / 2
    local player_obj = base_object.construct(PLAYER_TAG, x_coord, y_coord)

    player_obj.color.red = 1
    player_obj.color.green = 0.31
    player_obj.width = player.WIDTH
    player_obj.height = player.HEIGHT
    player_obj.speed = 25 * ScreenWidhtScalingFactor

    player_obj.bullet = base_bullet
    player_obj.bullet_timeout = 10
    player_obj.bullet_cooldown = 0

    return player_obj
end

return player
