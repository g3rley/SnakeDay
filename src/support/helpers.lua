--- Draw an a cell in the cartesian plan
---@param x number
---@param y number
---@param size number
function DrawCell(x, y, size)

    love.graphics.rectangle(
        'fill',
        (x - 1) * size,
        (y - 1) * size,
        size - 1,
        size - 1
    )
end