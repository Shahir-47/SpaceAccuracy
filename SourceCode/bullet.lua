Bullet = Object:extend()
-- loading bullets model
function Bullet:new(x, y)
    self.image = love.graphics.newImage("images/laserGreen1.png")
    self.x = x
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speed = 700
end



function Bullet:update(dt)
    self.y = self.y + self.speed * dt
    -- if bullet leaves the frame end the game
    if self.y > love.graphics.getHeight() then
        musical:stop()
        start = love.audio.newSource("audio/effect.mp3", "static")
        start:play()
        gamestate = 'end'
    end
end

function Bullet:checkCollision(spaceship)
    -- declaring all the sides of laser and enemy objects so later we can write if statements if they collide 
    spaceship_top = spaceship.y
    spaceship_bottom = spaceship.y + spaceship.height
    spaceship_right = spaceship.x + spaceship.width
    spaceship_left = spaceship.x
    bullet_top = self.y
    bullet_bottom = self.y + self.height
    bullet_right = self.x + self.width
    bullet_left = self.x

    -- all 4 scenarios where a bullet will collide with spaceship according to aabb collision
    if bullet_top < spaceship_bottom and bullet_bottom > spaceship_top and bullet_right > spaceship_left and bullet_left < spaceship_right then
        --high score count
        count = count + 1
        -- if bullet hits spaceship produce explosion sound and effect
        explosion = love.graphics.newImage("images/laserGreen_groundBurst.png")
        love.graphics.draw(explosion, self.x, self.y)
        musically = love.audio.newSource("audio/Explosion7.wav", "static")
        musically:setVolume(0.5)
        musically:play()
        self.dead = true

        -- if the player hits the enemy the game becomes much more difficult by increasing the speed of the enemy
        if spaceship.speed > 0 then
            spaceship.speed = spaceship.speed + 50
        else
            spaceship.speed = spaceship.speed - 50
        end

    end
end

function Bullet:draw()
    -- draw bullet
    love.graphics.draw(self.image, self.x, self.y)
end
