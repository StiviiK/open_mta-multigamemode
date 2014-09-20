function Player:getGamemode ()
	return self.Gamemode;
end

function Player:setGamemode (gamemode)
	self.Gamemode = gamemode;
end

function Player:sendMessage (msg, r, g, b, cc)
	outputChatBox(msg, self, r, g, b, cc)
end

function Player:getGamemodeData (data)
	if self:getGamemode() ~= nil then
		if self:getGamemode().Players[self] ~= nil then
			if self:getGamemode().Players[self][data] ~= nil then
				return self:getGamemode().Players[self][data]
			end
		end
	end
	
	return nil
end

function Player:setGamemodeData (data, value)
	if self:getGamemode() ~= nil then
		if self:getGamemode().Players[self] ~= nil then
			self:getGamemode().Players[self][data] = value
			
			return true
		end
	end

	return false
end