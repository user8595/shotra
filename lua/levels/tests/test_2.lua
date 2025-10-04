-- objects
local wall = require("lua.obj.wall")

if stage == "TEST_2" and state == "game" then
    enemies = {
        wall:new(gWidth / 4, 80, 50, 50, 150, 2500, "p"),
        wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b"),
        wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p"),
    }
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        wall:new(gWidth / 4, 80, 50, 50, 150, 2500, "p"),
        wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b"),
        wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p"),
    }   
end

function resetTest_2(key)
    if key == "r" then
        loadTestEnemies()
    end
end
