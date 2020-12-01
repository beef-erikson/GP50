--[[
    Flappy Bird Clone
    Lua Build for Love2d

    FlappyBird-5
    "The Infinite Pipe Update"
    - Pipes now infinitely spawn from the right
    - Destroys pipes when leaving screen on left

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

-- push library for using Virual screen
push = require('push')

Class = require('class')

require 'Bird'
require 'Pipe'

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
local pipes = {}

-- timer support for pipe spawning
local spawnTimer = 0

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
        table.insert(pipes,Pipe())
        spawnTimer = 0
    end

    bird:update(dt)

    -- for each pipe, update and destroy
    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
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
    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    -- draws ground
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- draws the bird
    bird:render()

    -- stops push render
    push:finish()
end