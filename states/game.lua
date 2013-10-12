Game = {}

function Game:enter()
	self.entityManager = EntityManager()
	self.entityManager:register(Level)
	self.entityManager:register(Player)
	self.entityManager:register(Wall)
	self.entityManager:register(Seed)
end

for _, action in pairs(actions) do
	Game[action] = function(self, ...) f.exe(self.entityManager[action], self.entityManager, ...) end
	Game.init = f.empty()
end