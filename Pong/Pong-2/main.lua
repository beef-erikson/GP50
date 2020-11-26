--[[
    Simple Pong clone
    Lua Build for Love2d

    Pong-2
    "The Rectangle Update"
    - Arial font added for text
    - Paddles and ball added

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

    -- custom font object
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- sets active font to smallFont object
    love.graphics.setFont(smallFont)

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

    -- Clears the screen with a set color
    love.graphics.clear(40/255, 45/255, 52/255)

    love.graphics.printf(
        'Hello Pong!',              -- Text to render
        0,                          -- Starting x
        20,                         -- Starting y (towards top)
        VIRTUAL_WIDTH,              -- Pixels to align (full)
        'center'                    -- Alignment
    )

    --[[
        Paddles and ball
    ]]
    -- first paddle (left side)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 14, VIRTUAL_HEIGHT - 50, 5, 20)

    -- ball (center)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- End rendering of virtual resolution
    push:finish()
end