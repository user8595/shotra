-- objects
local enemy = require("lua.obj.enemy")
local bo = require("lua.obj.boss")

-- enemies table
if stage == "TEST" and state == "game" then
    table.insert(boss, bo:new(gWidth / 4, 80, gWidth / 2, 50, 50, 50, 500))
    table.insert(boss, bo:new(gWidth / 4, 150, gWidth / 2, 50, 50, 50, 100))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    boss = {}
    table.insert(boss, bo:new(gWidth / 4, 80, gWidth / 2, 50, 50, 50, 500))
    table.insert(boss, bo:new(gWidth / 4, 150, gWidth / 2, 50, 50, 50, 100))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

function resetTest(key)
    if key == "r" then
        loadTestEnemies()
    end
end
