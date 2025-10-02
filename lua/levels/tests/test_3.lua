-- objects
local wall = require("lua.obj.wall")
-- table width & height
local wT, hT = 10, 15

-- enemy table
-- enemies might move slightly when hit
if stage == "TEST_3" then
    for y = 1, wT, 1 do
        table.insert(enemies, wall:new(gameWorld.x + 20, gameWorld.y + 20 * y, 10, 10, 2, 100))
        for x = 1, hT, 1 do
            table.insert(enemies, wall:new(gameWorld.x + 20 * x, gameWorld.y + 20 * y, 10, 10, 2, 100))
        end
    end
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {}
    
    for y = 1, wT, 1 do
        table.insert(enemies, wall:new(gameWorld.x + 20, gameWorld.y + 20 * y, 10, 10, 2, 100))
        for x = 1, hT, 1 do
            table.insert(enemies, wall:new(gameWorld.x + 20 * x, gameWorld.y + 20 * y, 10, 10, 2, 100))
        end
    end
end

function resetTest_3(key)
    if key == "r" then
        loadTestEnemies()
    end
end
