Platform = {}


function Platform:new(cx, cy, num)
	num = num or 2
	local object = {
		x = cx,
		y = cy,
		num_tiles = num,
		width = num * 32,
		height = 32,
		collisions = true
	}
	setmetatable(object, { __index = Platform})
	return object
end

function Platform:update(dt)
end

function Platform:draw()
	-- primer tile
	love.graphics.setColor(100,0,0)
    love.graphics.rectangle("fill", self.x, self.y, 32, self.height)
    -- tiles intermitjos
    love.graphics.setColor(0,100,0)
    love.graphics.rectangle("fill", self.x + 32, self.y, self.width - 64, self.height)
    --ultim tile
    love.graphics.setColor(0,0,100)
    love.graphics.rectangle("fill", self.x + self.width - 32, self.y, 32, self.height)
end