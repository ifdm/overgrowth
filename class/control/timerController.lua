--[[
	Simple utility class created. We'll soon want triggers and sequencing of timers, triggers, and objects.
]]

TimerController = Class{}


function TimerController:init(func, period)
	self.call = fun
	self.period = period
	self.tick = 0
	self.paused = false
	self.timeOut = 0

	objects[#objects + 1] = self
end


function TimerController:update()
	if self.timeOut > 0 then 
		self.timeOut = self.timeOut - 1
		return
	end
	if self.paused == true then return end
	self.tick = self.tick + 1
	if (self.tick % period) == 1 then
		self.call()
	end
end


function TimerController:setPaused(p)
	self.paused = p
end

function TimerController:timeOut(numTicks)
	self.timeOut = numTicks
end

