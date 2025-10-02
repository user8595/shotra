--TODO: (low priority) Improve level loading (?) and make tables into global variables
-- objects
local wall = require("lua.obj.wall")

-- enemies table
if stage == "TEST" then
    table.insert(enemies, wall:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500))
    table.insert(enemies, wall:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"))
    table.insert(enemies, wall:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, wall:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    table.insert(enemies, wall:new(gWidth / 4, 80, gWidth / 2, 50, 50, 500))
    table.insert(enemies, wall:new(gWidth / 4, 150, gWidth / 2, 50, 50, 100, "b"))
    table.insert(enemies, wall:new(gWidth / 4 + 20, 220, 40, 50, 50, 500, "p"))
    table.insert(enemies, wall:new(gWidth / 2 + 20, 220, 40, 50, 50, 100, "p"))
end

function resetTest(key)
    if key == "r" then
        loadTestEnemies()
    end
end
