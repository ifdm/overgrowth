Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'

require 'class/player'

function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 10 * 64, true)
	player = Player()
end

function love.update()
	world:update(tickRate)
	player:update()
end

function love.draw()
	player:draw()
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
