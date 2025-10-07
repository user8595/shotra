-- player bullet
local Bullet = {
    x = x,
    y = y,
    w = w,
    h = h,
    ySpeed = ySpeed,
    dead = false
}

-- new object
function Bullet:new(x, y, w, h, ySpeed)
    local bl = {
        x = x,
        y = y,
        w = w,
        h = h,
        ySpeed = ySpeed
    }
    setmetatable(bl, self)
    self.__index = self
    return bl
end

-- move bullet
function Bullet:move(dt)
    self.y = math.floor(self.y - dt * self.ySpeed)
end

function Bullet:collision(obj)
    selfL = self.x
    selfR = self.x + self.w
    selfT = self.y
    selfB = self.y + self.h

    objL, objR, objT, objB = obj.x, obj.x + obj.w, obj.y, obj.y + obj.h

    --TODO: Increase bullet damage when autofire is disabled
    if selfR > objL and selfL < objR and selfB > objT and selfT < objB then
        self.dead = true
        obj.hp = obj.hp - 2
    end
end

-- remove bullet when offscreen
function Bullet:despawn()
    if self.y < -50 then
        self.dead = true
    end
    if self.y > gHeight + 50 then
        self.dead = true
    end
end

-- player shoot function
function Bullet:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

-- return table values
return Bullet