Game = {}

function Game:enter()
	entityManager = EntityManager()
	entityManager:register(Player)
end

function Game:update()
	entityManager:update()
end

function Game:draw()
	entityManager:draw()
end

function Game:mousereleased(x, y, button)
	--
end

function Game:keyreleased(key)
	--
end