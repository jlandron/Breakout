Ball = Class {}

function Ball:init(skin)
    --ball size
    self.width = 8
    self.height = 8

    --ball velocity
    self.dx = 0
    self.dy = 0

    --look of the ball
    self.skin = skin
end
--AABB collision detection
function Ball:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    return true
end
--reset the ball to the paddle
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    --bounce off left side
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    --bounce off right side
    if self.x >= VIRTUAL_WIDTH - self.width then
        self.x = VIRTUAL_WIDTH - self.width
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    --bounce off top
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds['wall_hit']:play()
    end
end

function Ball:render()
    -- draw the ball object on the screen
    love.graphics.draw(gTextures['main'], gFrames['balls'][self.skin], self.x, self.y)
end

