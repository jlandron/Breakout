PlayState = Class {__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    --random skin
    self.ball = Ball(love.math.random(7))
    --random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
    --position it in the center
    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.bricks = LevelMaker.createMap()
    --set initial state to play
    self.paused = false
    self.timer = 0
end
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.paused = false
    self.timer = 0
end
function PlayState:update(dt)
    --increment speed timer for state, update speed each time it reaches a certain number
    self.timer = self.timer + 1
    if self.timer >= 60 then
        self.timer = 0
        --check which direction the ball is moving and add 1 that direction
        if self.ball.dy < 0 then
            self.ball.dy = self.ball.dy - 1
        else
            self.ball.dy = self.ball.dy + 1
        end
        if self.ball.dx < 0 then
            self.ball.dx = self.ball.dx - 1
        else
            self.ball.dx = self.ball.dx + 1
        end
    end
    -- check if paused and allow paused
    if self.paused then
        if love.keyboard.wasPressed('tab') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('tab') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    --check if ball hits paddle, send upward if yes
    if self.ball:collides(self.paddle) then
        self.ball.y = self.ball.y - 8
        self.ball.dy = -self.ball.dy

        --change angle of bounce based on hit location and movement of paddle
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end
        gSounds['paddle_hit']:play()
    end

    for k, brick in pairs(self.bricks) do
        --only check collision for active bricks
        if brick.inPlay and self.ball:collides(brick) then
            self.score = self.score + 10
            --trigger bricks hit method and change ball direction
            brick:hit()

            --do collision and direction checks for brick/ball interactions
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - self.ball.width
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + self.ball.width * 4
            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - self.ball.height
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + self.ball.height * 2
            end
            break
        end
    end
    --if ball goes below bounds, go to serve state
    if self.ball.y >= VIRTUAL_HEIGHT then
        self.health = self.health - 1
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change(
                'game_over',
                {
                    score = self.score
                }
            )
        else
            gStateMachine:change(
                'serve',
                {
                    paddle = self.paddle,
                    bricks = self.bricks,
                    health = self.health,
                    score = self.score
                }
            )
        end
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- body of render
    for k, brick in pairs(self.bricks) do
        brick:render()
    end
    self.paddle:render()
    self.ball:render()

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT / 2 - 14, VIRTUAL_WIDTH / 2 - 14)
    end
end
