require "Player"
require "Scene"
require "Platform"
require "Background"

gravity = 2800  
yFloor = 500

function love.load()

  
  local p = Player:new(0,0,25,40)
  sene = Scene:new("main",{p})
  for i = 1, 40 do
    sene:addObject(Platform:new(i*10, screenHeight - i *  100, 3+i))
  end
  sene:addObject(Platform:new(0, 622-32, 384/32))
    groundColor = {25,200,25}

    -- creem player, donem valors 
end

function love.update(dt)
  sene:update(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  sene:draw()
end
 
function love.keyreleased(key)
    if key == "escape" then
        love.event.push("q")  -- actually causes the app to quit
    end
    if key == "p" then
       sene:removeObject(p)
    end
   -- if (key == "right") or (key == "left") then
   --     p:stop()
   -- end
end