require("lua.strings")
local tween = require("lib.tween")

local prgDelay = 0
local contTime = 10
local lT = livesString[1]

local extendbg = {w=0}
local extendT = {
    tween.new(0.1, extendbg, {w = 100}, tween.easing.outCirc),
    tween.new(0.15, extendbg, {w = 0}, tween.easing.outCirc)
}

function borderS()
    love.graphics.setColor(borderColour)
    love.graphics.rectangle("fill", 0, 0, gWidth / 4, gHeight)
    love.graphics.rectangle("fill", gWidth - gWidth / 4, 0, gWidth / 4, gHeight)
end

local flick1, flick2 = 0, 0
function hud()
    love.graphics.setColor(white)
    love.graphics.print({gray, "HI-SCORE\n", white, string.format("%07d", stats.hScore)}, monogram, 20, 20)
    love.graphics.print({gray, "SCORE\n", white, math.floor(stats.score)}, monogram, 20, 60)
    love.graphics.print({gray, "STAGE\n", white, stage}, monogram, 20, gHeight - 60)
    
    love.graphics.setColor(white)
    love.graphics.rectangle("fill", gameWorld.x + gameWorld.w, gHeight - 60, extendbg.w, 22)
    love.graphics.print({livesTxt, lT, white, "x" .. stats.life}, monogram, 495, gHeight - 60)

    love.graphics.print({gray, "BOMB\n", white, "x" .. stats.bomb}, monogram, 495, gHeight - 100)
    love.graphics.print({gray, "TIER\n", white, stats.pTier}, monogram, 495, gHeight - 140)

    if stats.combo > 3 then
        love.graphics.setColor(white)
        love.graphics.printf({gold, "COMBO!!\n", white, "x" .. math.floor(stats.combo)}, monogram, 0, 105, gWidth / 4 - 15, "right")
        love.graphics.printf({gray, "max x" .. math.floor(stats.mCombo)}, picopixel, 0, 147, gWidth / 4 - 15, "right")
    else
        love.graphics.printf({gray, "max x" .. math.floor(stats.mCombo)}, picopixel, 0, 147, gWidth / 4 - 15, "right")
    end
end

function lifeBar(i, v)
    local lFull = gameWorld.w - 30
    local lCurr = v.hp / v.maxHP

    love.graphics.setColor(lifeBarColor)
    love.graphics.rectangle("fill", gameWorld.x + 15, gameWorld.y + 27 + 15 * (i - 1), lFull * lCurr, 2.5)
end

function comboHudAnim(dt)
    if comboTime > 0 then
        flick1 = flick1 + dt
    else
        flick1 = 0
    end
    
    if flick1 > 0 then
        gold[1], gold[2] = 0.65, 0.65
    end
    if flick1 > 0.05 then
        gold[1], gold[2] = 1, 1
    end
    if flick1 > 0.1 then
        flick1 = 0
    end
end

-- extra live text effect
function hudAnim(dt)
    if isExtend then
        Etimer = Etimer + dt
        lT = livesString[2]
    else
        Etimer = 0
        lT = livesString[1]
        livesTxt[1], livesTxt[2], livesTxt[3] = 0.5, 0.5, 0.5
    end

    if Etimer > 0 then
        flick2 = flick2 + dt
    end

    if Etimer > 4 then
        isExtend = false
        Etimer = 0
        flick2 = 0
    end

    -- text flicker effect
    if flick2 > 0 then
        livesTxt[1], livesTxt[2], livesTxt[3] = 0, 0, 0
    end
    if flick2 > 0.05 then
        livesTxt[1], livesTxt[2], livesTxt[3] = 0.5, 0.5, 0.5
    end
    if flick2 > 0.1 then
        flick2 = 0
    end

    -- extend bg reveal effect
    if isExtend and extendbg.w < 100 then
        if extendT[2].clock > 0 then
            extendT[2].clock = 0
        end
        extendT[1]:set(extendT[1].clock + dt)
    end

    if isExtend == false and extendbg.w > 0 then
        if extendT[1].clock > 0 then
            extendT[1].clock = 0
        end
        extendT[2]:set(extendT[2].clock + dt)
    end
end

