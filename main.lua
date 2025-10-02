-- debug
if arg[2] == "debug" then
    require("lldebugger").start()
end

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

require("lua.levels.l_1")
require("lua.levels.tutorial")

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

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
