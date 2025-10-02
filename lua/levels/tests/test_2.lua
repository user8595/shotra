-- objects
local wall = require("lua.obj.wall")

if stage == "TEST_2" then
    enemies = {
        wall:new(gWidth / 4, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500),
    }
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        wall:new(gWidth / 4, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500),
        wall:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500),
    }   
end

function resetTest_2(key)
    if key == "r" then
        loadTestEnemies()
    end
end
