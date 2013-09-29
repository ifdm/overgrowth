DrawComponent = {
	name = 'DrawComponent'
}

function DrawComponent:draw()
	love.graphics.draw(self.sprite, self.x, self.y, self.angle, self.scaleX, self.scaleY)
end