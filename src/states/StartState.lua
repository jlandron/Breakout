StartState = Class {__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed("up") or love.keyboard.wasPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
        gSounds["paddle_hit"]:play()
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")

    --instructions
    love.graphics.setFont(gFonts["medium"])

    --render chosen option blue
    if highlighted == 1 then --option 1
        love.graphics.setColor(103 / 255, 255 / 255, 255 / 255, 255 / 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, "center")

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)

    if highlighted == 2 then --option 2
        love.graphics.setColor(103 / 255, 255 / 255, 255 / 255, 255 / 255)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, "center")

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
end
