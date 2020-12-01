--[[
    Flappy Bird Clone
    Lua Build for Love2d

    FlappyBird-6
    "The PipePair Update"
    - Pipes now also spawn upside-down

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

-- push library for using Virual screen
push = require('push')

-- class library for making classes
Class = require('class')

require 'Bird'
require 'Pipe'
require 'PipePair'

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

-- seed for random
math.randomseed(os.time())

-- assign classes
local bird = Bird()
local pipePairs = {}

-- timer support for pipe spawning
local spawnTimer = 0

-- Y value for gap in between pipes
local lastY = -PIPE_HEIGHT + math.random(80) + 20
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

    -- empty table for keyboard inputs
    love.keyboard.keysPressed = {}
end

--[[
    On resize, send width and height to push
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Keybindings

    escape - quit
    r - restart love
    space - jumps (in Bird.lua)
]]
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    elseif key == 'r' then
        love.event.quit('restart')
    end
end

--[[
    wasPressed checks whether key was hit or not
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
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

    -- spawn pipe if over 2 seconds
    spawnTimer = spawnTimer + dt
    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y

        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end

    bird:update(dt)

    -- for each pipe pair, update and destroy
    for k, pair in pairs(pipePairs) do
        pair:update(dt)
    end

    -- remove any pipes that have left the screen
    for k, pair in pairs(pipePairs) do
        if pair.remove then
            table.remove(pipePairs, k)
        end
    end

    -- resets keys table
    love.keyboard.keysPressed = {}
end

--[[
    Renders the screen
]]
function love.draw()
    -- starts push render
    push:start()

    -- draws background
    love.graphics.draw(background, -backgrondScroll, 0)

    -- draws pipes
    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    -- draws ground
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- draws the bird
    bird:render()

    -- stops push render
    push:finish()
end