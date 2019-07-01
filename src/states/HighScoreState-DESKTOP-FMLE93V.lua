HighScoreState = Class {__includes = BaseState}

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start') {}
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('HighScores', 0, 0, VIRTUAL_WIDTH, 'center')
end
