require("lua.defaults")
require("lua.game")
require("lua.ui")
require("lua.textures")
require("lua.save")
require("lua.states")
require("lua.content")

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