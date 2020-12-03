--[[
    Flappy Bird Clone
    Lua Build for Love2d

    BaseState for state passed from StateMachine
    Defines behavior and updates/rendering

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

BaseState = Class{}

function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end