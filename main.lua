require './lib/core'
require './lib/util'

function love.load()
	--
end

function love.update(dt)
	--
end

function love.draw()
	--
end

function love.mousepressed(x, y, button)
	--
end

function love.keypressed(key)
	--
end

function love.run()
	math.randomseed(os.time())
	math.random()

	tickRate = .02
	tickDelta = 0

	if love.load then love.load(arg) end

	local dt = 0
	while true do
		love.timer.step()
		local delta = love.timer.getDelta()

		love.event.pump()
		for e, a, b, c, d in love.event.poll() do
			if e == 'quit' then if love.quit then love.quit() end love.audio.stop() return
			else love.handlers[e](a, b, c, d) end
		end

		tickDelta = tickDelta + delta
		while tickDelta >= tickRate do
			tickDelta = tickDelta - tickRate
			love.update()
		end
    
		love.graphics.clear()
		love.draw()
		love.graphics.present()
    
		love.timer.sleep(.001)
	end
end
