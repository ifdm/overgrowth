Wall = Class {
	name = 'Wall',
	
	components = {PhysicsComponent, DrawComponent}
}

Wall:include(Entity)

function Wall:init()
	Entity.init(self)
end