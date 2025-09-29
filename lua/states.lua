require("lua.levels.test")
function states()
    if state == "game" then
        borderS()
        hud()
        screen()
        gameDisplay()
    else
    end

    if isPaused then
        pauseScreen()
    else
    end

    if isPaused == false and isPauseDelay then
        pauseCooldown()
    end

    if isContinue then
        continueScreen()
    else
    end

    if isFail then
        gameOverText()
    else
    end
end

function keyFunc(key)
    if key == "escape" and isPaused or key == "escape" and isFail then
        love.event.quit(0)
    end

    if key == keys.pause[1] or key == keys.pause[2] then
        if isPaused == false and isFail == false and isPauseDelay == false and isContinue == false then
            isPaused = true
            isPauseDelay = true
        else
            isPaused = false
        end
    end

    if isContinue then
        continueKey(key)
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

    if key == "b" then
        isContinue = true
    end

    if key == "r" then
        loadTestEnemies()
    end
end
