Menu = {}

function Menu.load()
	local button = loveframes.Create("button")
	button:SetSize(100, 15)
	button:SetPos(5, 5)
	button:SetText("Start Game")
	button.OnClick = function(object)
		contextSwitch(Game)
	end
end

function Menu.unload()

end

function Menu.update()
	loveframes.update(dt)
end

function Menu.draw()
	loveframes.draw()
end

function Menu.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function Menu.mousereleased(x, y, button)

	-- your code

	loveframes.mousereleased(x, y, button)

end

function Menu.keypressed(key)
	loveframes.keypressed(key)
end

function Menu.keyreleased(key)
	-- your code
	loveframes.keyreleased(key)
end