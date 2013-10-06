DrawComponent = {
	name = 'DrawComponent'
}

function DrawComponent:draw()
	if #self.render then
		for _, v in ipairs(self.render) do love.graphics[v.fn](v.args(self)) end
	else	
		for k, v in pairs(self.render) do love.graphics[k](v(self)) end
	end
end