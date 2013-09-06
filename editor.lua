
--Currently completely empty

editor = {}

function editor.load()

end


function editor.draw()
	game.draw()
	drawGrid()
end	


function editor.update(dt)

end


function editor.keypressed(key)
	if key == " " then
		contextswitch(game)
	end
end


function editor.mousepressed(x, y, button)
    if button == "l" then
	   level.terrain:setPoint(x, y)
    elseif button == "r" then
        level.terrain:clearPoint(x)
    elseif button == "wd" then
        camera.scale(1.5)
    elseif button == "wu" then
        camera.scale(0.75)
    end
end


function drawGrid()

    love.graphics.setColor(255, 255, 255, 100)
    for x = 0, level.width, 50 do

        love.graphics.line(x, 0, x, level.height)
    end

    for y = 0, level.height, 50 do
        love.graphics.line(0, y, level.width, y)
    end

end


function editor.exit()

end

function editor.enter()


end


