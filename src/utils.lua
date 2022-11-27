local utils = {}


function utils.table_size(table)
    -- Returns the size of a table
    local counter = 0
    for _ in pairs(table) do counter = counter + 1 end
    return counter
end

function utils.check_for_collision(object, target)
    if ((
            object.coordinates.x <= target.coordinates.x
            and object.coordinates.y <= target.coordinates.y
            and object.coordinates.x + object.width >= target.coordinates.x
            and object.coordinates.y + object.height >= target.coordinates.y
        ) or (
            object.coordinates.x <= target.coordinates.x
            and object.coordinates.y >= target.coordinates.y
            and object.coordinates.x + object.width >= target.coordinates.x
            and object.coordinates.y <= target.coordinates.y + target.height
        ) or (
            object.coordinates.x >= target.coordinates.x
            and object.coordinates.y <= target.coordinates.y
            and object.coordinates.x <= target.coordinates.x + target.width
            and object.coordinates.y + object.height >= target.coordinates.y
        ) or (
            object.coordinates.x >= target.coordinates.x
            and object.coordinates.y >= target.coordinates.y
            and object.coordinates.x <= target.coordinates.x + target.width
            and object.coordinates.y <= target.coordinates.y + target.height
        )
    ) then
        return true
    end
    return false
end
return utils