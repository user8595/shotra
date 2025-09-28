function states()
    if state == "game" then
        hud()
        screen()
        gameDisplay()
    else
    end
    
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
    
    if key == "f4" then
        if isDebug == false then
            isDebug = true
        else
            isDebug = false
        end
    end
end

function gameLoop(dt)
    if state == "game" and isPaused == false then
        playerFunc(dt)
    end
end