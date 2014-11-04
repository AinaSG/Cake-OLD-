Scene = {}

function Scene:new(names) --Nom de l'escena, opcional
	local object ={
		name = names or "Unnamed",
		objects = {},
		properties = {}
	}
	setmetatable(object, { __index = Scene})
	return object
end

function Scene:update(dt)
	for ind, obj in pairs(self.objects) do
 		obj:update(dt);
	end
end

function Scene:draw()
	for ind, obj in pairs(self.objects) do
 		obj:draw();
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