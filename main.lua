function love.load()
	require 'require'

	Gamestate.registerEvents()
	Gamestate.switch(Game)
end

function love.run()
	math.randomseed(os.time())
	math.random()

	tick = 0
	tickRate = .02
	tickDelta = tickRate

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
			tick = tick + 1
			love.update()
		end

		love.graphics.setBackgroundColor(20, 40, 20)
		love.graphics.clear()
		love.draw()
		love.graphics.present()

		love.timer.sleep(.001)
	end
end
