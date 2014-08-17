-- This is the player (extend the normal MTA player class) class for a MultiGamemode
function Player:getGamemode ()
	return self.Gamemode;
end

function Player:setGamemode (gamemode)
	self.Gamemode = gamemode;
end
