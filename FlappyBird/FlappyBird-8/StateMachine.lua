--[[
    Flappy Bird Clone
    Lua Build for Love2d

    State Machine controller - defers to other state classes
    based on current state

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

StateMachine = Class{}

-- defines empty class and sets it to current
-- sets states from variable states if present or empty table
function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }
    self.states = states or {}
    self.current = self.empty
end

-- changes state to the given statename, frees old state, and
-- passes enterParams to new state
function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

-- passes update to current state
function StateMachine:update(dt)
    self.current:update(dt)
end

-- passes render to current state
function StateMachine:render()
    self.current:render()
end