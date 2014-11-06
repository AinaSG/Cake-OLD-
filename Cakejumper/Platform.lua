Platform = {}


function Platform:new(cx, cy, num)
	num = num or 2
	local object = {
		objectType = "platform",
		x = cx,
		y = cy,
		num_tiles = num,
		width = num * 32,
		height = 32,
		collisions = true,
		sprite = love.graphics.newImage("Sprites/tileg.png"),
		leftSprite = love.graphics.newQuad(0, 0, 32, 32, 96, 32),
		centerSprite = love.graphics.newQuad(32, 0, 32, 32, 96, 32),
		righSprite = love.graphics.newQuad(64, 0, 32, 32, 96, 32)
	}
	setmetatable(object, { __index = Platform})
	return object
end

function Platform:update(dt)
end

function Platform:draw(offset)
    love.graphics.setColor(255, 255, 255)
    --Primer Tile
    love.graphics.draw(self.sprite, self.leftSprite, self.x, self.y + offset)
    --Tiles Centrals
    local num_central_tiles = self.num_tiles - 2
    for i = 1, num_central_tiles do
    	love.graphics.draw(self.sprite, self.centerSprite, self.x + (32*i), self.y + offset)
  	end
  	--Ultim Tile
    love.graphics.draw(self.sprite, self.righSprite, self.x + self.width - 32, self.y + offset)
end