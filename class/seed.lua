Seed = Class {
	name = 'Seed',
	
	components = {PhysicsComponent, DrawComponent}
}

Seed:include(Entity)

function Seed:init()
	Entity.init(self)
end