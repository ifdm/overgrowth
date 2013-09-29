Game = {}

function Game:enter()
	entityManager = EntityManager()
	entityManager:register(Player, {
								state: {
								  pos: {
								    x = 3 * unitSize,
								    y = 2 * unitSize
								  }
							    }
							  })
	entityManager:register(Wall, {
								state: {
								  pos: {
								    x = 10 * unitSize,
								    y = 10 * unitSize
								  }
							    }
							  })
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