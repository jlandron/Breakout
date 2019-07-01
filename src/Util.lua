-- method specifically made to get the paddles from the sprite sheet,
-- each paddle might be differet sizes, so they must be made seperatly
function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    -- iterate over each set of paddles
    for i = 0, 3 do
        --small
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        x = x + 32
        --medium
        quads[counter] = love.graphics.newQuad(x, y, 64, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        x = x + 64
        --large
        quads[counter] = love.graphics.newQuad(x, y, 96, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        x = 0
        y = y + 16
        --huge
        quads[counter] = love.graphics.newQuad(x, y, 128, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        --set x and y for next set
        x = 0
        y = y + 16
    end
    return quads
end

function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getWidth(), atlas:getHeight())
        x = x + 8
        counter = counter + 1
    end

    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getWidth(), atlas:getHeight())
        x = x + 8
        counter = counter + 1
    end

    return quads
end
function GenerateQuadsBricks(atlas)
    local x = 0
    local y = 0
    local counter = 1
    local quads = {}
    for row = 0, 3 do
        for i = 0, 5 do
            quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getWidth(), atlas:getHeight())
            x = x + 16
            counter = counter + 1
        end
        y = y + 16
    end
    return quads
end

function GenerateQuadsHearts(atlas)
    local quads = {}
    quads[1] = love.graphics.newQuad(0, 0, 10, 10, atlas:getWidth(), atlas:getHeight())
    quads[2] = love.graphics.newQuad(10, 0, 10, 10, atlas:getWidth(), atlas:getHeight())
    return quads
end
