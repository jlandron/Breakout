LevelMaker = Class {}

function LevelMaker.createMap(level)
    local bricks = {}
    --randomly choose number fo rows
    local numRows = math.random(1, 5)
    --randomly choose number of columns
    local numCols = math.random(7, 13)

    --lay out bricks so they all touch
    for y = 1, numRows do
        for x = 1, numCols do
            b = Brick((x - 1) * 32 + 8 + (15 - numCols) * 16, y * 16)
            table.insert(bricks, b)
        end
    end
    return bricks
end
