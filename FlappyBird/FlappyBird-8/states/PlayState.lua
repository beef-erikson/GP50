--[[
    Flappy Bird Clone
    Lua Build for Love2d

    PlayState for state passed from StateMachine
    Defines behavior and updates/rendering

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

-- initialize properties
function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0

    -- pipe gap
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

-- Called once per frame, handles logic
function PlayState:update(dt)
    -- updates pipe spawning timer
    self.timer = self.timer + dt

    -- spawn new pipe every 2 seconds
    if self.timer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10,
            math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        -- add new pipes to pipePairs
        table.insert(self.pipePairs, PipePair(y))

        -- reset timer
        self.timer = 0
    end

    -- for every pair of pipes
    for k, pair in pairs(self.pipePairs) do
        -- updates position of pair
        pair:update(dt)
    end

    -- second loop to avoid table removal issues in first loop
    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- update bird based on input/gravity
    self.bird:update(dt)

    -- collision detection using AABB
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('title')
            end
        end
    end

    -- reset if bird hits ground
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('title')
    end
end

-- draws to screen
function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()
end