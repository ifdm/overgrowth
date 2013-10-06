ControlComponent = {
	name = 'ControlComponent'
}

function ControlComponent:keyreleased(key)
	if self.controls.keyreleased[key] then
		self[self.controls.keyreleased[key]]()
	end
end