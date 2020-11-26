--[[
    Simple Pong clone
    Lua Build for Love2d

    Pong-4
    "The ball Update"
    - Ball movement added
    - Clamping added for paddles
    - Game state support

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]


-- push is a library that allows drawing at a virtual resolution
-- instead of however large our window is; used for a more retro
-- aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 780

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- debug mode for restarting love
DEBUG_MODE = true


--[[
    Initialize beginning game state
    Runs when game starts, only once.
]]
function love.load()
    -- use nearest-neighbor filtering for a retro aestetic
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- sets random seed based on os time
    math.randomseed(os.time())

    -- custom font object for text
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- larger font for score keeping
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- screen setup
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize score variables
    player1Score = 0
    player2Score = 0

    -- paddle positions on the Y axis
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    -- velocity and position variables for ball when play starts
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- game state for switching between beginning, menus, main game, etc
    gameState = 'start'
end

--[[
    Keyboard handling, called each frame
    Restart with r key if debug enabled
    Escape key exits game
]]
function love.keypressed(key)
    -- quit game
    if key == 'escape' then
        love.event.quit()

    -- restart love for debugging
    elseif key == 'r' and DEBUG_MODE == true then
        love.event.quit('restart')

    -- starts ball movement
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- resets ball to middle of screen
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            -- resets ball velocity
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

--[[
    Called each frame with deltatime - logic changes
]]
function love.update(dt)
    -- player 1 movement
    if love.keyboard.isDown('w') then
        -- add negative paddle speed (up)
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- add positive paddle speed (down)
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        -- add negative paddle speed (up)
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- add positive paddle speed (down)
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    -- ball movement if in play state
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

--[[
    Called each frame after update to draw to screen
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:start()

    -- clears the screen with a set color
    love.graphics.clear(40/255, 45/255, 52/255)

    -- welcome text at top of screen
    love.graphics.setFont(smallFont)
    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end
    -- score display
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    --[[
        Paddles and ball
    ]]
    -- renders paddle (left side)
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- renderes second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 14, player2Y, 5, 20)

    -- renders ball
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    -- end rendering of virtual resolution
    push:finish()
end