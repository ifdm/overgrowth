LevelEditorComponent = {
	name = 'LevelEditorComponent'
}

function LevelEditorComponent:init()
	self.editor = Editor()
	self.editing = true
end

function LevelEditorComponent:update()
	self.editor:update()
end