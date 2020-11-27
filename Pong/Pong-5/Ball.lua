--[[
    Ball class for handling the ball in Pong

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Ball = Class{}

--[[
    Initializes ball with given parameters
]]
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- Velocity of the ball
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Places ball in middle of screen with random initial velocity
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Applies velocity to the ball
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

--[[
    Renders the ball
]]
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end