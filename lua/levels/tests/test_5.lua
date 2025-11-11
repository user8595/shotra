local en = require("lua.obj.enemy")
local eb = require("lua.obj.eBullet")
local next = next

local blCool = 0
local blTime = 0

if stage == "TEST_5" and state == "game" then
    table.insert(enemies, en:new(gWidth / 2 - 30, 80, 60, 60, 1600, 50000, "", 1600))
end

function enemiesTest_5(dt)
    if next(enemies) ~= nil then
        blCool, blTime = blCool + dt, blTime + dt

        if blCool > 0.14 then
            table.insert(enemyBullet, eb:new(gWidth / 2 - 2.5, 135, 300, 300, 5, 5, 0, 1, 1))
            table.insert(enemyBullet, eb:new(gWidth / 2 - 2.5, 135, 300, 300, 5, 5, 0, 1, 2))
            table.insert(enemyBullet, eb:new(gWidth / 2 - 2.5, 135, 300, 300, 5, 5, 0, 1, 3))
            table.insert(enemyBullet, eb:new(gWidth / 2 - 2.5, 135, 300, 300, 5, 5, 0, 1, 4))
            table.insert(enemyBullet, eb:new(gWidth / 2 - 2.5, 135, 300, 300, 5, 5, 0, 1, 5))
            blCool = 0
        end
    else
        blTime = 0
    end

    for _, v in ipairs(enemyBullet) do
        v:test1(dt)
        if blTime > 2.5 then
            v.vx = v.vx + dt * 450
        end
        if blTime > 5 then
            v.vx = v.vx - dt * 400
            blTime = 0
        end
    end
end

local function resetTestEnemies()
    enemies, enemyBullet = {}, {}
    blCool, blTime = 0, 0
    table.insert(enemies, en:new(gWidth / 2 - 30, 80, 60, 60, 1200, 5000, "", 1200))
end

function resetTest_5(key)
    if key == "r" then
        resetTestEnemies()
    end
end
