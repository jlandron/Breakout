VictoryState = Class {__includes = BaseState}
function VictoryState:enter(params)
    self.score = params.score
    self.level = params.level
    self.paddle = params.paddle
    self.health = params.health
    self.ball = params.ball
end
function VictoryState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change(
            'serve',
            {
                paddle = self.paddle,
                bricks = LevelMaker.createMap(self.level + 1),
                health = self.health < 3 and self.health + 1 or 3,
                score = self.score,
                level = self.level + 1,
                ball = self.ball
            }
        )
    end
end
function VictoryState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. self.level .. ' complete', 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your score so far is: ' .. self.score, 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press enter to play the next level', 0, VIRTUAL_HEIGHT / 2 + 50, VIRTUAL_WIDTH, 'center')
end
