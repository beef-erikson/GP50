--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Class file for Pipe

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Pipe = Class{}

-- reference pipe image rather than load every insantiation
local PIPE_IMAGE = love.graphics.newImage('pipe.png')

-- pipe scrolling speed
PIPE_SPEED = 60

-- pipe width and height
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

--[[
    Initializing pipe with some default values
]]
function Pipe:init(orientation, y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation
end

--[[
    Pipe moving done in PipePair
]]
function Pipe:update(dt)

end

--[[
    Draws the pipes
]]
function Pipe:render()
    love.graphics.draw(PIPE_IMAGE, self.x,
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
        0,      -- rotation
        1,      -- X scale
        self.orientation == 'top' and -1 or 1)      -- Y scale
end