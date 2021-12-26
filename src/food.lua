-- file: food.lua
Food = Object.extend(Object)

--- Constructor of a Food class
---@param position table
function Food:new(position)

    self.position = position
end

--- Execute routines relationed the food elements by transition into frames
---@param dt any
function Food:update(dt)

end

--- Draw elements like a snake food
function Food:draw()

end

--- Realocate a food object on the game plan
function MoveFood()

    local possibleFoodPositions = {}

    for foodX = 1, GridXCount do
        for foodY = 1, GridYCount do
            local possible = true

            for segmentIndex, segment in ipairs(SnakePlayer.segments) do
                if foodX == segment.x and foodY == segment.y then
                    possible = false
                end
            end

            if possible then
                table.insert(possibleFoodPositions, {
                    x = foodX,
                    y = foodY
                })
            end
        end
    end

    FoodObj = Food(possibleFoodPositions[love.math.random(#possibleFoodPositions)])
end
