local base_object = require "game_panel.objects.base_shooting_object"
local base_bullet = require "game_panel.objects.bullets.player_bullet"
local object_tags = require "game_panel.objects.object_tags"
local player_class = {}

player_class.HEIGHT = 15 * ScreenHeightScalingFactor
player_class.WIDTH = 50 * ScreenWidhtScalingFactor
player_class.TAG = object_tags.player

function player_class.construct()
    local y_coord = love.graphics.getHeight() - player_class.HEIGHT
    local x_coord = love.graphics.getWidth() / 2 - player_class.WIDTH / 2
    local player = base_object.construct(player_class.TAG, x_coord, y_coord)

    player.color.red = 1
    player.color.green = 0.31
    player.width = player_class.WIDTH
    player.height = player_class.HEIGHT
    player.speed = 300 * ScreenWidhtScalingFactor

    player.bullet = base_bullet
    player.bullet_timeout = 0.5
    player.bullet_cooldown = 0


    function player.move(dt, controls)
        local direction = 0

        if love.keyboard.isDown(controls.move_left) and player.coordinates.x > 0 then
            direction = direction - 1
        end

        local right_movement_valid = player.width + player.coordinates.x < love.graphics.getWidth()
        if love.keyboard.isDown(controls.move_right) and right_movement_valid then
            direction = direction + 1
        end
        player.coordinates.x = player.coordinates.x + player.speed * dt * direction
    end

    function player.shoot(dt, controls)
        -- Returns a bullet if a bullet has spawned else nil
        if player.bullet_cooldown > 0 then
            player.bullet_cooldown = player.bullet_cooldown - 1 * dt
        end

        if love.keyboard.isDown(controls.shoot) then
            return player.parent_functions.shoot()
        end
        return nil
    end

    return player
end

return player_class
