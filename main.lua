Camera = require 'lib/hump/camera'
Class = require 'lib/hump/class'
Gamestate = require 'lib/hump/gamestate'
Signals = require 'lib/hump/signal'
Timer = require 'lib/hump/timer'
vector = require 'lib/hump/vector'

require 'lib/util'
require 'lib/heap'

require 'class/player'
require 'class/simSeed'
require 'class/wall'
require 'class/plants/mushroom'
require 'class/plants/bridge'
require 'class/plants/dropper'
require 'class/plants/checkpoint'
require 'class/obstacles/laser'
require 'class/obstacles/fan'
require 'class/seed'
require 'class/view'
require 'class/level'

require 'states/editor'
require 'states/game'
require 'states/menu'

function love.load()
	Gamestate.registerEvents()
  Gamestate.switch(Game)
end

function love.run()
	math.randomseed(os.time())
	math.random()

	tick = 0
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
