--[[
    Simple Pong clone
    Lua Build for Love2d

    Pong-1
    "The Day-1 Update"
    - Debug mode added for restarting Love2d - r key
    - Escape key quits game
    - push added for retro aesthetic
    - load() changed to use push's setupScreen
    - draw() changed for loading/unloading push rendering

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]


-- push is a library that allows drawing at a virtual resolution
-- instead of however large our window is; used for a more retro
-- aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 780

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Debug mode for restarting love
DEBUG_MODE = true


--[[
    Initialize beginning game state
    Runs when game starts, only once.
]]
function love.load()
    -- use nearest-neighbor filtering for a retro aestetic
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Keyboard handling, called each frame
    Restart with r key if debug enabled
    Escape key exits game
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'r' and DEBUG_MODE == true then
        love.event.quit('restart')
    end
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
    -- Begin rendering at virtual resolution
    push:start()

    love.graphics.printf(
        'Hello Pong!',              -- Text to render
        0,                          -- Starting x
        VIRTUAL_HEIGHT / 2 - 6,      -- Starting y (centered, default font 12px)
        VIRTUAL_WIDTH,               -- Pixels to align (full)
        'center'                    -- Alignment
    )

    -- End rendering of virtual resolution
    push:finish()
end