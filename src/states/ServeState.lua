ServeState = Class {__includes = BaseState}

function ServeState:enter( params )
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score

    self.ball = Ball()
    self.ball.skin = math.random( 7 )
end
function ServeState:update( dt )
    self.paddle.update(dt)
    --place the ball on the paddle
    self.ball.x = self.paddle.x + (self.paddle.width /2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 
        gStateMachine:change('play',{
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            ball = self.ball
        })
    end
    if love.keyboard.wasPressed('escape') then 
        love.event.quit()
    end
end