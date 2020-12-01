--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Class file for Pipes

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Pipe = Class{}

-- Reference pipe image rather than load every insantiation
local PIPE_IMAGE = love.graphics.newImage('pipe.png')

-- Scroll speed of pipes
local PIPE_SCROLL = -60

--[[
    Initializing pipe with some default values
]]
function Pipe:init()
    self.x = VIRTUAL_WIDTH
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 50)

    self.width = PIPE_IMAGE:getWidth()
end

--[[
    Moves pipe every frame
]]
function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

--[[
    Draws the pipes
]]
function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x, self.y)
end