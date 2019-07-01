--global variables
--shapes
NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

--patterns per row
SOLID = 1 --all colors are the same in a row
ALTERNATE = 2 --alternate colors
SKIP = 3 --skip every other block
NONE = 4 --empty row

LevelMaker = Class {}

function LevelMaker.createMap(level)
    local bricks = {}
    --randomly choose number fo rows
    local numRows = math.random(1, 5)
    --randomly choose number of columns
    local numCols = math.random(7, 13)
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    local highestTier = math.min(3, math.floor(level / 5))
    local highestColor = math.min(5, level % 5 + 3)

    --lay out bricks so they all touch
    for y = 1, numRows do
        --enable skipping?
        local skipPattern = math.random(1, 2) == 1 and true or false
        --enable alternating colors?
        local alternatePatter = math.random(1, 2) == 1 and true or false

        --choose two colors
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        --used to choose which blocks to skip
        local skipFlag = math.random(2) == 1 and true or false
        --used to choose when to alternate colors
        local alternateFlag = math.random(2) == 1 and true or false

        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(0, highestTier)

        for x = 1, numCols do
            --is skipping is one, alternate it
            if skipPattern and skipFlag then
                skipFlag = not skipFlag
                goto continue
            else
                skipFlag = not skipFlag
            end

            b = Brick((x - 1) * 32 + 8 + (15 - numCols) * 16, y * 16)
            if alternatePattern and alternateFlag then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

            -- if not alternating and we made it here, use the solid color/tier
            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end
            table.insert(bricks, b)
            ::continue::
        end
    end
    -- in the event we didn't generate any bricks, try again
    if #bricks == 0 then
        return self.createMap(level)
    else
        return bricks
    end
end
