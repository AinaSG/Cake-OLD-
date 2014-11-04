Scene = {}

function Scene:new(names, players) --Nom de l'escena, opcional
	local object ={
		name = names or "Unnamed",
		objects = {},
		properties = {},
		players = players or {Player.new()}
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
end

function Scene:draw()
	for ind, obj in pairs(self.objects) do
 		obj:draw();
	end
	for ind, pl in pairs(self.players) do
 		pl:draw();
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