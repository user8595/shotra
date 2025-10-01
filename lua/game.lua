local Bullet = require("lua.obj.bullet")

local function playerPosReset()
    player.x, player.y = gWidth / 2 - 12, gHeight - 60
    hitbox.x, hitbox.y = player.x + 8, player.y + 8
end

function gameDisplay()
    -- player object
    love.graphics.setColor(playerColour)
    love.graphics.rectangle("line", player.x, player.y, player.w, player.h)
    love.graphics.setColor(playerColour)
    love.graphics.rectangle("fill", hitbox.x, hitbox.y, hitbox.w, hitbox.h)
    -- love.graphics.print(player.cDown, 40, 120)

    
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
    
    -- stage loading
    if stage == "TEST" then
        TestLvLoad()
    elseif stage == "TEST_2" then
        Test_2LvLoad()
    elseif stage == "TEST_3" then
        Test_3LvLoad()
    end
end

function playerControl(dt)
    if isShoot then
        -- shoots bullets with cooldown
        --TODO: Improve player tiers
        if stats.pTier == 1 then
            if player.cDown > 0.12 then
                table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                player.cDown = 0
            end
        elseif stats.pTier == 2 then
            if player.cDown > 0.08 then
                table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                player.cDown = 0
            end
        elseif stats.pTier == 3 then
            if player.cDown > 0.05 then
                table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                player.cDown = 0
            end
        end
    else
    end
    
    if love.keyboard.isDown(keys.up) then
        hitbox.y = hitbox.y - dt * player.vy
        player.y = player.y - dt * player.vy
    end
    if love.keyboard.isDown(keys.down) then
        hitbox.y = hitbox.y + dt * player.vy
        player.y = player.y + dt * player.vy
    end
    if love.keyboard.isDown(keys.left) then
        hitbox.x = hitbox.x - dt * player.vx
        player.x = player.x - dt * player.vx
    end
    if love.keyboard.isDown(keys.right) then
        hitbox.x = hitbox.x + dt * player.vx
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
        hitbox.x = gameWorld.x + 8
    end

    if player.x > gameWorld.x + gameWorld.w - player.w then
        player.x = gameWorld.x + gameWorld.w - player.w
        hitbox.x = gameWorld.x + gameWorld.w - player.w + 8
    end

    -- ignore collision if dead (for death anim?)
    if isLoseLife == false then
        if player.y > gHeight - player.h then
            player.y = gHeight - player.h
            hitbox.y = gHeight - player.h + 8
        end
    else
    end

    if player.y < 0 then
        player.y = 0
        hitbox.y = 8
    end
end

function playerFail(dt)
    -- hide ship if dead
    --TODO: Improve death animation
    if player.dead then
        playerColour[4] = 0
        playerPosReset()
    elseif player.dead and player.invis == false then
        playerColour[4] = 1
    end
    
    -- player lost cooldown before respawn
    if player.lostLifeCool < 0.85 and isLoseLife then
        player.lostLifeCool = player.lostLifeCool + dt
        stats.combo = 0
    end
    
    -- cooldown runs quicker when lifes are empty
    if player.lostLifeCool > 0.65 and isLoseLife and stats.life < 1 then
        player.lostLifeCool = player.lostLifeCool + dt
    end
    
    if player.lostLifeCool > 0.85 and isLoseLife and stats.life > 0 then
        isLoseLife = false
        player.dead = false
        player.invis = true
        player.lostLifeCool = 0
        stats.life = stats.life - 1
        stats.pTier = 1
    end

    if player.lostLifeCool > 0.5 and isLoseLife and stats.life < 1 then
        isLoseLife = false
        player.lostLifeCool = 0
        isContinue = true
    end
end

-- player invinciblility
local pIframe = 0
function playerInvis(dt)
    if player.invis then
        player.iCool = player.iCool + dt

        -- show invincible frames for player
        if player.iCool > 0 then
            pIframe = pIframe + dt
        end

        -- player iframes function
        if pIframe > 0 then
            playerColour[4] = 0.5
        end
        if pIframe > 0.05 then
            playerColour[4] = 0.75
        end
        if pIframe > 0.1 then
            pIframe = 0
        end

        if player.iCool > 4 then
            player.invis = false
            player.iCool = 0
            playerColour[4] = 1
        end
    else
    end
end

-- player collision
function playerCol(obj)
    local hL, hR, hT, hB = hitbox.x, hitbox.x + hitbox.w, hitbox.y, hitbox.y + hitbox.h
    local objL, objR, objT, objB = obj.x, obj.x + obj.w, obj.y, obj.y + obj.h

    -- enemy object
    if hR > objL and hL < objR and hB > objT and hT < objB then
        obj.hp = obj.hp - 2
        player.dead = true
        isLoseLife = true
    end

end

--TODO: Improve code?
function playerItem(obj)
    local pL, pR, pT, pB = player.x, player.x + player.w, player.y, player.y + player.h
    local objL, objR, objT, objB = obj.x, obj.x + obj.w, obj.y, obj.y + obj.h

    if pR > objL and pL < objR and pB > objT and pT < objB then
        obj.get = true
    end
end

function statsFunc()
    if stats.score > stats.hScore then
        stats.hScore = stats.score
    end

    if stats.combo > stats.mCombo then
        stats.mCombo = stats.combo
    end
end

-- score function
--TODO: Readjust score formula
function scoreFormula(v)
    stats.score = stats.score + (v.score * stats.combo)
end

function comboCooldown(dt)
    if stats.combo > 0 then
        comboTime = comboTime + dt
    end
    if comboTime > 2 then
        stats.combo = 0
        comboTime = 0
    end
end