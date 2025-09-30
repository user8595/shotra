-- objects
local wall = require("lua.obj.wall")

local enemies = {}
-- table width & height
local wT, hT = 10, 15

-- enemy table
-- enemies might move slightly when hit
for y = 1, wT, 1 do
    table.insert(enemies, wall:new(gameWorld.x + 20, gameWorld.y + 20 * y, 10, 10, 2, 100))
    for x = 1, hT, 1 do
        table.insert(enemies, wall:new(gameWorld.x + 20 * x, gameWorld.y + 20 * y, 10, 10, 2, 100))
    end
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    
    for y = 1, wT, 1 do
        table.insert(enemies, wall:new(gameWorld.x + 20, gameWorld.y + 20 * y, 10, 10, 2, 100))
        for x = 1, hT, 1 do
            table.insert(enemies, wall:new(gameWorld.x + 20 * x, gameWorld.y + 20 * y, 10, 10, 2, 100))
        end
    end
end

function resetTest_3(key)
    if key == "r" then
        loadTestEnemies()
    end
end

-- load level contents
function Test_3LvLoad()
    --TODO: Add particles when hit enemy (v:collision(enemies))    
    -- enemy draw & dead function
    for i, v in ipairs(enemies) do
        v:draw()
        v:despawn()
    end
end

-- level game loops
function Test_3LvUpdate(dt)
    for i, v in ipairs(enemies) do
        if isFail == false and isLoseLife == false and player.invis == false then
            playerCol(v)
        else
        end

        v:update(dt)
        v:col()
        
        if v.dead then
            table.remove(enemies, i)
            stats.combo = stats.combo + 1
            scoreFormula(v)
            stats.enemies = stats.enemies + 1
            comboTime = 0
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