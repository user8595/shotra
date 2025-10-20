-- objects
local enemy = require("lua.obj.enemy")

if stage == "TEST_2" and state == "game" then
    enemies = {
        enemy:new(gWidth / 4, 80, 50, 50, 150, 2500, "p", 150),
        enemy:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b", 150),
        enemy:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p", 150),
    }
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        enemy:new(gWidth / 4, 80, 50, 50, 150, 2500, "p", 150),
        enemy:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b", 150),
        enemy:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p", 150),
    }   
end

function resetTest_2(key)
    if key == "r" then
        loadTestEnemies()
    end
end
