-- boss & bullet pattern level tes
local bo = require("lua.obj.boss")
local en = require("lua.obj.enemy")
local eb = require("lua.obj.eBullet")

local enSpawn = 15
local bossSpawned = false

local function resetTestEnemies()
    stats.gameTime = 0
    warningTime = 0
    enSpawn = 15
    isBoss, isWarning, bossSpawned = false, false, false
    enemies, enemyBullet, boss = {}, {}, {}
end

function enemiesTest_4(dt)
    if stats.gameTime > 5 and stats.gameTime < 5 + warnTimeout then
        isWarning = true
    end

    if stats.gameTime > 5 + warnTimeout and not bossSpawned then
        table.insert(boss, bo:new(gameWorld.x + gameWorld.w / 2 - 150 / 2, gameWorld.y - 150, 150, 150, 5000, 5000, 100000))
        bossSpawned = true
    end

    if stats.gameTime >= enSpawn and isBoss then
        if enSpawn % 20 == 0 then
            table.insert(enemies, en:new(gameWorld.x + gameWorld.w - 40, gameWorld.y + 160, 20, 20, 3, 200, ""))
            table.insert(enemies, en:new(gameWorld.x + 20, gameWorld.y + 160, 20, 20, 3, 200, "p"))
    
            table.insert(enemies, en:new(gameWorld.x + 40, gameWorld.y + 180, 20, 20, 3, 200, ""))
            table.insert(enemies, en:new(gameWorld.x + gameWorld.w - 80, gameWorld.y + 180, 20, 20, 3, 200, "b"))

            table.insert(enemyBullet, eb:new(gameWorld.x + 45 + 5, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
            table.insert(enemyBullet, eb:new(gameWorld.x + 45 + 15, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))

            table.insert(enemyBullet, eb:new(gameWorld.x + gameWorld.w - 45 - 5, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
            table.insert(enemyBullet, eb:new(gameWorld.x + gameWorld.w - 45 - 15, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
        else
            table.insert(enemies, en:new(gameWorld.x + gameWorld.w - 40, gameWorld.y + 160, 20, 20, 3, 200, ""))
            table.insert(enemies, en:new(gameWorld.x + 20, gameWorld.y + 160, 20, 20, 3, 200, ""))
    
            table.insert(enemies, en:new(gameWorld.x + 40, gameWorld.y + 180, 20, 20, 3, 200, ""))
            table.insert(enemies, en:new(gameWorld.x + gameWorld.w - 80, gameWorld.y + 180, 20, 20, 3, 200, ""))
            
            table.insert(enemyBullet, eb:new(gameWorld.x + 45 + 5, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
            table.insert(enemyBullet, eb:new(gameWorld.x + 45 + 15, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))

            table.insert(enemyBullet, eb:new(gameWorld.x + gameWorld.w - 45 - 5, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
            table.insert(enemyBullet, eb:new(gameWorld.x + gameWorld.w - 45 - 15, gameWorld.y + 210, 0, 200, 5, 15, 0, 1))
        end
        enSpawn = enSpawn + 1
    end

    for _, v in ipairs(boss) do
        v:moveInit(dt)
    end

    for _, v in ipairs(enemies) do
        v:update(dt)
        v:col()
    end
end

function resetTest_4(key)
    if key == "r" then
        resetTestEnemies()
    end
end