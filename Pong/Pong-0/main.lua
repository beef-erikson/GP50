--[[
    Pong-0
    "The Day-0 Update"
    Setting up initial state of game

    Author: Troy Martin
    beef.erikson.studios@gmail.com

    Simple Pong clone
    Lua Build for Love2d
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 780
DEBUG_MODE = true

--[[
    Initialize beginning game state
    Runs when game starts, only once.
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called each frame with deltatime - logic changes
]]
function love.update(dt)

end

--[[
    Called each frame after update to draw to screen
]]
function love.draw()
    love.graphics.printf(
        'Hello Pong!',              -- Text to render
        0,                          -- Starting x
        WINDOW_HEIGHT / 2 - 6,      -- Starting y (centered, default font 12px)
        WINDOW_WIDTH,               -- Pixels to align (full)
        'center'                    -- Alignment
    )
end