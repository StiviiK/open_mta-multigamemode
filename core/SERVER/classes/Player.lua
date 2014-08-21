-- This is the player class (extend the normal MTA player class) for a MultiGamemode
function Player:getGamemode ()
	return self.Gamemode;
end

function Player:setGamemode (gamemode)
	self.Gamemode = gamemode;
end

function Player:sendMessage (msg, r, g, b, cc)
	outputChatBox(msg, self, r, g, b, cc)
end