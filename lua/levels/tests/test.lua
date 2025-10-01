--TODO: (low priority) Improve level loading (?) and make tables into global variables
-- objects
local wall = require("lua.obj.wall")
local pItem = require("lua.obj.pItem")

-- enemies table
local enemies = {
    wall:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
    wall:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"),
    wall:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"),
    wall:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p")
}

-- power items
local items = {}

-- item text table
local textEffect = {}

local itemScore = "200"

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        wall:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
        wall:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"),
        wall:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"),
        wall:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p")
    }
end

function resetTest(key)
    if key == "r" then
        loadTestEnemies()
    end
end

-- load level contents
function TestLvLoad()
    -- items
    for i, v in ipairs(items) do
        v:draw()
    end
    
    --TODO: Add particles when hit enemy (v:collision(enemies))
    -- enemy draw & dead function
    for i, v in ipairs(enemies) do
        v:draw()
        v:despawn()

        love.graphics.setColor(1,1,1)
        --TODO: Replace with progressbar
        love.graphics.printf("HP: ".. v.hp, monogram, 0, 20 * i, gWidth, "center")
    end

    for i, v in ipairs(textEffect) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(v[1], v[2], v[3], v[4])
    end
end

-- level game loops
function TestLvUpdate(dt)
    -- items
    for i, v in ipairs(items) do
        v:col()
        v:update(dt)
        if isFail == false and isLoseLife == false then
            playerItem(v)
        else
        end

        if v.get and v.itype == "p" then
            table.remove(items, i)
            table.insert(textEffect, {itemScore, monogram, v.x, v.y, true, 0})
            if stats.pTier < 3 then
                stats.pTier = stats.pTier + 1
                stats.score = stats.score + v.score
            else
                stats.score = stats.score + v.score + 300
            end
        end

        if v.get and v.itype == "b" then
            table.remove(items, i)
            table.insert(textEffect, {200, monogram, v.x, v.y, true, 0})
            stats.bomb = stats.bomb + 1
        end
    end

    -- chnage text if tier is 3
    if stats.pTier > 2 then
        itemScore = "500"
    else
        itemScore = "200"
    end
    
    -- text effect
    for i, v in ipairs(textEffect) do

        if v[5] == true then
            v[6] = v[6] + dt
        end

        if v[5] == false then
            table.remove(textEffect, i)
        end

        if v[6] > 1.5 then
            v[5] = false
        end
    end
    
    -- enemies
    for i, v in ipairs(enemies) do
        if isFail == false and isLoseLife == false and player.invis == false then
            playerCol(v)
        else
        end
        
        playerBomb(v)

        if v.dead then
            table.remove(enemies, i)
            stats.combo = stats.combo + 1
            scoreFormula(v)
            stats.enemies = stats.enemies + 1
            comboTime = 0
        end

        if v.item == "p" and v.dead then
            table.insert(items, pItem:new(v.x + v.w / 2, v.y + v.h / 2, 15, 7, 200, "p"))
        end

        if v.item == "b" and v.dead then
            table.insert(items, pItem:new(v.x + v.w / 2, v.y + v.h / 2, 15, 7, 200, "b"))
        end
    end
    -- player bullet collision
    for i, v in ipairs(pBlList_1) do
        for j, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
    end
    
    for i, v in ipairs(pBlList_2) do
        for j, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
    end
    
    for i, v in ipairs(pBlList_3) do
        for j, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
    end
end