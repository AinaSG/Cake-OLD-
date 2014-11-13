Coin = {}

--Constructor
function Coin:new(cx, cy) --Pos x, i pos Y; Valor de la moneda, opcional.s
	local object ={
		objectType = "coin",
		x = cx,
		y = cy,
		width = 16,
		height = 16,
		collisions = true,
		toDestroy = false
	}
	setmetatable(object, { __index = Coin})
	return object
end

function Coin:update(dt)
end

function Coin:draw(offset)
	local x = math.floor(self.x)
    local y = math.floor(self.y)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill", x, y + offset , self.width, self.height)
end

function Coin:destroy()
	self.toDestroy = true
end