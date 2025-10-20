local Bullet = require("lua.obj.bullet")
local pItem = require("lua.obj.pItem")
local eBullet = require("lua.obj.eBullet")
local table_clear = require("table.clear")

local pParticle = false

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
    for _, v in ipairs(pBlList_1) do
        v:draw()
    end
    
    -- center
    for _, v in ipairs(pBlList_2) do
        v:draw()
    end
    
    -- right side
    for _, v in ipairs(pBlList_3) do
        v:draw()
    end

    if isShoot then
        if isAutoFire then
            if stats.pTier == 1 then
                if player.cDown > 0.12 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.rectangle("fill", player.x - 1.45, player.y - 24, 8, 8)
                    love.graphics.rectangle("fill", player.x + 8.75, player.y - 28, 8, 8)
                    love.graphics.rectangle("fill", player.x + 18.8, player.y - 24, 8, 8)
                end
            elseif stats.pTier == 2 then
                if player.cDown > 0.08 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.rectangle("fill", player.x - 1.45, player.y - 24, 8, 8)
                    love.graphics.rectangle("fill", player.x + 8.75, player.y - 28, 8, 8)
                    love.graphics.rectangle("fill", player.x + 18.8, player.y - 24, 8, 8)
                end
            elseif stats.pTier == 3 then
                if player.cDown > 0.05 then
                    love.graphics.setColor(1, 1, 1)
                    love.graphics.rectangle("fill", player.x - 1.45, player.y - 24, 8, 8)
                    love.graphics.rectangle("fill", player.x + 8.75, player.y - 28, 8, 8)
                    love.graphics.rectangle("fill", player.x + 18.8, player.y - 24, 8, 8)
                end
            end
        else
        end
    else
    end

    if player.cDown > 0 and player.cDown < 0.05 and pParticle then
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("fill", player.x - 1.45, player.y - 24, 8, 8)
        love.graphics.rectangle("fill", player.x + 8.75, player.y - 28, 8, 8)
        love.graphics.rectangle("fill", player.x + 18.8, player.y - 24, 8, 8)
    end
end

function enemyLoad(dt)
    if stage == "TEST_4" then
        enemiesTest_4(dt)
    end
end

-- game screen shake effect
function screenShake(dt)
    if isShake then
        shakeTimer = shakeTimer + dt
    else
        shakeTimer = 0
        tX, tY = (wWidth - gWidth) / 2, (wHeight - gHeight) / 2
    end

    if shakeTimer > 0 and isShake and not isPaused and not isPauseDelay then
        tX, tY = (wWidth - gWidth) / 2 + love.math.random(-4, 4), (wHeight - gHeight) / 2 + love.math.random(-4, 4)
    else
        tX, tY = (wWidth - gWidth) / 2, (wHeight - gHeight) / 2
    end
end

function gameInit()
    stats.life = 2
    stats.bomb = 2
    stats.pTier = 1
    stats.score = 0
    stats.exLife = 350000
end

local sCool = false
function playerControl(dt)
    if isShoot then
        -- shoots bullets with cooldown
        --TODO: Improve player tiers
        if isAutoFire then
            if stats.pTier == 1 then
                if player.cDown > 0 and not sCool then
                    table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                    table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                    table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                    sCool = true
                end
                if player.cDown > 0.12 then
                    sCool = false
                    player.cDown = 0
                end
            elseif stats.pTier == 2 then
                if player.cDown > 0 and not sCool then
                    table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                    table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                    table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                    sCool = true
                end
                if player.cDown > 0.08 then
                    player.cDown = 0
                    sCool = false
                end
            elseif stats.pTier == 3 then
                if player.cDown > 0 and not sCool then
                    table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
                    table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
                    table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
                    sCool = true
                end
                if player.cDown > 0.05 then
                    player.cDown = 0
                    sCool = false
                end
            end
        else
            sCool = false
            isShoot = false
        end
    else
    end

    if pParticle and not isAutoFire then
        player.cDown = player.cDown + dt
    end

    if player.cDown > 0.05 and pParticle and not isAutoFire then
        pParticle = false
        player.cDown = 0
    end
    
    --TODO: Add laser shot type when player is slowed down
    if isSlow then
        player.vx, player.vy = 110, 110
    else
        player.vx, player.vy = 200, 200
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
    
    if isAutoFire then
        if love.keyboard.isDown(keys.shoot) then
            isShoot = true  
        else
            isShoot = false
        end

        if isShoot then
            player.cDown = player.cDown + dt
        end
    end
    
    if love.keyboard.isDown(keys.slow) then
        isSlow = true
    else
        isSlow = false
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

