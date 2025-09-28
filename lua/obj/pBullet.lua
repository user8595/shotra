-- player bullet
local pBullet = {
    x = x,
    y = y,
    w = w,
    h = h,
    ySpeed = 500,
    dead = false
}

function pBullet:new(x, y, w, h)
    local bl = {
        x = x,
        y = y,
        w = w,
        h = h,
    }
    setmetatable(bl, self)
    self.__index = self
    return bl
end

function pBullet:move(dt)
    self.y = self.y - dt * self.ySpeed
end

function pBullet:despawn()
    if self.y < -50 then
        self.dead = true
    end
end

-- player shoot function
function pBullet:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

-- return table values
return pBullet