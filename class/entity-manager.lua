EntityManager = Class {}

function EntityManager:init()
	self.entities = {}
end

function EntityManager:update()
	table.with(self.entities, f.ego('update'))
end

function EntityManager:draw()
	table.with(self.entities, f.ego('draw'))
end

function EntityManager:register(entity)
	table.insert(self.entities, entity())
end