-- player bullet
local pBullet = {
    x = player.x,
    y = player.y,
    w = w,
    h = h,
    ySpeed = ySpeed,
}

function pBullet:new(x, y, w, h, ySpeed)
    local bl = {
        x = x,
        y = y,
        w = w,
        h = h,
        ySpeed = ySpeed,
    }
    setmetatable(bl, self)
    self.__index = self
    return bl
end

function pBullet:move()
    self.y = self.y - self.ySpeed
end

-- player shoot function
function pBullet:shoot()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y + self.ySpeed, self.w, self.h)
end

-- return table values
return pBullet