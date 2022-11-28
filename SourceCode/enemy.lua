Enemy = Object:extend()
-- same as player load enemy model
function Enemy:new()
    self.image = love.graphics.newImage("images/alien.png")
    self.x = 325
    self.y = 450
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 100
end

function Enemy:update(dt)
    self.x = self.x + self.speed * dt

    window_width = love.graphics.getWidth()
    -- we cant let enemy leave so we make it bounce by reversing its speed direction
    if self.x < 0 then
        self.speed = -self.speed
        self.x = 0
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
        self.speed = -self.speed
    end
end

function Enemy:draw()
    love.graphics.draw(self.image, self.x, self.y)
end