--TODO: Redesign pause screen
function pauseScreen()
    love.graphics.setColor(0, 0, 0, 0.65)
    love.graphics.rectangle("fill", 0, 0, wWidth, wHeight)

    love.graphics.setColor(0.075, 0.075, 0.075)
    love.graphics.rectangle("fill", gWidth / 2 - 90, gHeight / 2 - 50, 180, 120)

    love.graphics.setColor(white)

    love.graphics.draw(border[2], gWidth / 2 - 90, gHeight / 2 - 60, 0, 5, 5)
    love.graphics.draw(border[2], gWidth / 2 + 90, gHeight / 2 - 60, 1.571, 5, 5)
    love.graphics.draw(border[2], gWidth / 2 - 90, gHeight / 2 + 70, -1.571, 5, 5)
    love.graphics.draw(border[2], gWidth / 2 + 90, gHeight / 2 + 70, 3.14, 5, 5)
    
    love.graphics.draw(border[1], gWidth / 2 - 80, gHeight / 2 - 60, 0, 40, 5)
    love.graphics.draw(border[1], gWidth / 2 - 90, gHeight / 2 + 60, -1.571, 28, 5)
    love.graphics.draw(border[1], gWidth / 2 + 90, gHeight / 2 - 50, 1.571, 28, 5)
    love.graphics.draw(border[1], gWidth / 2 + 80, gHeight / 2 + 70, 3.14, 40, 5)
    
    love.graphics.printf({gray, "E", white, "x" .. stats.enemies,  gray, " MC", white, "x" .. stats.mCombo}, monogram, gWidth / 2 - 70, gHeight / 2 - 40, 140, "center")
    love.graphics.printf("RESUME", monogram, gWidth / 2 - 70, gHeight / 2 - 10, 140, "center")
    love.graphics.printf("RETRY", monogram, gWidth / 2 - 70, gHeight / 2 + 10, 140, "center")
    love.graphics.printf("QUIT", monogram, gWidth / 2 - 70, gHeight / 2 + 30, 140, "center")
    love.graphics.printf({white, "P A U S E D\n", white, stats.continues, gray, " CONT."}, monogram, gWidth / 2 - 70, gHeight - 60, 140, "center")
end

function pauseCooldown()
    love.graphics.setColor(popupOverlay)
    love.graphics.rectangle("fill", 0, 0, wWidth, wHeight)
    love.graphics.setColor(white)
    love.graphics.rectangle("line", gWidth / 2 - 80, gHeight / 2 - 10, 160, 20) 
    love.graphics.draw(whitePixel, gWidth / 2 - 80, gHeight / 2 - 10, 0, math.floor(prgDelay), 20)
end

function pauseAnim(dt)
    if prgDelay < 160 then
        prgDelay = prgDelay + dt * 200
    elseif prgDelay > 160 then
        isPauseDelay = false
        prgDelay = 0
    end
end

function continueScreen()
    love.graphics.setColor(0, 0, 0, 0.65)
    love.graphics.rectangle("fill", 0, 0, wWidth, wHeight)
    
    love.graphics.setColor(white)
    love.graphics.print("CONTINUE?", monogramL, gWidth / 2 - 54, gHeight / 2 - 60)
    love.graphics.printf(math.floor(contTime), monogramL, gWidth / 2 - 54, gHeight / 2 - 25, 105, "center")
end

function continueFunc(dt)
    if contTime > 1 then
        contTime = contTime - dt
    end

    if contTime < 1 then
        isContinue = false
        isFail = true
    end

    if love.keyboard.isDown("return") then
        isContinue = false
        isFail = false
        contTime = 10
    end
end

function continueKey(key)
    if key == keys.shoot and contTime < 9 or key == keys.slow and contTime < 9 or key == keys.bomb and contTime < 9 then
        contTime = contTime - 1
    end

    if key == "return" then
        isLoseLife = false
        player.dead = false
        player.invis = true
        stats.continues = stats.continues + 1
        gameInit()
    end
end

local goDim = {0, 0, 0, 0.35}
function gameOverText()
    love.graphics.setColor(goDim)
    love.graphics.rectangle("fill", 0, 0, wWidth, wHeight)
    love.graphics.setColor(goText)
    love.graphics.print("GAME OVER", monogramL, gWidth / 2 - 54, gHeight / 2 - 20)
end

local tmr = 0
function goFunc(dt)
    tmr = tmr + dt
    if tmr > 0.75 then
        goText[4] = 1
    end

    if tmr > 5 then
        if goDim[4] < 1 then
            goDim[4] = goDim[4] + dt * 0.65
        end
    end

    --TODO: temporary, replace with changing scene to title
    if tmr > 6.5 then
        love.event.quit(0)
    end
end

function screen()
    love.graphics.setColor(screenCol)
    love.graphics.rectangle("fill", gameWorld.x, gameWorld.y, gameWorld.w, gameWorld.h)
end

function debugMenu()
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 0, 0, 80, 45)
    love.graphics.setColor(white)
    love.graphics.print(love.timer.getFPS() .. " FPS", picopixel, 10, 10)
    love.graphics.setColor(white)
    love.graphics.print(wWidth .. "x" .. wHeight, picopixel, 10, 25)
end
