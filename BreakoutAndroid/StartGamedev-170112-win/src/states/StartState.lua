StartState = Class {__includes = BaseState}

local highlighted = 1

function StartState:enter(params)
    self.highScores = params.highScores
end
function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if paddy.isDown('up') or paddy.isDown('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle_hit']:play()
    end

    -- confirm whichever option we have selected to change screens
    if paddy.isDown('a') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change(
                'paddle_select',
                {
                    highScores = self.highScores
                }
            )
        else
            gStateMachine:change(
                'high_score',
                {
                    highScores = self.highScores
                }
            )
        end
    end

    -- we no longer have this globally, so include here
    if paddy.isDown('b') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('BREAKOUT', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    --instructions
    love.graphics.setFont(gFonts['medium'])

    --render chosen option blue
    if highlighted == 1 then --option 1
        love.graphics.setColor(103 / 255, 255 / 255, 255 / 255, 255 / 255)
    end
    love.graphics.printf('START', 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    if highlighted == 2 then --option 2
        love.graphics.setColor(103 / 255, 255 / 255, 255 / 255, 255 / 255)
    end
    love.graphics.printf('HIGH SCORES', 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][1], 10, 16)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][2], 10, 32)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][3], 10, 48)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][4], 10, 64)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][5], 10, 80)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][6], 10, 96)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][7], 10, 112)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][8], 10, 128)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][9], 10, 144)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][10], 10, 160)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][11], 10, 176)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][12], 10, 192)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][13], 10, 208)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][14], 10, 224)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][15], 10, 240)
    -- love.graphics.draw(gTextures['main'], gFrames['bricks'][16], 10, 256)

    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][1], 10, 128)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][2], 10, 144)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][3], 10, 160)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][4], 10, 176)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][5], 10, 192)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][6], 10, 208)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][7], 10, 224)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][8], 10, 240)
    -- love.graphics.draw(gTextures['main'], gFrames['paddles'][9], 10, 256)
end
