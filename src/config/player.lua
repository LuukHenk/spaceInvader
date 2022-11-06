local base_object = require "config.base_shooting_object"
local base_bullet = require "config.bullets.player_bullet"
local player_class = {}
local PLAYER_TAG = "player"

player_class.HEIGHT = 15 * ScreenHeightScalingFactor
player_class.WIDTH = 50 * ScreenWidhtScalingFactor
function player_class.construct()
    local y_coord = love.graphics.getHeight() - player_class.HEIGHT
    local x_coord = love.graphics.getWidth() / 2 - player_class.WIDTH / 2
    local player = base_object.construct(PLAYER_TAG, x_coord, y_coord)

    player.color.red = 1
    player.color.green = 0.31
    player.width = player_class.WIDTH
    player.height = player_class.HEIGHT
    player.speed = 300 * ScreenWidhtScalingFactor

    player.bullet = base_bullet
    player.bullet_timeout = 0.5
    player.bullet_cooldown = 0

    function player.update(dt, controls)
        -- Returns a bullet if a bullet has spawned else nil
        local direction = 0

        if player.bullet_cooldown > 0 then
            player.bullet_cooldown = player.bullet_cooldown - 1 * dt
        end
        if love.keyboard.isDown(controls.keybinds.move_left) then
            direction = direction - 1
        end

        if love.keyboard.isDown(controls.keybinds.move_right) then
            direction = direction + 1
        end
        player.coordinates.x = player.coordinates.x + player.speed * dt * direction
        if love.keyboard.isDown(controls.keybinds.shoot) then
            return player.shoot()
        else
            return nil
        end
    end

    return player
end

return player_class
