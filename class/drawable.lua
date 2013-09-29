Drawable = {
	name = 'Drawable'
}

function Drawable:draw()
	love.graphics.draw(self.sprite, self.x, self.y, self.angle, self.scaleX, self.scaleY)
end