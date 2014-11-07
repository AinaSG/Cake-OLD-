Scene = {}

function Scene:new(names, players) --Nom de l'escena, opcional
	local object ={
		objectType = "scene",
		name = names or "Unnamed",
		drawing_offset = 0,
		objects = {},
		properties = {},
		backgrounds = {Background.new()},
		players = players or {Player.new()}
	}
	setmetatable(object, { __index = Scene})
	return object
end

function Scene:update(dt)
	self:getOffset(dt)
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
	for ind, bg in pairs(self.backgrounds) do
		bg:update(dt, self.drawing_offset)
	end
end

function Scene:draw()
	for ind, bg in pairs(self.backgrounds) do
		bg:draw(self.drawing_offset);
	end 
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