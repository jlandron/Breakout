--[[
    TitleScreenState class

    the title screen state is the games start screen
    displays press enter to start and highest score so far
]]
TitleScreenState = Class {__includes = BaseState}

function TitleScreenState:enter(enterParams)
end
function TitleScreenState:exit()
end

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("countdown")
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Funny Bird", 0, 64, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Enter to start", 0, 100, VIRTUAL_WIDTH, "center")
end
