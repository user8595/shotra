require("lua.obj.wall")

local wall = require("lua.obj.wall")
local wl = wall

local enemies = {
    wl:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
    wl:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100)
}

-- reset enemies function
--TODO: Improve enemy reset function (?)
function loadTestEnemies()
    enemies = {
        wl:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500),
        wl:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100)
    }   
end

function TestLvLoad()
    --TODO: Add particles when hit enemy
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
    
    -- enemy draw & dead function
    for i, v in ipairs(enemies) do
        v:draw()
        v:despawn()

        love.graphics.setColor(1,1,1)
        love.graphics.printf("HP: ".. v.hp, monogram, 0, 20 * i, gWidth, "center")

        if v.dead then
            table.remove(enemies, i)
            stats.score = stats.score + v.score
            stats.combo = stats.combo + 1
            comboTime = 0
        end
        -- TODO: Add enemy collision on player (AABB Collision?)
    end
end
