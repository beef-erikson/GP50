--[[
    Flappy Bird Clone
    Lua Build for Love2d

    CountDownState for state passed from StateMachine
    Counts down from 3 on game start

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

CountDownState = Class{__includes = BaseState}

-- takes a second to count down each time
COUNTDOWN_TIME = 0.75

--[[
    Initialize starting properties
]]
function CountDownState:init()
    self.count = 3
    self.timer = 0
end

--[[
    Handles countdown from 3 and changes to playst
]]
function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

--[[
    Renders countdown
]]
function CountDownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end