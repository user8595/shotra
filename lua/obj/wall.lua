-- test enemy
local wall = {
    x = x,
    y = y,
    vx = 200,
    vy = 200,
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

-- wall bounce update & collision
function wall:update(dt)
    self.x, self.y = math.floor(self.x + dt * self.vx), math.floor(self.y + dt * self.vy)
end

function wall:col()
    sL, sR, sT, sB = self.x, self.x + self.w, self.y, self.y + self.h
    if sR > gameWorld.x + gameWorld.w then
        self.x = math.floor(gameWorld.x + gameWorld.w - self.w)
        self.vx = -self.vx
    elseif sL < gameWorld.x then
        self.x = math.floor(gameWorld.x)
        self.vx = -self.vx
    elseif sB > gameWorld.h then
        self.y = math.floor(gameWorld.h - self.h)
        self.vy = -self.vy
    elseif sT < 0 then
        self.y = math.floor(0)
        self.vy = -self.vy
    end
end

function wall:back(dt)
    self.y = math.floor(self.y + dt * self.vy)
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