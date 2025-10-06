-- should i inherit enemy object
local boss = {
    x = x,
    y = y,
    vx = 100,
    vy = 100,
    w = w,
    h = h,
    hp = hp,
    maxHP = maxHP,
    score = score,
    dead = false,
}

function boss:new(x, y, w, h, hp, maxHP, score)
    local bo = {
        x = x,
        y = y,
        w = w,
        h = h,
        hp = hp,
        maxHP = maxHP,
        score = score,
    }
    setmetatable(bo, self)
    self.__index = self
    return bo
end

function boss:moveInit(dt)
    if self.y < gameWorld.y + 50 then
        self.y = self.y + dt * self.vy
    end
end

function boss:despawn()
    if self.hp <= 0 then
        self.dead = true
    end
end

function boss:draw()
    love.graphics.setColor(0.75, 0.75, 0.75)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return boss
