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
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end
--[[
    This function is specifically made to piece out the bricks from the
    sprite sheet. Since the sprite sheet has non-uniform sprites within,
    we have to return a subset of GenerateQuads.
]]
function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
end

function GenerateQuadsHearts(atlas)
    local quads = {}
    quads[1] = love.graphics.newQuad(0, 0, 10, 10, atlas:getWidth(), atlas:getHeight())
    quads[2] = love.graphics.newQuad(10, 0, 10, 10, atlas:getWidth(), atlas:getHeight())
    return quads
end
