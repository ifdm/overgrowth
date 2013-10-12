LevelEditorComponent = {
	name = 'LevelEditorComponent'
}

function LevelEditorComponent:init()
	self.editor = Editor({Wall})
	self.editing = true
end

function LevelEditorComponent:update()
	f.exe(self.editing and self.editor.update, self.editor)
end

function LevelEditorComponent:draw()
	f.exe(self.editing and self.editor.draw, self.editor)
end

function LevelEditorComponent:keyreleased(key)
	if key == ' ' then self.editing = not self.editing end
end