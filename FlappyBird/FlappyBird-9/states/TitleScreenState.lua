--[[
    Flappy Bird Clone
    Lua Build for Love2d

    TitleScreenState for state passed from StateMachine
    Defines behavior and updates/rendering

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

TitleScreenState = Class{__includes = BaseState}

-- if return is hit, change state to play
function TitleScreenState:update(dt)
    if love.keyboard.wasPressed(dt) or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

-- render text for title screen
function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end
