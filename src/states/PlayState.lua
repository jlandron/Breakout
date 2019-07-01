PlayState = Class {__includes = BaseSate}

function PlayState:init()
    self.paddle = Paddle()
    self.paused = false
end

function PlayState:update(dt)
    -- check if paused and allow paused
    if self.paused then
        if love.keyboard.wasPressed("space") then
            self.paused = false
            gSounds["pause"]:play()
        else
            return
        end
    elseif love.keyboard.wasPressed("space") then
        self.paused = true
        gSounds["pause"]:play()
        return
    end

    self.paddle:update(dt)

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState:render()
    -- body
    self.paddle:render()

    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 14, VIRTUAL_WIDTH / 2 - 14)
    end
end
