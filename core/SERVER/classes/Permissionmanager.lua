Permissions = {}

function Permissions:new(...)
	local obj = setmetatable({}, {__index = self})
	if obj.constructor then
		obj:constructor(...)
		addEventHandler("onPlayerCommand", getRootElement(), function(command)
			obj:onCommand(source, command)
		end)
	end
	return obj
end

function Permissions:constructor(...)
	self.m_Commands = { -- {string command, int adminlevel}
		{"kick", 1},
		{"ban", 3}
	}
end

function Permissions:onCommand(_, player, command)
	for index, value in pairs (self.m_Commands) do 
		local cmd, adminlevel = unpack(self.m_Commands[index])
		if command == cmd then
			if getElementData(player, "adminlevel") >= adminlevel then
				return true
			else
				return infobox:new("Command Error: You're not allowed to use this command")
			end
		end
	end
end

Permissions:new()