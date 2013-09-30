Game = {}

function Game:enter()
	self.entityManager = EntityManager()
	
	local p = self.entityManager:register(Player)
	p.state.pos.x = 3 * unitSize
	p.state.pos.y = 2 * unitSize
	
	local g = entityManager:register(Wall)
	g.state.pos.x = 0 * unitSize
	g.state.pos.y = 18 * unitSize
	g.state.mask.width = 25
	
	local s = entityManager:register(Seed)
	s.state.pos.x = 20 * unitSize
	s.state.pos.y = 9 * unitSize
end

for _, action in pairs(actions) do
	Game[action] = function(self) f.exe(self.entityManager[action], self.entityManager) end
	Game.init = f.empty()
end