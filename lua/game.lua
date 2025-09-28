local pBullet = require("lua.obj.pBullet")
local pBl = pBullet:new(player.x, player.y, 5, 10, 20)

function gameDisplay()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
    if isShoot then
        pBl:shoot()
    end
end

function playerFunc(dt)
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
    end
    
    -- collision
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
    
    if isShoot then
        pBl:move()
    end
end