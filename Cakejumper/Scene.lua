Scene = {}

function Scene:new(names, players) --Nom de l'escena, opcional
	local object ={
		objectType = "scene",
		name = names or "Unnamed",
		drawing_offset = 0,
		ft_voffset = 0,
		bg_voffset = 0,
		objects = {},
		properties = {},
		players = players or {Player.new()},
		sprite = love.graphics.newImage("Sprites/backgrounds.png"),
		sky = love.graphics.newQuad(1152, 0, 384, 622, 1536, 622),
		clouds = love.graphics.newQuad(768, 0, 384, 622, 1536, 622),
		bg_hills = love.graphics.newQuad(384, 0, 384, 622, 1536, 622),
		ft_hills = love.graphics.newQuad(0, 0, 384, 622, 1536, 622)
	}
	setmetatable(object, { __index = Scene})
	return object
end

function Scene:update(dt)
	for ind, pl in pairs(self.players) do
 		pl:update(dt);
	end
	for ind, obj in pairs(self.objects) do
 		obj:update(dt);
 		if obj.collisions then
 			for i, pl in pairs(self.players) do
 				pl:checkCollision(obj);
			end
		end
	end
	self:getOffset(dt)
	--self:getvOffset(dt)
end

function Scene:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.sky, 0, 0)
	love.graphics.draw(self.sprite, self.clouds, 0, 0)
	love.graphics.draw(self.sprite, self.bg_hills, 0, 0 --[[+ bg_voffset]])
	love.graphics.draw(self.sprite, self.ft_hills, 0, 0 --[[+ ft_voffset]])
	for ind, obj in pairs(self.objects) do
 		obj:draw(self.drawing_offset);
	end
	for ind, pl in pairs(self.players) do
 		pl:draw(self.drawing_offset);
	end
end

function Scene:addObject(o)
	table.insert(self.objects, o)
end

function Scene:removeObject(o)
	for ind, obj in pairs(self.objects) do
		if (obj == o) then table.remove(self.objects, ind) end
	end
end

--[[function Scene:getvOffset(dt)
 	local pp = self.players[1].y
 	bg_voffset = math.max(0,(-math.floor( math.lerp( (1 - pp), 0, dt))*0.01))
 	ft_voffset = 0 -- math.floor( math.lerp( 0, 2, dt*5))
 -end ]]--

function Scene:getOffset(dt)
	local pp = self.players[1].y
	if pp < screenHeight/2 then
		--self.drawing_offset = screenHeight/2 - pp
		self.drawing_offset = math.floor(math.lerp(self.drawing_offset, (screenHeight/2 - pp), dt*5))
	else
		self.drawing_offset = math.floor(math.lerp(self.drawing_offset, 0, dt*5))
	end
end

function math.lerp(a, b, t)
    return a + (b - a) * t
end