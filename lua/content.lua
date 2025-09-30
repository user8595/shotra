require("lua.levels.test")
require("lua.levels.test_2")

function gameContent()
    love.graphics.push()
    love.graphics.translate((wWidth - gWidth) / 2, (wHeight - gHeight) / 2)
    states()
    love.graphics.pop()

    if isDebug then
    debugMenu()
    else
    end
end

function gameLoop(dt)
    -- game states
    if state == "game" and isPaused == false and isPauseDelay == false and isContinue == false then
        if stage == "TEST" then
            TestLvUpdate()
        elseif stage == "TEST_2" then
            Test_2LvUpdate(dt)
        end
        
        -- stats and combo cooldown functionality
        statsFunc()
        comboCooldown(dt)
        playerInvis(dt)
    end
    
    -- player movement
    if state == "game" and player.dead == false and isLoseLife == false and isPaused == false and isPauseDelay == false and isContinue == false and isFail == false then
        playerControl(dt)
    else
    end

    -- player fail & respawn
    if state == "game" then
        playerFail(dt)
    end

    -- player functionality and combo anim
    if state == "game" and isPaused == false and isPauseDelay == false and isContinue == false and isFail == false then
        playerFunc(dt)
        comboHudAnim(dt)
    else
    end

    if isPaused == false and isPauseDelay then
        pauseAnim(dt)
    end

    if isContinue then
        continueFunc(dt)
    else
    end

    if isFail then
        goFunc(dt)
        comboCooldown(dt)
    end
end
