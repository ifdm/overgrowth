Game = {}

function Game:enter()
	self.level = Level('/levels/default.lua')
	table.print(self.level.entities)
	self.entities = EntityManager(self.level.entities)
	self.editor = Editor

	self.paused = false
	self.editing = true
end

function Game:update()
	if self.paused then return end

	self.level:update()
	self.entities:update()
	if self.editing then self.editor:update() end
end

function Game:draw()
	self.entities:draw()
	if self.editing then self.editor:draw() end
	if math.lineDistance(love.mouse:getX(), love.mouse:getY(), 0, 400, 800, 400) < 100 then
		love.graphics.setColor(0, 255, 0)
	else
		love.graphics.setColor(255, 0, 0)
	end
	love.graphics.line(0, 400, 800, 400)
end

function Game:keypressed(key)
	self.entities:keypressed(key)
end

function Game:keyreleased(key)
	if key == 'r' then
		self.entities:destroy()
		self.entities = EntityManager(self.level.entities)
	elseif key == 'p' then
		self.paused = not self.paused
	end

	self.entities:keyreleased(key)
end
