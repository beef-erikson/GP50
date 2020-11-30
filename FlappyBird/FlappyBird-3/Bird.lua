--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Bird class

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Bird = Class{}

local GRAVITY = 20

--[[
    Initialize Bird
]]
function Bird:init()
    -- load bird image and set width/height
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- positions bird in middle of screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- velocity
    self.dy = 0
end

--[[
    Update function for implementing gravity, called every frame
]]
function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    self.y = self.y + self.dy
end

--[[
    Render Bird
]]
function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end