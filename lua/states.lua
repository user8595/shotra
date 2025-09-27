require("lua.ui")

function states()
    debugMenu()
end

function keyFunc(key)
    if key == "escape" then
        love.event.quit(0)
    end

    if key == "f11" then
        if love.window.getFullscreen() == false then
            love.window.setFullscreen(true)
        else
            love.window.setFullscreen(false)
        end
    end
end

function gameLoop(dt)
    
end