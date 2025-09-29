-- test enemy
local wall = {
    x = x,
    y = y,
    w = w,
    h = h,
    hp = hp,
    score = score,
    dead = false
}

function wall:new(x, y, w, h, hp, score)
    local wl = {
        x = x,
        y = y,
        w = w,
        h = h,
        hp = hp,
        score = score
    }
    setmetatable(wl, self)
    self.__index = self
    return wl
end

function wall:despawn()
    if self.hp <= 0 then
        self.dead = true
    end
end

function wall:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return wall