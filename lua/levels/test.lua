require("lua.obj.wall")

-- objects
local wall = require("lua.obj.wall")
local wl = wall

local enemies = {
    wl:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
    wl:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100),
    wl:new(gWidth / 4 + 20, 220, 40, 50, 50, 100),
    wl:new(gWidth / 2 + 20, 220, 40, 50, 50, 100)
}

-- reset enemies function
--TODO: Improve enemy reset function (?)
function loadTestEnemies()
    enemies = {
        wl:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
        wl:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100),
        wl:new(gWidth / 4 + 20, 220, 40, 50, 50, 100),
        wl:new(gWidth / 2 + 20, 220, 40, 50, 50, 100)
    }   
end

-- load level contents
function TestLvLoad()
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
function TestLvUpdate()
    for i, v in ipairs(enemies) do
        playerCol(v)
        
        if v.dead then
            table.remove(enemies, i)
            stats.combo = stats.combo + 1
            stats.score = stats.score + v.score * stats.combo
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