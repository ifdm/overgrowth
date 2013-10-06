LevelPhysicsComponent = {
	name = 'LevelPhysicsComponent'
}

function LevelPhysicsComponent:init()
	self.world = love.physics.newWorld(0.0, 1.0, true)
end

function LevelPhysicsComponent:update()
	self.world:update(tickRate)
end