require "Player"
require "Scene"
require "Platform"
require "Background"

gravity = 2800  
time_p = 0

function love.load()
  scene1 = love.graphics.newImage("Sprites/t1.png")
  scene2 = love.graphics.newImage("Sprites/t2.png")  
  p = Player:new(0,0,25,40, "Rectangle rosa")
  sene = Scene:new("main",{p})
  for i = 1, 40 do
    sene:addObject(Platform:new(i*10, screenHeight - i *  100, 3+i))
  end
  sene:addObject(Platform:new(0, 622-32, 384/32))
    groundColor = {25,200,25}
end

function love.update(dt)
  if (time_p < 2) then 
  elseif (time_p >= 2 and time_p < 4) then
  else
    sene:update(dt)
  end
  time_p = time_p + dt
end

function love.draw()
  if (time_p < 2) then
    love.graphics.draw(scene1, 0, 0)
  elseif (time_p >= 2 and time_p < 4.1) then
    love.graphics.draw(scene2, 0, 0)
  else
    love.graphics.setColor(255, 255, 255)
    sene:draw()
  end
end
 
function love.keyreleased(key)
    if key == "escape" then
        love.event.push("q")  -- actually causes the app to quit
    end
    if key == "p" then
       sene:removePlayer(p)
    end
end