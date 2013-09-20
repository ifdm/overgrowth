Checkpoint = Class{
	--name = "Checkpoint",
	active = nil,
	activeID = nil,
	gid = 0

}

function Checkpoint.create(x, y)
	Checkpoint(x, y)

end

function Checkpoint:init(x, y)
	self.body = love.physics.newBody(world, x-32, y-60, 'static')
	self.shape = love.physics.newPolygonShape(0, 0, 64, 0, 64, 120, 0, 120)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self.fixture:setUserData(self)
	self.fixture:setSensor(true)
	self.id = Checkpoint.gid + 1
	Checkpoint.gid = self.gid + 1
	Checkpoint.activeID = self.id
	Checkpoint.active = self

	objects[#objects + 1] = self

end


function Checkpoint:destroy()
	self.body:destroy()
	self.fixture:destroy()

end



function Checkpoint:handleCollision(object, nX, nY, x, y)
	if object.name == "Player" then
		Checkpoint.active = self
		Checkpoint.activeID = self.id
	end
end


function Checkpoint:draw()
	love.graphics.reset()
	if self.activeID == self.id then
		love.graphics.setColor(0, 0, 120, 100)
	else
		love.graphics.setColor(120, 0, 0, 50)
	end
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))

end