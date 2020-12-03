--[[
    Flappy Bird Clone
    Lua Build for Love2d

    ScoreState for state passed from StateMachine
    Defines behavior for scoring / drawing of score

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

ScoreState = Class{__includes = BaseState}

--[[
    Score gets passed in from PlayState and added here to be drawn
]]
function ScoreState:enter(params)
    self.score = params.score
end

--[[
    Goes back to play state if enter is pressed
]]
function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

--[[
    Renders score to the middle of the screen
]]
function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end