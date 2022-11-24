
local shooting_object = require "game_objects.shooting_object"
local object_types = require "game_objects.object_types"
local game_object_names = require "game_objects.game_object_names"
local player_bullet = require "game_objects.bullets.player_bullet"

local player_class = {}

function player_class.construct(controls)
    local player = shooting_object.construct(
        game_object_names.player,
        object_types.player,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight()
    )
    player.resize(50, 15)
    player.set_coordinates(
        player.coordinates.x - player.width / 2, 
        player.coordinates.y - player.height
    )
    player.set_color(1, 0.31, 0, 1)
    
    player.speed = 700

    player.bullet = player_bullet
    player.shooting_cooldown_time = 0.4
    player.shooting_cooldown = 0

    player.controls = controls

    function player.update(dt)
        player.move(dt)
        player.shoot(dt, not love.keyboard.isDown(player.controls.shoot))
    end


    function player.move(dt)
        local direction = 0
        if love.keyboard.isDown(player.controls.move_left) and player.coordinates.x > 0 then
            direction = direction - 1
        end
        local right_movement_valid = player.width + player.coordinates.x < love.graphics.getWidth()
        if love.keyboard.isDown(player.controls.move_right) and right_movement_valid then
            direction = direction + 1
        end

        if direction < 0 then
            player.move_left(dt)
        elseif direction > 0 then
            player.move_right(dt)
        end
    end

    return player
end

return player_class