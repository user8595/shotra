function hud()
    love.graphics.print({gray, "HI-SCORE\n", white, string.format("%07d", stats.hScore)}, monogram, 20, 20)
    love.graphics.print({gray, "SCORE\n", white, string.format("%07d", stats.score)}, monogram, 20, 60)
    love.graphics.print({gray, "STAGE\n", white, level}, monogram, 20, gHeight - 60)
    love.graphics.print({gray, "LIVES\n", white, "x" .. stats.life}, monogram, 495, gHeight - 60)
    love.graphics.print({gray, "BOMB\n", white, "x" .. stats.bomb}, monogram, 495, gHeight - 100)
    love.graphics.print({gray, "TIER\n", white, stats.pLevel}, monogram, 495, gHeight - 140)
end

function screen()
    love.graphics.setColor(0.05,0.05,0.05)
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
