ControlComponent = {
	name = 'ControlComponent'
}

function ControlComponent:keypressed(key)
	if self.controls.keypressed[key] then
		self[self.controls.keypressed[key]](self, key)
	end
end

function ControlComponent:keyreleased(key)
	if self.controls.keyreleased[key] then
		self[self.controls.keyreleased[key]](self, key)
	end
end