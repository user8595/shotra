local pBullet = require("lua.obj.pBullet")
local pBl = pBullet

function gameDisplay()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", player.x, player.y, player.w, player.h)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.x + 10, player.y + 10, player.hW, player.hH)
    -- love.graphics.print(player.cDown, 40, 120)

    if isShoot then
        -- shoots bullets with cooldown
        if stats.pTier == 1 then
            if player.cDown > 0.12 then
                table.insert(pBlList_1, pBl:new(player.x, player.y - 15, 5, 10, 700))
                table.insert(pBlList_2, pBl:new(player.x + 10, player.y - 25, 5, 10, 700))
                table.insert(pBlList_3, pBl:new(player.x + 20, player.y - 15, 5, 10, 700))
                player.cDown = 0
            end
        elseif stats.pTier == 2 then
        elseif stats.pTier == 3 then
        end
    else
    end

    -- left side
    for i, v in ipairs(pBlList_1) do
        v:draw()
        v:despawn()

        if v.dead then
            table.remove(pBlList_1, i)
        end
    end

    -- center
    for i, v in ipairs(pBlList_2) do
        v:draw()
        v:despawn()

        if v.dead then
            table.remove(pBlList_2, i)
        end
    end
    
    -- right side
    for i, v in ipairs(pBlList_3) do
        v:draw()
        v:despawn()
        
        if v.dead then
            table.remove(pBlList_3, i)
        end
    end
end

function playerControl(dt)
    if love.keyboard.isDown(keys.up) then
        player.y = player.y - dt * player.vy
    end
    if love.keyboard.isDown(keys.down) then
        player.y = player.y + dt * player.vy
    end
    if love.keyboard.isDown(keys.left) then
        player.x = player.x - dt * player.vx
    end
    if love.keyboard.isDown(keys.right) then
        player.x = player.x + dt * player.vx
    end
    
    if love.keyboard.isDown(keys.shoot) then
        isShoot = true  
    else
        isShoot = false
    end
    
    --TODO: FInish bomb functionality
    if love.keyboard.isDown(keys.bomb) then
        
    end
    
    if love.keyboard.isDown(keys.slow) then
        player.vx, player.vy = 110, 110
    else
        player.vx, player.vy = 200, 200
    end
    
    if isShoot then
        player.cDown = player.cDown + dt
    end
end

function playerFunc(dt)    
    -- left side
    for i, v in ipairs(pBlList_1) do
        v:move(dt)
    end

    -- center
    for i, v in ipairs(pBlList_2) do
        v:move(dt)
    end

    -- right side
    for i, v in ipairs(pBlList_3) do
        v:move(dt)
    end

    -- screen game collision
    if player.x < gameWorld.x then
        player.x = gameWorld.x
    end
    if player.x > gameWorld.x + gameWorld.w - player.w then
        player.x = gameWorld.x + gameWorld.w - player.w
    end
    if player.y > gHeight - player.h then
        player.y = gHeight - player.h
    end
    if player.y < 0 then
        player.y = 0
    end
end

function statsFunc(dt)
    if stats.score > stats.hScore then
        stats.hScore = stats.score
    end

    if stats.combo > stats.mCombo then
        stats.mCombo = stats.combo
    end

    if stats.life < 0 then
        isFail = true
    else
        isFail = false
    end
end

function comboCooldown(dt)
    if stats.combo > 0 then
        comboTime = comboTime + dt
    end
    if comboTime > 5 then
        stats.combo = 0
        comboTime = 0
    end
end