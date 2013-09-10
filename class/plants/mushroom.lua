Mushroom = Class {
	bounceSpeed = -5
}

function Mushroom.plant(x, y)
	local mushroom = {}
	setmetatable(mushroom, {__index = Mushroom})

	mushroom:init(x, y)
end


function Mushroom:init(x, y)
	print (""..world:type())
	local _body = love.physics.newBody(world, x, y, "static")
	self.body = _body
	self.body:setMass(15)
	self.shape = love.physics.newPolygonShape(0, 0, 150, 0, 150, 64, 0, 64)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)

	self.body:setFixedRotation(true)
	self.body:setLinearDamping(0)
	self.fixture:setRestitution(0)

	objects[#objects + 1] = self
end

function Mushroom:handleCollision(other, nX, nY)
	if nY > 0 then
		f.exe(other.bounce, other, self.bounceSpeed)
	end
end

function Mushroom:draw()
	love.graphics.reset()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end
