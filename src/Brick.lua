Brick = Class {}

particleColors = {
    --blue
    [1] = {
        ['r'] = 99 / 255,
        ['g'] = 155 / 255,
        ['b'] = 255 / 255
    },
    --green
    [2] = {
        ['r'] = 106 / 255,
        ['g'] = 190 / 255,
        ['b'] = 47 / 255
    },
    --red
    [3] = {
        ['r'] = 217 / 255,
        ['g'] = 87 / 255,
        ['b'] = 99 / 255
    },
    --purple
    [4] = {
        ['r'] = 215 / 255,
        ['g'] = 123 / 255,
        ['b'] = 186 / 255
    },
    --gold
    [5] = {
        ['r'] = 251 / 255,
        ['g'] = 242 / 255,
        ['b'] = 54 / 255
    }
}

function Brick:init(x, y)
    self.tier = 0
    self.color = 1

    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    self.inPlay = true
    --start particle system

    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)

    self.psystem:setParticleLifetime(0.5, 1)

    self.psystem:setLinearAcceleration(-80, -80, 80, 80)

    self.psystem:setSpread(100)
end
function Brick:hit()
    --if bricks are being hit fast, sto pthe last sound and start the next sound
    self.psystem:setColors(
        particleColors[self.color].r,
        particleColors[self.color].g,
        particleColors[self.color].b,
        (55 * (self.tier + 1)) / 100,
        particleColors[self.color].r,
        particleColors[self.color].g,
        particleColors[self.color].b,
        0
    )
    self.psystem:emit(64)

    gSounds['brick_hit_2']:stop()
    gSounds['brick_hit_2']:play()

    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end
end
function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['bricks'][((self.color) * 4) + self.tier], self.x, self.y)
    end
end
--methods just for particle system
function Brick:update(dt)
    self.psystem:update(dt)
end
function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end
