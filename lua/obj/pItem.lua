local powerItem = {
    x = x,
    y = y,
    w = w,
    h = h,
    vx = 75,
    vy = 75,
    score = score,
    get = false,
}

function powerItem:new(x, y, w, h, score)
    local it = {
        x = x,
        y = y,
        w = w,
        h = h,
        score = score,
    }
    setmetatable(it, self)
    self.__index = self
    return it
end

function powerItem:update(dt)
    self.x, self.y = self.x + dt * self.vx, self.y + dt * self.vy
end

function powerItem:col()
    sL, sR, sT, sB = self.x, self.x + self.w, self.y, self.y + self.h
    if sR > gameWorld.x + gameWorld.w then
        self.x = gameWorld.x + gameWorld.w - self.w
        self.vx = -self.vx
    elseif sL < gameWorld.x then
        self.x = gameWorld.x
        self.vx = -self.vx
    elseif sB > gameWorld.h then
        self.y = gameWorld.h - self.h
        self.vy = -self.vy
    elseif sT < 0 then
        self.y = 0
        self.vy = -self.vy
    end
end

function powerItem:draw(obj)
    love.graphics.setColor(1, 1, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return powerItem
