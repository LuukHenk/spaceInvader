local enemies_config = {}



function enemies_config.construct_basic_enemy(x, y)
    local basic_enemy = {}
    basic_enemy.mode = "fill"
    basic_enemy.width = 10
    basic_enemy.height = 10
    basic_enemy.speed = 10

    basic_enemy.color = {}
    basic_enemy.color.red = 0
    basic_enemy.color.green = 1
    basic_enemy.color.blue = 0
    basic_enemy.color.alpha = 1

    basic_enemy.coordinates = {}
    basic_enemy.coordinates.x = x
    basic_enemy.coordinates.y = y

    return basic_enemy
end

return enemies_config
