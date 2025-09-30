-- objects
local wall = require("lua.obj.wall")

local enemies = {
    wall:new(gWidth / 4, 80, 50, 50, 150, 2500),
    wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500),
    wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500),
}

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        wall:new(gWidth / 4, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500),
    }   
end

function resetTest_2(key)
    if key == "r" then
        loadTestEnemies()
    end
end

-- load level contents
function Test_2LvLoad()
    --TODO: Add particles when hit enemy (v:collision(enemies))
    
    -- enemy draw & dead function
    for i, v in ipairs(enemies) do
        v:draw()
        v:despawn()
        
        love.graphics.setColor(1,1,1)
        --TODO: Replace with progressbar
        love.graphics.printf("HP: ".. v.hp, monogram, 0, 20 * i, gWidth, "center")
    end
end

-- level game loops
function Test_2LvUpdate(dt)
    for i, v in ipairs(enemies) do
        if isFail == false and isLoseLife == false and player.invis == false then
            playerCol(v)
        else
        end

        v:col()
        v:update(dt)
        
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