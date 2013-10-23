Game = {}

function Game:enter()
	self.level = Level('filename')
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
end