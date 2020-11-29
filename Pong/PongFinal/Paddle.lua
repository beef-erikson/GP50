--[[
    Paddle class for handling the paddles in Pong

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Paddle = Class{}

--[[
    Initializes paddle with given parameters
]]
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.middleY = 0

    -- Velocity of the paddle
    self.dy = 0
end

--[[
    Clamps the paddle to the window
]]
function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end

    self.middleY = self.y + self.height / 2
end

--[[
    Renders the ball
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end