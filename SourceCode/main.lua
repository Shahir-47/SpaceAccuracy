function love.load()
    -- load all the .lua pages, bakcground, objects and starting music
    Object = require "classic"
    require "player"
    require "bullet"
    require "enemy"
    background = love.graphics.newImage("images/1268183.jpg")
    player = Player()
    enemy = Enemy()
    bullets = {}
    starting = love.audio.newSource("audio/startingsong.mp3", "stream")
    starting:play()
    gamestate = 'start'
    count = 0
end

function love.keypressed(key)
    player:keyPressed(key)
    -- if a is pressed the starting sondtrack finishes and the game is ready to be played along with background music
    if key == 'a' then
        gamestate = 'play'
        starting:stop()
        musical = love.audio.newSource("audio/man.wav", "static")
        musical:play()
    end
    
end

function love.update(dt)
    -- once the game is on play state, each objects does it asks e.g enemy bouncing and player moving upon keys
    if gamestate == 'play' then
        player:update(dt)
        enemy:update(dt)
        for i,v in ipairs(bullets) do
            v:update(dt)
        end
    -- restart the game by pressing r
    elseif gamestate == 'end' then
        if love.keyboard.isDown('r') then
            love.load()
        end
    end
end

function love.draw()
    -- game over background
    if gamestate == 'end' then
        for i = 0, love.graphics.getWidth() / background:getWidth() do
        
            for j = 0, love.graphics.getHeight() / background:getHeight() do
            
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        
            end
    
        end
        Font = love.graphics.newFont('font/BabySchoolItalic.ttf', 70)
        smallFont = love.graphics.newFont('font/BabySchoolItalic.ttf', 30)
        love.graphics.setFont(Font)
        love.graphics.printf('GAME OVER', 0, love.graphics.getHeight()/3, love.graphics.getWidth(), 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Score : ' .. count, 0, love.graphics.getHeight()/2, love.graphics.getWidth(), 'center')
        love.graphics.printf('Press r to restart', 0, love.graphics.getHeight()/1.5, love.graphics.getWidth(), 'center')
    -- start menu background
    elseif gamestate == 'start' then
        for i = 0, love.graphics.getWidth() / background:getWidth() do
        
            for j = 0, love.graphics.getHeight() / background:getHeight() do
            
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        
            end
    
        end
        Font = love.graphics.newFont('font/BabySchoolItalic.ttf', 70)
        smallfont = love.graphics.newFont('font/BabySchoolItalic.ttf', 20)
        love.graphics.setFont(smallfont)
        love.graphics.printf('Controls : Arrow keys to move left or right and space key for shooting', 0, love.graphics.getHeight()/1.25, love.graphics.getWidth(), 'center')
        love.graphics.printf('Made by Shahir Ahmed', 0, love.graphics.getHeight()/2, love.graphics.getWidth(), 'center')
        love.graphics.printf('Press a to begin', 0, love.graphics.getHeight()/1.5, love.graphics.getWidth(), 'center')
        love.graphics.setFont(Font)
        love.graphics.printf('Space Accuracy', 0, love.graphics.getHeight()/3, love.graphics.getWidth(), 'center')
    -- rendering of 'play' game
    elseif gamestate == 'play' then
        for i = 0, love.graphics.getWidth() / background:getWidth() do
        
            for j = 0, love.graphics.getHeight() / background:getHeight() do
            
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        
            end
    
        end
    
        player:draw()
    
        enemy:draw()

       -- draws bullets in a list and passes the enemy as object to detect collsion and then removes the bullets if collision
        for i,v in ipairs(bullets) do
        
            v:draw()
        
            v:checkCollision(enemy)

        
            if v.dead then
                table.remove(bullets, i)
        
            end
    
        end
        -- current score during match
        smallfont = love.graphics.newFont('font/BabySchoolItalic.ttf', 20)
        love.graphics.setFont(smallfont)
        love.graphics.printf("Score : " .. count, 0, 20, love.graphics.getWidth(), 'left')
    end
end