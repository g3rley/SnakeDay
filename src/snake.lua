-- file: snake.lua
Snake = Object.extend(Object)

--- Constructor of Snake Class
---@param segments table
---@param isAlive boolean
function Snake:new(segments, isAlive)

    self.segments = segments
    self.alive = isAlive
    self.directionQueue = { 'right' }
end

--- Execute event by transitions into frames
---@param dt number
function Snake:update(dt)

    Timer = Timer + dt

    if self.alive then

        if (Timer >= 0.15) then

            Timer = 0

            if #self.directionQueue > 1 then
                table.remove(self.directionQueue, 1)
            end

            local nextXPosition = self.segments[1].x
            local nextYPosition = self.segments[1].y

            if self.directionQueue[1] == 'right' then
                nextXPosition = nextXPosition + 1
                if nextXPosition > GridXCount then
                    nextXPosition = 1
                end
            elseif self.directionQueue[1] == 'left' then
                nextXPosition = nextXPosition - 1
                if nextXPosition < 1 then
                    nextXPosition = GridXCount
                end
            elseif self.directionQueue[1] == 'down' then
                nextYPosition = nextYPosition + 1
                if nextYPosition > GridYCount then
                    nextYPosition = 1
                end
            elseif self.directionQueue[1] == 'up' then
                nextYPosition = nextYPosition - 1
                if nextYPosition < 1 then
                    nextYPosition = GridYCount
                end
            end

            local canMove = true

            for segmentIndex, segment in ipairs(self.segments) do
                if segmentIndex ~= #self.segments
                and nextXPosition == segment.x
                and nextYPosition == segment.y then
                    canMove = false
                end
            end

            if canMove then
                table.insert(self.segments, 1, {
                    x = nextXPosition, y = nextYPosition
                })

                if self.segments[1].x == FoodObj.position.x
                and self.segments[1].y == FoodObj.position.y then
                    EatEffectSong:play()
                    MoveFood()
                else
                    table.remove(self.segments)
                end
            else
                self.alive = false
            end
        end
    elseif Timer >=2 then
        Reset()
    end
end

--- draw elements relationed a snake
function Snake:draw()

    local cellSize = 15

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle("fill", 0, 0, GridXCount * cellSize, GridYCount * cellSize)

    for _, segment in ipairs(self.segments) do
        love.graphics.setColor(.6, 1, .32)
        love.graphics.rectangle(
            "fill",
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end

    love.graphics.setColor(1, .3, .3)
    love.graphics.rectangle(
        'fill',
        (FoodObj.position.x - 1) * cellSize,
        (FoodObj.position.y - 1) * cellSize,
        cellSize - 1,
        cellSize - 1
    )

    for _, segment in ipairs(self.segments) do
        if self.alive then
            love.graphics.setColor(.6, 1, .32)
        else
            love.graphics.setColor(.5, .5, .5)
        end

        DrawCell(segment.x, segment.y, cellSize)
    end

    love.graphics.setColor(1, .3, .3)

    DrawCell(FoodObj.position.x, FoodObj.position.y, cellSize)
end

--- Bind an event when whatever key is pressed
---@param key string
function Snake:keypressed(key)

    if key == 'right'
    and self.directionQueue[#self.directionQueue] ~= 'right'
    and self.directionQueue[#self.directionQueue] ~= 'left' then
        table.insert(self.directionQueue, 'right')
    elseif key == 'left'
    and self.directionQueue[#self.directionQueue] ~= 'left'
    and self.directionQueue[#self.directionQueue] ~= 'right'
    then
        table.insert(self.directionQueue, 'left')
    elseif key == 'down'
    and self.directionQueue[#self.directionQueue] ~= 'down'
    and self.directionQueue[#self.directionQueue] ~= 'up' then
        table.insert(self.directionQueue, 'down')
    elseif key == 'up'
    and self.directionQueue[#self.directionQueue] ~= 'up'
    and self.directionQueue[#self.directionQueue] ~= 'down' then
        table.insert(self.directionQueue, 'up')
    end
end