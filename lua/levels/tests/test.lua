-- objects
local enemy = require("lua.obj.enemy")

-- enemies table
if stage == "TEST" and state == "game" then
    table.insert(enemies, enemy:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500, "s", 50))
    table.insert(enemies, enemy:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b", 50))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p", 50))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p", 50))
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    table.insert(enemies, enemy:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500, "s", 50))
    table.insert(enemies, enemy:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b", 50))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p", 50))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p", 50))
end

function resetTest(key)
    if key == "r" then
        loadTestEnemies()
    end
end
