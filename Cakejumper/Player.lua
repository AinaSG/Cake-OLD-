Player = {}

--Constructor
function Player:new(cX, cY, cWidth, cHeight)
	local object = {
    	x = cX or 0,
    	y = cY or 0,
    	width = cWidth or 25,
    	height = cHeight or 40,
    	xSpeed = 0,
    	ySpeed = -1,
    	state = "",
    	jumpSpeed = -800,
    	runSpeed = 5000,
    	friction = 10,
    	canJump = false,
    	color = {255,0,128}
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
    if self.y < 0 then self.y = 0 end
    if self.y > yFloor - self.height then
        self:hitFloor(yFloor)
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

--Draw
function Player:draw()
	local x = math.floor(self.x)
    local y = math.floor(self.y)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", x, y, self.width, self.height)
end