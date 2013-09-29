Controllable = {
	name = 'Controllable'
}

function Controllable:keyreleased(key)
	self[self.controls.keyreleased[key]]()
end