-- main game
require("lua.defaults")
require("lua.game")
require("lua.ui")
require("lua.textures")
require("lua.save")
require("lua.states")
require("lua.content")

-- levels
require("lua.levels.tests.test")
require("lua.levels.tests.test_2")
require("lua.levels.tests.test_3")

function love.update(dt)
    gameLoop(dt)
end

function love.keypressed(key)
    keyFunc(key)
end

function love.resize(w, h)
    wWidth, wHeight = w, h
end

function love.draw()
    gameContent()
end