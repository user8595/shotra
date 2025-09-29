require("lua.levels.test")

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
    if state == "game" and isPaused == false and isPauseDelay == false then
        if stage == "TEST" then
            TestLvUpdate()
        end

        -- stats and combo cooldown functionality
        statsFunc()
        comboCooldown(dt)
    end
    
    -- player movement
    if player.dead == false and isLoseLife == false and isContinue == false and isFail == false then
        playerControl(dt)
    else
    end

    -- player fail & respawn
    playerFail(dt)

    -- player functionality and combo anim
    if state == "game" and isPaused == false and isPauseDelay == false then
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
