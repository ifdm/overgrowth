View = Class {}

function View:init(object)
	self.object = object
	self.prevX = 0
	self.prevY = 0
	self.w = love.graphics.getWidth()
	self.h = love.graphics.getHeight()
	self.camera = Camera()

	self.camera:zoomTo(.75, .75)
end

function View:update()	
	local px, py = self.object.body:getX(), self.object.body:getY()
	local mx, my = self.camera:mousepos()
	local cx, cy = self.camera:pos()

	self.prevX = cx
	self.prevY = cy
	cx = math.lerp(cx, (px + mx) / 2, .25)
	cy = math.lerp(cy, (py + my) / 2, .25)
	
	cx, cy = cx - 400, cy - 300
	if px - cx > (self.w * .80) then cx = px - (self.w * .80) end
	if py - cy > (self.h * .80) then cy = py - (self.h * .80) end
	if (cx + self.w) - px > (self.w * .80) then cx = px + (self.w * .80) - self.w end
	if (cy + self.h) - py > (self.h * .80) then cy = py + (self.h * .80) - self.h end
	if cx < 0 then cx = 0 end
	if cy < 0 then cy = 0 end
	cx, cy = cx + 400, cy + 300
	
	self.camera:lookAt(cx, cy)
end

function View:draw(fn)
	local z = tickDelta / tickRate
	local cx, cy = self.camera:pos()
	self.camera.x = math.lerp(self.prevX, cx, z)
	self.camera.y = math.lerp(self.prevY, cy, z)
	self.camera:draw(fn)
	self.camera.x = cx
	self.camera.y = cy
end
