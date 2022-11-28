Player = Object:extend()

function Player:new()
    -- load player model
    self.image = love.graphics.newImage("images/spaceShips_003.png")
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth()
end
-- key functions to control player as well as animation and sound effect of player
function Player:update(dt)
    if love.keyboard.isDown("left") then
        if gamestate == 'play' then
            musically = love.audio.newSource("audio/jump8.wav", "static")
            musically:setVolume(0.05)
            musically:play()
        end
        self.image = love.graphics.newImage("images/space2.png")
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        if gamestate == 'play' then
            musically = love.audio.newSource("audio/jump8.wav", "static")
            musically:setVolume(0.05)
            musically:play()
        end
        self.x = self.x + self.speed * dt
        self.image = love.graphics.newImage("images/space2.png")
    end

    -- make sure the player doesnt leave boundries
    window_width = love.graphics.getWidth()
    if self.x < 0 then
        self.x = 0
    
    elseif self.x + self.width > window_width then
        -- player's model still leaves the frame so minus it with its width ince self.c and self.y is the left sife of the player model
        self.x = window_width - self.width
    end
       
end
-- laser shooting function
function Player:keyPressed(key)


    --dont want the player shooting without the game starting
    if gamestate == 'play' then
        -- implementing laser gun and sound effects of laser
        if key == "space" then
        
            musically = love.audio.newSource("audio/Laser_Shoot55.wav", "static")
        
            musically:setVolume(0.5)
        
            musically:play()
            table.insert(bullets, Bullet(self.x, self.y))
        end
    end
end

function Player:draw()
-- draw player
love.graphics.draw(self.image, self.x, self.y) 
end