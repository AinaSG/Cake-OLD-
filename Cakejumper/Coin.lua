Coin = {}

--Constructor
function Coin:new(cx, cy, cvalue) --Pos x, i pos Y; Valor de la moneda, opcional.s
	local object ={
		x = cx,
		y = cy,
		value = cvalue or 100
	}
	setmetatable(object, { __index = Coin})
	return object
end

function Coin:update(dt)
end

function Coin:draw(offset)
end