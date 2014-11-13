Background = {}

--Constructor
function Background:new()
	local object ={
		objectType = "background",
		x = 0,
		y = 0,
		ft_voffset = 0,
		bg_voffset = 0,
		sprite = love.graphics.newImage("Sprites/backgrounds.png"),
		sky = love.graphics.newQuad(1152, 0, 384, 622, 1536, 622),
		clouds = love.graphics.newQuad(768, 0, 384, 622, 1536, 622),
		bg_hills = love.graphics.newQuad(384, 0, 384, 622, 1536, 622),
		ft_hills = love.graphics.newQuad(0, 0, 384, 622, 1536, 622),
		toDestroy = false
	}
	setmetatable(object, { __index = Background})
	return object
end

function Background:update(dt, offset)
	self:getvOffset(dt, offset)
end

function Background:draw(offset)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.sprite, self.sky, 0, 0)
	love.graphics.draw(self.sprite, self.clouds, 0, 0)
	love.graphics.draw(self.sprite, self.bg_hills, 0, 0 + bg_voffset)
	love.graphics.draw(self.sprite, self.ft_hills, 0, 0 + ft_voffset)
end

function Background:getvOffset(dt, offset)
 	local pp = -offset--self.players[1].y
 	bg_voffset = math.max(-50, math.min ( 0, math.floor(pp*0.02))) --math.max(0,(-math.floor( math.lerp( (1 - pp), 0, dt))*0.01))
 	ft_voffset = math.min(85, math.max ( 0, -math.floor(pp*0.05))) -- math.floor( math.lerp( 0, 2, dt*5))
 end 


function Background:destroy()
	self.toDestroy = true
end