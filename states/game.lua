Game = {}

function Game:enter()
	self.entityManager = EntityManager()
	
	local p = self.entityManager:register(Player)
	p.state.pos.x = 3 * unitSize
	p.state.pos.y = 2 * unitSize
	
	local w = self.entityManager:register(Wall)
	w.state.pos.x = 10 * unitSize
	w.state.pos.y = 10 * unitSize
end

for _, action in pairs(actions) do
	Game[action] = function(self) f.exe(self.entityManager[action], self.entityManager) end
	Game.init = f.empty()
end