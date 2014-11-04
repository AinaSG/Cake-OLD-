Platform = {}


function Platform:new(cx, cy, num)
	local object = {
		x = cx,
		y = cy,
		num_tiles = num or 2
	}
	setmetatable(object, { __index = Platform})
	return object
end

function Platform:update(dt)
end

function Platform:draw()
end