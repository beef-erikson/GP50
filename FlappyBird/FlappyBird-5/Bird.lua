--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Bird class for player

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Bird = Class{}

local GRAVITY = 20
local ANTI_GRAVITY = 5

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
    -- apply gravity to velocity
    self.dy = self.dy + GRAVITY * dt

    -- jumps
    if love.keyboard.wasPressed('space') then
        self.dy = -ANTI_GRAVITY
    end

    -- applies velocity to y value
    self.y = self.y + self.dy
end

--[[
    Render Bird
]]
function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end