function playerKey(key)
    if not isLoseLife then
        if key == keys.shoot and not isAutoFire then
            table.insert(pBlList_1, Bullet:new(player.x, player.y - 15, 5, 10, 700))
            table.insert(pBlList_2, Bullet:new(player.x + 10, player.y - 25, 5, 10, 700))
            table.insert(pBlList_3, Bullet:new(player.x + 20, player.y - 15, 5, 10, 700))
            isShoot = true
            pParticle = true
        end
        if key == keys.bomb and not isUseBomb and stats.bomb > 0 and player.bombCool < 1 then
            stats.bomb = stats.bomb - 1
            isUseBomb = true
            isShake = true
        end
    end
end

function playerBomb(v)
    if isUseBomb and player.bombCool <= 0.65 then
        v.hp = v.hp - 3
        table_clear(enemyBullet)
    end
end

function playerBombCool(dt)
    if player.bombCool <= 1 and isUseBomb then
        player.bombCool = player.bombCool + dt
        player.invis = true
    else
        isUseBomb = false
        player.bombCool = 0
    end

    if player.bombCool < 0.05 and isUseBomb and screenCol[1] < 0.25 and screenCol[2] < 0.25 and screenCol[3] < 0.25 then
        screenCol[1], screenCol[2], screenCol[3] = 0.25, 0.25, 0.25
    end
    if player.bombCool > 0.05 and isUseBomb and screenCol[1] > 0.05 and screenCol[2] > 0.05 and screenCol[3] > 0.05 then
        screenCol[1], screenCol[2], screenCol[3] = screenCol[1] - dt, screenCol[2] - dt, screenCol[3] - dt
    end

    -- stop screen shake effect for bomb
    if player.bombCool > 0.07 then
        isShake = false
    end

    if isLoseLife and screenCol[1] > 0.05 and screenCol[2] > 0.05 and screenCol[3] > 0.05 then
        screenCol[1], screenCol[2], screenCol[3] = screenCol[1] - dt, screenCol[2] - dt, screenCol[3] - dt
    else
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
        player.cDown = 0
        isShoot = false
        sCool = false
        isUseBomb = false
        isShake = true
        isSlow = false
    end

    -- stop screen shake effect
    if player.lostLifeCool > 0.07 and isLoseLife then
        isShake = false
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
        stats.bomb = 2
        stats.pTier = 1
    end
    
    -- prevent pausing game when lost
    if player.lostLifeCool > 0 and isLoseLife and stats.life < 1 then
        isPaused = false
        isPauseDelay = false
    end

    if player.lostLifeCool > 0.5 and isLoseLife and stats.life < 1 then
        -- pro player reflexes for this (?)
        isPaused = false
        isPauseDelay = false
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

        if player.iCool > 1 and isUseBomb then
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

function eBulletCol(obj)
    local hL, hR, hT, hB = hitbox.x, hitbox.x + hitbox.w, hitbox.y, hitbox.y + hitbox.h
    local objL, objR, objT, objB = obj.x, obj.x + obj.w, obj.y, obj.y + obj.h

    -- player object
    if hR > objL and hL < objR and hB > objT and hT < objB then
        player.dead = true
        isLoseLife = true
    end
end

-- player item collision
function playerItem(obj)
    local pL, pR, pT, pB = player.x, player.x + player.w, player.y, player.y + player.h
    local objL, objR, objT, objB = obj.x, obj.x + obj.w, obj.y, obj.y + obj.h

    if pR > objL and pL < objR and pB > objT and pT < objB then
        obj.get = true
    end
end

-- level objects drawing
function LevelDraw()
    -- items
    for _, v in ipairs(items) do
        v:draw()
    end
    
    --TODO: Add particles/effects when hit enemy (v:collision(enemies))
    -- enemy draw & dead function
    for i, v in ipairs(enemies) do
        v:draw()

        -- attempt to compare with "nil"
        if v.maxHP ~= nil then
            lifeBar(i, v)
        end
    end
    
    for _, v in ipairs(textEffect) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(v[1], v[2], v[3], v[4])
    end
    
    for i, v in ipairs(boss) do
        v:draw()

        lifeBar(i, v)
    end

    for _, v in ipairs(enemyBullet) do
        v:draw()
    end
end

