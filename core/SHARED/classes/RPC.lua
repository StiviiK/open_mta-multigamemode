RPC = {
	listeningEvents = {}
}

function RPC:addListeningEvent (event)
	if (self == RPC) then
		if (self.listeningEvents[event] ~= nil) then
			error("Attempt to add an existing ListenerEvent!", 2)
		end
	
		self.listeningEvents[event] = {}
		return true;
	end
	
	return false;
end

function RPC:addListener (eventName, element, func)
	if (not self.listeningEvents[eventName]) then
		error("Attempt to add an Listener to an unimplemented Event!", 2)
	end
	--assert(type(event) == "string")
	--assert(isElement(element))
	--assert(type(func) == "function")
	
	if (type(element) == "userdata" and getElementType(element) == "player") then
		if (getPlayerName(element)) then
			-- TODO: Permission check
			error("Can't use RPC System with Players, Permission check implementation is requierd!")
		end
	end

	local event = setmetatable(
		{
			event = eventName,
			element = element,
			func = func
		}, {
			__index = RPC,
			__super = { RPC }
		}
	)
	
	table.insert(RPC.listeningEvents[eventName], event)
	
	return event;
end

function RPC:removeListener ()
	-- self
end

function RPC:callListener (event, element, ...)
	if (self == RPC) then
		if (type(element) == "userdata" and getElementType(element) == "player") then
			if (getPlayerName(element)) then
				-- TODO: Permission check
				error("Can't use RPC System with Players, Permission check implementation is requierd!")
			end
		end
		
		for key, value in ipairs(self.listeningEvents[event] or {}) do
			if (element == getRootElement()) then
				pcall(value["func"], ...)
			elseif (value["element"] == getRootElement()) then
				pcall(value["func"], ...)
			elseif (type(value["element"]) == type(element)) then
				if (value["element"] == element) then
					pcall(value["func"], ...)
				end
			end
		end
	end
	-- WORK IN PROGRESS
	--[[elseif (instanceof(self, RPC)) then
		if (self["element"] == getRootElement()) then
			pcall(self["func"], ...)
		elseif (type(self["element"]) == type(element)) then
			outputChatBox(self["element"]..": "..element)
			if (self["element"] == element) then
				pcall(self["func"], ...)
			end
		end
	end--]]
	
	return false;
end

if (SERVER) then
	addEvent("RPC.callServerListener", true)

	function RPC:callClientListener (event, element, ...)	
	end
	
	function RPC:onClientListenerCall (event, element, ...)
		self:callListener(event, element, client, ...)
	end
	addEventHandler("RPC.callServerListener", root, bind(RPC.onClientListenerCall, RPC))
elseif (CLIENT) then
	addEvent("RPC.callClientListener", true)
	
	function RPC:callServerListener (event, element, ...)
	end
	
	function RPC:onServertListenerCall (event, element, ...)
	end
	addEventHandler("RPC.callClientListener", root, bind(RPC.onServertListenerCall, RPC))
end

function RPC:removeListener (event, element)
	if (self == RPC) then
		if (self.listeningEvents[event] ~= nil) then
			if (element == getRootElement()) then
				self.listeningEvents[event] = {};
			else
				for key, value in ipairs(self.listeningEvents[event] or {}) do
					if (value["element"] == element) then
						RPC.listeningEvents[event][key] = nil;
					end
				end
			end
			
			return true;
		end
	elseif (instanceof(self, RPC)) then
		if (self.element ~= getRootElement()) then
			for key, value in ipairs(RPC.listeningEvents[self.event] or {}) do
				if (value["element"] == self.element) then
					RPC.listeningEvents[self.event][key] = nil;
				end
			end
		else
		
		end
	end
end

if (SERVER) then
	--RPC:addListeningEvent("test1")
	--event1 = RPC:addListener("test1", "f", function (arg1) outputChatBox("WORKS: "..tostring(arg1)) end)
	--event2 = RPC:addListener("test1", "tt", function (arg1) outputChatBox("HAHAHA: "..tostring(arg1)) end)
	--RPC:callListener("test1", root, "Bitch")
	--RPC:callListener("test1", root, "Bitch2")
end
	
--[[
FIN = finished
NSY = not started yer
WIP = work in progress
ABD = 

RPC:addListeningEvent("myEvent") // FIN
MyEvent = RPC:addListener("myEvent", root, function (text) outputChatBox(text) end) // FIN
MyEvent:removeListener() // FIN
MyEvent:changeListenerElement(getRandomPlayer()) // NSY
MyEvent:changeListenerEvent("myNeuesCoolesEvent") // NSY
MyEvent:changeListenerFunction(nil) // NSY
MyEvent:callListener(...) // NSY
RPC:callListener("myEvent", root, ...) // FIN
--]]