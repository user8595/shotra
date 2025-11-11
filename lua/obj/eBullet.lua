-- enemy bullets
local eBullet = {
    x = x,
    y = y,
    vx = vx,
    vy = vy,
    w = w,
    h = h,
    r = r,
    col = col,
    dead = false,
    bType = bType
}

function eBullet:new(x, y, vx, vy, w, h, r, col, bType)
    local eb = {
        x = x,
        y = y,
        vx = vx,
        vy = vy,
        w = w,
        h = h,
        r = r,
        col = col,
        bType = bType
    }
    setmetatable(eb, self)
    self.__index = self
    return eb
end

function eBullet:update(dt)
    self.x = math.floor(self.x + dt * self.vx)
    self.y = math.floor(self.y + dt * self.vy)
end

-- ayuda por favor
function eBullet:test1(dt)
    if self.bType == 1 then
        self.x = math.floor(self.x - dt * self.vx)
        self.y = math.floor(self.y + dt * self.vy)
    end

    if self.bType == 2 then
        self.y = math.floor(self.y + dt * self.vy)
    end

    if self.bType == 3 then
        self.x = math.floor(self.x + dt * self.vx)
        self.y = math.floor(self.y + dt * self.vy)
    end
    
    if self.bType == 4 then
        self.x = math.floor(self.x + dt * self.vx - 6.5)
        self.y = math.floor(self.y + dt * self.vy)
    end
    
    if self.bType == 5 then
        self.x = math.floor(self.x - dt * self.vx + 7.5)
        self.y = math.floor(self.y + dt * self.vy)
    end
end

function eBullet:despawn()
    if self.y > gHeight + 100 or self.y < -100 or self.x > gWidth + 100 or self.x < -100 then
        self.dead = true
    end
end

function eBullet:draw()
    if self.col == 1 then
        love.graphics.setColor(1, 1, 1)
    elseif self.col == 2 then
        love.graphics.setColor(1, 0.25, 0.25)
    elseif self.col == 3 then
        love.graphics.setColor(0.25, 1, 0.25)
    elseif self.col == 4 then
        love.graphics.setColor(0.25, 0.25, 1)
    elseif self.col == 5 then
        love.graphics.setColor(1, 1, 0.25)
    elseif self.col == 6 then
        love.graphics.setColor(0.25, 1, 1)
    elseif self.col == 7 then
        love.graphics.setColor(1, 0.25, 1)
    end

    love.graphics.draw(whitePixel, self.x, self.y, self.r, self.w, self.h, 0, 0, 0, 0)
end

return eBullet
