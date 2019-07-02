GameOverState = Class {__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end
function GameOverState:update(dt)
    if paddy.isDown('a') then
        local highScore = false

        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gSounds['high_score']:play()
            gStateMachine:change(
                'enter_high_score',
                {
                    highScores = self.highScores,
                    score = self.score,
                    scoreIndex = highScoreIndex
                }
            )
        else
            gStateMachine:change(
                'start',
                {
                    highScores = self.highScores
                }
            )
        end
    end

    if paddy.isDown('b') then
        love.event.quit()
    end
end
function GameOverState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(
        'Final Score: ' .. tostring(self.score),
        0,
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH,
        'center'
    )
    love.graphics.printf('Press Enter to Continue', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
end
