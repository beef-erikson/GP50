--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Pong-0
    "The Day-0 Update"
    Setting up initial state of game

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

-- push library for using Virual screen
push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- graphics files
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')


--[[
    Load function loads exactly once at beginning of execution
]]
function love.load()
    -- filter for retro aesthetic
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy Bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fulscreen = false,
        resizable = true
    })
end

--[[
    On resize, send width and heigh to push
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Keybindings

    escape - quit
    r - restart love
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'r' then
        love.event.quit('restart')
    end
end

--[[
    Renders the screen
]]
function love.draw()
    -- starts push render
    push:start()

    -- draws background and ground
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, VIRTUAL_HEIGHT - 16)
    -- stops push render
    push:finish()
end