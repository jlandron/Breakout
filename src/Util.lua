-- utility function that allows a sprite sheet to be split into seperate images (quads)

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(
                x * tileWidth,
                y * tileheight,
                tilewidth,
                tileheight,
                atlas:getWidth(),
                atlas:getHeight()
            )
            sheetCounter = sheetCounter + 1
        end
    end
    return spritesheet
end

-- utility funtion for slicing tables
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[1]
    end
    return sliced
end

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
        --medium
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        --large
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1
        --huge
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getWidth(), atlas:getHeight())
        counter = counter + 1

        --set x and y for next set
        x = 0
        y = y + 32
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
