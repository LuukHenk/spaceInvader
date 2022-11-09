local utils = {}


function utils.table_size(table)
    -- Returns the size of a table
    local counter = 0
    for _ in pairs(table) do counter = counter + 1 end
    return counter
end

return utils