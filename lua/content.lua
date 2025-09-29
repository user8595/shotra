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
    if state == "game" and isPaused == false and isPauseDelay == false and isContinue == false and isFail == false then
        playerControl(dt)
        statsFunc(dt)
        comboCooldown(dt)
    end

    if state == "game" and isPaused == false and isPauseDelay == false and isContinue == false then
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
    end

    if love.keyboard.isDown("q") then
        stats.combo = stats.combo + 1
        comboTime = 0
    end

    if love.keyboard.isDown("a") then
        stats.combo = 0
        comboTime = 0
    end
end
