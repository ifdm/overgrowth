ControlComponent = {
	name = 'ControlComponent'
}

function ControlComponent:keyreleased(key)
	self[self.controls.keyreleased[key]]()
end