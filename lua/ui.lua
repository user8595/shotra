require("lua.defaults")

function debugMenu()
    love.graphics.setColor(white)
    love.graphics.print(love.timer.getFPS() .. " FPS", picopixel, 10, 10)
    love.graphics.setColor(white)
    love.graphics.print(wWidth .. "x" .. wHeight, picopixel, 10, 25)
end