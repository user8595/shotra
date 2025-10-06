-- objects
local enemy = require("lua.obj.enemy")

-- enemies table
if stage == "TEST" and state == "game" then
    table.insert(enemies, enemy:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500, "s"))
    table.insert(enemies, enemy:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    table.insert(enemies, enemy:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500, "s"))
    table.insert(enemies, enemy:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"))
    table.insert(enemies, enemy:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, enemy:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

function resetTest(key)
    if key == "r" then
        loadTestEnemies()
    end
end
