--[[
    Simple Pong clone
    Lua Build for Love2d

    Pong-11
    "The Audio Update"
    - Sfx added for paddle hits, wall hits, and scoring

    Author: Troy Martin
    beef.erikson.studios@gmail.com
]]


-- push is a library that allows drawing at a virtual resolution
-- instead of however large our window is; used for a more retro
-- aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

-- class library used for OOP
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- Paddle class for various paddle operations
require 'Paddle'

-- Ball class for various ball operations
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 780

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

-- debug mode for restarting love / displaying FPS
DEBUG_MODE = true


--[[
    Initialize beginning game state
    Runs when game starts, only once.
]]
function love.load()
    -- use nearest-neighbor filtering for a retro aestetic
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set title of game
    love.window.setTitle('Pong')

    -- sets random seed based on os time
    math.randomseed(os.time())

    -- custom font objects for text
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- sound effects
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
    -- screen setup
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- initialize score variables
    player1Score = 0
    player2Score = 0

    -- determines who is serving
    servingPlayer = math.random(2)

    -- initialize paddles and ball
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

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
        -- start serve
        if gameState == 'start' then
            gameState = 'serve'
        -- start play
        elseif gameState == 'serve' then
            gameState = 'play'
        -- game done, reset all and start serve
        elseif gameState == 'done' then
            gameState = 'serve'

            ball:reset()

            player1Score = 0
            player2Score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

--[[
    Called each frame with deltatime - logic changes
]]
function love.update(dt)
    -- initial serve of ball
    if gameState == 'serve' then
        ball.dy = math.random(-50, 50)
        if servingPlayer == 1 then
            ball.dx = math.random(140, 200)
        else
            ball.dx = -math.random(140, 200)
        end
    elseif gameState == 'play' then
        -- detects collision with ball, if true reverses dx and
        -- increases, then alters dy based on position hit
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()
        end

        -- detect upper and lower screen boundary collision and reverse if true
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy

            sounds['wall_hit']:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy

            sounds['wall_hit']:play()
        end

        -- if left or right edge of screen, reset and update score
        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            sounds['score']:play()

            -- If score of ten is reached, game is over
            if player2Score == 10 then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            sounds['score']:play()

            -- If score of ten is reached, game is over
            if player1Score == 10 then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end
    end

    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end


    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

--[[
    Called each frame after update to draw to screen
]]
function love.draw()
    -- begin rendering at virtual resolution
    push:start()

    -- clears the screen with a set color
    love.graphics.clear(40/255, 45/255, 52/255)

    -- text at top of screen
    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')

    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!",
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play'then
        -- No UI messages
    end

    -- score display
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score),
        VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score),
        VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    -- renders paddles
    player1:render()
    player2:render()

    -- renders ball
    ball:render()

    -- diplays current frame rate
    if DEBUG_MODE then
        displayFPS()
    end

    -- end rendering of virtual resolution
    push:finish()
end

--[[
    Renders the current FPS
]]
function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end