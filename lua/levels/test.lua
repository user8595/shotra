require("lua.obj.wall")

local wall = require("lua.obj.wall")
local wl = wall

local enemies = {
    wl:new(gWidth / 4, 80, gWidth / 2, 50, 50)
}

function TestLvLoad()
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
    
    for i, v in ipairs(enemies) do
        v:draw()
        v:despawn()
        love.graphics.print(v.hp)
        
        if v.dead then
            table.remove(enemies, i)
        end
    end
end