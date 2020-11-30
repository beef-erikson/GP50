--[[
    Flappy Bird Clone
    Lua Build for Love2d

    FlappyBird-3
    "The Gravity Update"
    - Introduces gravity to the bird

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

-- push library for using Virual screen
push = require('push')

Class = require('class')

require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- speeds for parallax scrolling and looping point
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

-- graphics files and parallax support
local background = love.graphics.newImage('background.png')
local backgrondScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local bird = Bird()

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
    Update is called once per frame, used for logic
]]
function love.update(dt)
    -- parallax scrolling
    backgrondScroll = (backgrondScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH
    
    bird:update(dt)
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
    love.graphics.draw(background, -backgrondScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- draws the bird
    bird:render()

    -- stops push render
    push:finish()
end