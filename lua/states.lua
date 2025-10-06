-- game states
function gameStates()
    if state == "game" then
        screen()
        gameDisplay()
        LevelDraw()
    else
    end
end

-- menu states
function states()
    if state == "game" then
        borderS()
        hud()
    else
    end

    if isPaused then
        pauseScreen()
    else
    end

    if isPaused == false and isPauseDelay then
        pauseCooldown()
    else
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

    -- gameplay keys
    if state == "game" and isPaused == false and isPauseDelay == false and isContinue == false and isFail == false then
        playerKey(key)
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

    -- test reset keys
    if stage == "TEST" then
        resetTest(key)
    elseif stage == "TEST_2" then
        resetTest_2(key)
    elseif stage == "TEST_3" then
        resetTest_3(key)
    elseif stage == "TEST_4" then
        resetTest_4(key)
    end
end
