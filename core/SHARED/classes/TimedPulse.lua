TimedPulse = {};

function TimedPulse:constructor(time)
	local self = setmetatable({}, {__index = self})
	
	self.Timer = setTimer(bind(self.doPulse, self), time, 0)
	self.Handlers = {}
	
	return self;
end

function TimedPulse:destructor()
	if self.Timer and isTimer(self.Timer) then
		destroyElement(self.Timer)
	end
end

function TimedPulse:doPulse()
	for i, v in ipairs(self.Handlers) do
		v()
	end
end

function TimedPulse:registerHandler(callbackFunc)
	table.insert(self.Handlers, callbackFunc)
end

function TimedPulse:removeHandler(callbackFunc)
	local idx = table.find(self.Handlers, callbackFunc)
	if not idx then
		return false
	end
		
	table.remove(self.Handlers, idx)
	return true
end