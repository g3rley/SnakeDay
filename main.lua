--- load the inital snake game setup
function love.load()

    --load external libs and my helpers and classes
    Object = require "libs.classic"
    require "src.support.helpers"
    require "src.snake"
    require "src.food"

    GamingMusic = love.audio.newSource("assets/music/soundtrack.ogg", "stream")
    GamingMusic:setVolume(0.1)
    GamingMusic:setPitch(0.9)
    GamingMusic:play()

    EatEffectSong = love.audio.newSource("assets/effect/eat.wav", "static")

    GridXCount = 20
    GridYCount = 15

    function Reset()

        SnakePlayer = Snake({
            { x = 3, y = 1},
            { x = 2, y = 1},
            { x = 1, y = 1},
        }, true)

        Timer = 0
        MoveFood()
    end

    Reset()
end

--- executes the update tax routines
---@param dt number
function love.update(dt)

    SnakePlayer:update(dt)
end

--- bind the key press event
---@param key any
function love.keypressed(key)

    SnakePlayer:keypressed(key)
end

--- draw elements in the screen
function love.draw()
    SnakePlayer:draw()
end