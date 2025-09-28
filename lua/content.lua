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
