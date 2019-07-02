--[[
    update 0: Starting out
    update 1: Sprite Sheets (Quads)
    update 2: Adding the ball and bouncing
    update 3: Adding bricks
    update 4: adding more collisions
    update 5: adding hearts
    update 6: updating levelmaker
    update 7: adding tier mechanics
    update 8: adding particle system
    update 9: adding level progression
    update 10: adding high score and file system
]]
require('src/Dependencies')

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Breakout')

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }

    love.graphics.setFont(gFonts['small'])

    gTextures = {
        ['background'] = love.graphics.newImage('images/background.png'),
        ['arrows'] = love.graphics.newImage('images/arrows.png'),
        ['main'] = love.graphics.newImage('images/breakout.png'),
        ['hearts'] = love.graphics.newImage('images/hearts.png'),
        ['particle'] = love.graphics.newImage('images/particle.png'),
        ['ui'] = love.graphics.newImage('images/ui.png'),
        ['blocks'] = love.graphics.newImage('images/blocks.png')
    }

    gFrames = {
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['bricks'] = GenerateQuadsBricks(gTextures['main']),
        ['hearts'] = GenerateQuadsHearts(gTextures['hearts']),
        ['arrows'] = GenerateQuads(gTextures['arrows'], 24, 24)
    }

    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            vsync = true,
            fullscreen = false,
            resizable = true
        }
    )

    gSounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['brick_hit_1'] = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
        ['brick_hit_2'] = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
        ['confirm'] = love.audio.newSource('sounds/confirm.wav', 'static'),
        ['high_score'] = love.audio.newSource('sounds/high_score.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['no_select'] = love.audio.newSource('sounds/no-select.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['recover'] = love.audio.newSource('sounds/recover.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['select'] = love.audio.newSource('sounds/select.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/music.wav', 'static')
    }
    --state machine setup, make sure to add new states here when you make them
    gStateMachine =
        StateMachine {
        ['start'] = function()
            return StartState()
        end,
        ['high_score'] = function()
            return HighScoreState()
        end,
        ['paddle_select'] = function()
            return PaddleSelectState()
        end,
        ['serve'] = function()
            return ServeState()
        end,
        ['play'] = function()
            return PlayState()
        end,
        ['game_over'] = function()
            return GameOverState()
        end,
        ['victory'] = function()
            return VictoryState()
        end,
        ['enter_high_score'] = function()
            return EnterHighScoreState()
        end
    }
    --initialize in start screen
    gStateMachine:change(
        'start',
        {
            highScores = loadHighScores()
        }
    )
    gSounds['music']:play()
    gSounds['music']:setVolume(0.5)
    gSounds['music']:setLooping(true)
    --table used to keep track of key presses
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)
    
    --reset keys pressed
    love.keyboard.keysPressed = {}
end
--handle keyboard input approprietly
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()

    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(
        gTextures['background'],
        0,
        0, --draw at top corner
        0, --no rotation
        VIRTUAL_WIDTH / (backgroundWidth - 1),
        VIRTUAL_HEIGHT / (backgroundHeight - 1) --scaling
    )

    gStateMachine:render()

    push:finish()
end

function displayFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

function renderHealth(health)
    local healthX = VIRTUAL_WIDTH - 50
    for i = 1, health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 14)
        healthX = healthX + 11
    end
    for i = 1, 3 - health do
        love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX, 14)
        healthX = healthX + 11
    end
end

function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end

function loadHighScores()
    love.filesystem.setIdentity('breakout.lst', true)
    --check if file exists
    if not love.filesystem.exists('breakout.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'JPL\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('breakout.lst', scores)
    end
    local name = true
    local currentName = nil
    local counter = 1

    local scores = {}

    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    for line in love.filesystem.lines('breakout.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end
        --flip name flag
        name = not name
    end

    return scores
end
