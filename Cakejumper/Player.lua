Player = {}

--Constructor
function Player:new(cX, cY, cWidth, cHeight, cid) -- Pos x, Posy, Amplada i alçada, tot opcional 
	local object = {
		objectType = "player",
		name = cid,
    	x = cX or 0,
    	y = cY or 0,
    	width = cWidth or 25,
    	height = cHeight or 40,
    	xSpeed = 0,
    	ySpeed = 0,
    	state = "",
    	jumpSpeed = -800,
    	runSpeed = 5000,
    	friction = 10,
    	canJump = false,
    	color = {255,0,128},
    	collisions = true,
    	toDestroy = false,
    	score = 0
	}
	setmetatable(object, { __index = Player})
	return object
end

--Moviment
function Player:jump()
	if self.canJump then
		self.ySpeed = self.jumpSpeed
		self.canJump = false
	end
end

function Player:moveRight(dt)
	self.xSpeed = self.xSpeed + (self.runSpeed * dt)
	self.xSpeed = math.min(self.xSpeed, self.runSpeed)
	self.state = "moveRight"
end

function Player:moveLeft(dt)
	self.xSpeed = self.xSpeed - (self.runSpeed * dt)
	self.xSpeed = math.max(self.xSpeed, -self.runSpeed)
	self.state = "moveLeft"
end

function Player:stop()
	self.xSpeed = 0
end

function Player:hitFloor(maxY)
	self.y = maxY - self.height
	self.ySpeed = 0
	self.canJump = true
end

--Update
function Player:update(dt)
	--Posició
	self.x = self.x + (self.xSpeed * dt)
	self.y = self.y + (self.ySpeed * dt)

	--Gravetat
	self.ySpeed = self.ySpeed + (gravity * dt)
	self.xSpeed = self.xSpeed * (1 - math.min(dt * self.friction, 1))

	--Update estat
	if not (self.canJump) then
		if self.ySpeed < 0 then
			self.state = "jump"
		elseif self.ySpeed > 0 then
				self.state = "fall"
		end
	else
		if self.xSpeed > 0 then
			self.state = "moveRight"
		elseif self.xSpeed < 0 then
			self.state = "moveLeft"
		else
			self.state = "stand"
		end
	end

	--------------

	if self.x > screenWidth - self.width then self.x = screenWidth - self.width end
    if self.x < 0 then self.x = 0 end
    --if self.y < 0 then self.y = 0 end
    if self.y > screenHeight - self.height then
        self:hitFloor(screenHeight)
    end

    --------------

    if love.keyboard.isDown("d") then
        self:moveRight(dt)
    end
    if love.keyboard.isDown("a") then
        self:moveLeft(dt)
    end
 
    -- si x apretat...
    if love.keyboard.isDown("w") then
    -- salta!
        self:jump()
    end 
end

function Player:checkCollision(obj)
	if (obj.objectType == "platform") then
		if (self.ySpeed > 0 
			and (self.y + self.height > obj.y 
				and self.y + self.height < obj.y + obj.height)
			and ((self.x + self.width > obj.x) 
				and (self.x < obj.x + obj.width)))then 
			self:hitFloor(obj.y) 
		end
	elseif (obj.objectType == "coin" and not obj.toDestroy) then
		if ((self.x + self.width > obj.x and self.x < obj.x + obj.width or 
			self.x + self.width < obj.x and self.x > obj.x +obj.width) and 
			(self.y + self.height > obj.y and self.y < obj.y + obj.height or 
			self.y + self.height < obj.y and self.y > obj.y +obj.height)) then
			self.score = self.score + 1
			obj:destroy();
		end
	end
end

--Draw
function Player:draw(offset)
	local x = math.floor(self.x)
    local y = math.floor(self.y)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", x, y + offset , self.width, self.height)
end

function Player:destroy()
	self.toDestroy = true
end