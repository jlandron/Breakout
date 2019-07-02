Paddle = Class {}

function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH / 2 - 32

    self.y = VIRTUAL_HEIGHT - 32

    self.dx = 0

    self.width = (((skin - 1) % 4) + 1) * 32

    self.height = 16

    self.skin = skin
end

function Paddle:update(dt)
    if (love.keyboard.isDown('left')) then
        self.dx = -PADDLE_SPEED
    elseif (love.keyboard.isDown('right')) then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    --clamp input to left and right of screen
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.skin], self.x, self.y)
end
