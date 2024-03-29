PaddleSelectState = Class {__includes = BaseState}

function PaddleSelectState:enter(params)
    self.highScores = params.highScores
end

function PaddleSelectState:init()
    -- the paddle we're highlighting; will be passed to the ServeState
    -- when we press Enter
    self.currentPaddle = 1
end

function PaddleSelectState:update(dt)
    if paddy.isDown('left') then
        if self.currentPaddle == 1 then
            gSounds['no_select']:play()
        else
            gSounds['select']:play()
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif paddy.isDown('right') then
        if self.currentPaddle == 16 then
            gSounds['no_select']:play()
        else
            gSounds['select']:play()
            self.currentPaddle = self.currentPaddle + 1
        end
    end

    -- select paddle and move on to the serve state, passing in the selection
    if paddy.isDown('a') then
        gSounds['confirm']:play()

        local handicap = (self.currentPaddle - 1) % 4
        if handicap == 0 then
            PADDLE_HANDICAP = 8
        elseif handicap == 1 then
            PADDLE_HANDICAP = 4
        elseif handicap == 2 then
            PADDLE_HANDICAP = 2
        else
            PADDLE_HANDICAP = 1
        end

        gStateMachine:change(
            'serve',
            {
                paddle = Paddle(self.currentPaddle),
                bricks = LevelMaker.createMap(1),
                health = 3,
                score = 0,
                highScores = self.highScores,
                level = 1
            }
        )
    end

    if paddy.isDown('b') then
        love.event.quit()
    end
end

function PaddleSelectState:render()
    -- instructions
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select your paddle with left and right!', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('(Press Enter to continue!)', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    -- left arrow; should render normally if we're higher than 1, else
    -- in a shadowy form to let us know we're as far left as we can go
    if self.currentPaddle == 1 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40 / 255, 40 / 255, 40 / 255, 128 / 255)
    end

    love.graphics.draw(
        gTextures['arrows'],
        gFrames['arrows'][1],
        VIRTUAL_WIDTH / 4 - 24,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )

    -- reset drawing color to full white for proper rendering
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    -- right arrow; should render normally if we're less than 4, else
    -- in a shadowy form to let us know we're as far right as we can go
    if self.currentPaddle == 16 then
        -- tint; give it a dark gray with half opacity
        love.graphics.setColor(40 / 255, 40 / 255, 40 / 255, 128 / 255)
    end

    love.graphics.draw(
        gTextures['arrows'],
        gFrames['arrows'][2],
        VIRTUAL_WIDTH - VIRTUAL_WIDTH / 4,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )

    -- reset drawing color to full white for proper rendering
    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    -- draw the paddle itself, based on which we have selected
    love.graphics.draw(
        gTextures['main'],
        gFrames['paddles'][(self.currentPaddle)],
        VIRTUAL_WIDTH / 2 - ((((self.currentPaddle - 1) % 4) + 1) * 16),
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3
    )
end
