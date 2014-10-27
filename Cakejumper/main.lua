require "Player"
require "Scene"
  gravity = 2800  
  yFloor = 500
function love.load()

  sene = Scene:new("main")
  p = Player:new(0,0,25,40)
  sene:addObject(p)

    groundColor = {25,200,25}

    -- creem player, donem valors 
end

function love.update(dt)
  sene:update(dt)
end

function love.draw()
	-- arrodonir x i y


    sene:draw()


    love.graphics.setColor(groundColor)
    love.graphics.rectangle("fill", 0, yFloor, 800, 100)
 
    -- debug
    love.graphics.setColor(255, 255, 255)
    local isTrue = ""
   -- love.graphics.print("Player coordinates: ("..x..","..y..")", 5, 5)
    --love.graphics.print("Current state: "..p.state, 5, 20)
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