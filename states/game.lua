Game = {}

function Game:enter()
	self.level = Level('levels/default.lua')
	self.entities = EntityManager(self.level.entities)
	self.editor = Editor:init()

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
end

function Game:keypressed(key)
	if self.editing then self.editor:keypressed(key) end

	self.entities:keypressed(key)
end

function Game:keyreleased(key)
	if self.editing then self.editor:keyreleased(key) end

	if key == 'r' then
		self.entities:destroy()
		self.entities = EntityManager(self.level.entities)
	elseif key == 'p' then
		self.paused = not self.paused
	end

	self.entities:keyreleased(key)
end

function Game:mousepressed(x, y, button)
	if self.editing then self.editor:mousepressed(x, y, button) end
end

function Game:mousereleased(x, y, button)
	if self.editing then self.editor:mousereleased(x, y, button) end
end
