-- objects
local enemy = require("lua.obj.enemy")

if stage == "TEST_2" and state == "game" then
    enemies = {
        enemy:new(gWidth / 4, 80, 50, 50, 150, 2500, "p"),
        enemy:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b"),
        enemy:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p"),
    }
end

-- reset enemies function
local function loadTestEnemies()
    enemies = {
        enemy:new(gWidth / 4, 80, 50, 50, 150, 2500, "p"),
        enemy:new(gWidth / 4 + 200, 80, 50, 50, 150, 2500, "b"),
        enemy:new(gWidth / 4 + 300, 80, 50, 50, 150, 2500, "p"),
    }   
end

function resetTest_2(key)
    if key == "r" then
        loadTestEnemies()
    end
end