-- level game loops
local next = next
function LevelUpdate(dt)
    -- update game time
    stats.gameTime = stats.gameTime + dt

    -- items
    for i, v in ipairs(items) do
        v:col()
        v:update(dt)
        if isFail == false and isLoseLife == false then
            playerItem(v)
        else
        end
        
        if v.get and v.itype == "p" then
            table.remove(items, i)
            table.insert(textEffect, {itemScore, monogram, v.x, v.y, true, 0})
            if stats.pTier < 3 then
                stats.pTier = stats.pTier + 1
                stats.score = stats.score + v.score
            else
                stats.score = stats.score + v.score + 300
            end
        end
        
        if v.get and v.itype == "b" then
            table.remove(items, i)
            table.insert(textEffect, {500, monogram, v.x, v.y, true, 0})
            stats.bomb = stats.bomb + 1
            stats.score = stats.score + v.score
        end
        
        if v.get and v.itype == "s" then
            table.remove(items, i)
            table.insert(textEffect, {200, monogram, v.x, v.y, true, 0})
            stats.score = stats.score + v.score
        end
    end
    
    -- change text if tier is 3
    if stats.pTier > 2 then
        itemScore = "500"
    else
        itemScore = {{1, 0.85, 0.25}, "T+"}
    end
        
    -- text effect
    for i, v in ipairs(textEffect) do
        if v[5] == true then
            v[6] = v[6] + dt
        end
        
        if v[5] == false then
            table.remove(textEffect, i)
        end
        
        if v[6] > 1.5 then
            v[5] = false
        end
    end
    
    -- enemies
    for i, v in ipairs(enemies) do
        if isFail == false and isLoseLife == false and player.invis == false then
            playerCol(v)
        else
        end

        -- enemy dead function
        v:despawn()
        
        -- enemy bomb damage
        playerBomb(v)
        
        if stage == "TEST_2" or stage == "TEST_3" then
            v:col()
            v:update(dt)
        else
        end
        
        if v.dead then
            table.remove(enemies, i)
            stats.combo = stats.combo + 1
            scoreFormula(v)
            stats.enemies = stats.enemies + 1
            comboTime = 0
        end

        if v.item == "p" and v.dead then
            table.insert(items, pItem:new(v.x + v.w / 2, v.y + v.h / 2, 15, 7, 200, "p"))
        end

        if v.item == "b" and v.dead then
            table.insert(items, pItem:new(v.x + v.w / 2, v.y + v.h / 2, 15, 7, 500, "b"))
        end

        if v.item == "s" and v.dead then
            table.insert(items, pItem:new(v.x + v.w / 2, v.y + v.h / 2, 15, 7, 200, "s"))
        end

        if v.item == "" and v.dead then
        end
    end

    for i, v in ipairs(boss) do
        if isFail == false and isLoseLife == false and player.invis == false then
            playerCol(v)
        else
        end

        v:despawn()

        playerBomb(v)

        if v.dead then
            table.remove(boss, i)
            stats.combo = stats.combo + 1
            scoreFormula(v)
            comboTime = 0
        end
    end

    -- checks is bosses is empty
    if next(boss) == nil then
        isBoss = false
    else
        isBoss = true
    end

    -- player bullet collision
    for i, v in ipairs(pBlList_1) do
        v:despawn()
        if v.dead then
            table.remove(pBlList_1, i)
        end

        for _, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
        for _, b in ipairs(boss) do
            v:collision(b)
        end
    end
    
    for i, v in ipairs(pBlList_2) do
        v:despawn()
        if v.dead then
            table.remove(pBlList_2, i)
        end

        for _, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
        for _, b in ipairs(boss) do
            v:collision(b)
        end
    end
    
    for i, v in ipairs(pBlList_3) do
        v:despawn()
        if v.dead then
            table.remove(pBlList_3, i)
        end

        for _, enemy in ipairs(enemies) do
            v:collision(enemy)
        end
        for _, b in ipairs(boss) do
            v:collision(b)
        end
    end    

    for i, v in ipairs(enemyBullet) do
        if isFail == false and isLoseLife == false and player.invis == false then
            eBulletCol(v)
        else
        end
        
        v:update(dt)
        v:despawn()

        if v.dead then
            table.remove(enemyBullet, i)
        end
    end
end

function statsFunc()
    if stats.score > stats.hScore then
        stats.hScore = stats.score
    end

    if stats.combo > stats.mCombo then
        stats.mCombo = stats.combo
    end

    if stats.life > 0 and stats.score >= stats.exLife then
        stats.life = stats.life + 1
        stats.exLife = stats.exLife + 350000
        isExtend = true
        Etimer = 0
    end
end

-- score function
function scoreFormula(v)
    if stats.combo > 3 then
        if isUseBomb == false then
            scoreCombo = 10 * (stats.combo - 3)
            stats.score = stats.score + v.score + scoreCombo
        else
            scoreCombo = 7 * (stats.combo - 3)
            stats.score = stats.score + v.score + scoreCombo
        end
    else
        stats.score = stats.score + v.score
    end
end

function comboCooldown(dt)
    if stats.combo > 0 then
        comboTime = comboTime + dt
    end
    if comboTime > 2 then
        stats.combo = 0
        scoreCombo = 0
        comboTime = 0
    end
end
