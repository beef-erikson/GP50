--[[
    Flappy Bird Clone
    Lua Build for Love2d

    Bird class

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

Bird = Class{}


--[[
    Initialize Bird
]]
function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
end

--[[
    Render Bird
]]
function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end