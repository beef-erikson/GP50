--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Class file for Pipe pairs (both top and bottom pipes)

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

PipePair = Class{}

-- size of gap between pipes
local GAP_HEIGHT = 90

--[[
    Initialization for pipes
]]
function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y

    -- instantiate two pipes at top, bottom of screen
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    -- sets whether ready for deletion
    self.remove = false
end

--[[
    Update function, called every frame
]]
function PipePair:update(dt)
    -- removes pipe if gone from screen
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

--[[
    Draws all pipes to screen
]]
function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end