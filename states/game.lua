Game = {}

function Game:enter()
	entityManager = EntityManager()
	entityManager:register(Level)
	entityManager:register(Player)
	entityManager:register(Mushroom)
	entityManager:register(Wall)

	Editor:init()
	self.editing = true
end

for _, action in pairs(actions) do
	Game[action] = function(self, ...)
		f.exe(entityManager[action], entityManager, ...)
		f.exe(self.editing and Editor[action], Editor, ...)
	end
	Game.init = f.empty()
end