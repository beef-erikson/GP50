--[[
    Flappy Bird Clone
    Lua Build for Love2d

    FlappyBird-9
    "The Score Update"
    -- ScoreState added and scoring now implemented

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

-- State machine support
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'

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


--[[
    Load function loads exactly once at beginning of execution
]]
function love.load()
    -- filter for retro aesthetic
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy Bird')

    -- fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fulscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

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
    -- scrolling of background/ground
    backgrondScroll = (backgrondScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT

    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

    -- updates state machine
    gStateMachine:update(dt)

    -- resets keys table
    love.keyboard.keysPressed = {}
end

--[[
    Renders the screen
]]
function love.draw()
    -- starts push render
    push:start()

    -- draws background and state machine renders
    love.graphics.draw(background, -backgrondScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- stops push render
    push:finish()
end