-- #######################################
-- ## Project: 	Test's		    		##
-- ## Name: 	PlayerClass Extension   ##
-- ## Author:	StiviK					##
-- ## Version: 	1.0						##
-- #######################################

-- This is the player (extend the normal player class) class for a MultiGamemode
function Player:getGamemode ()
	return self.Gamemode;
end

function Player:setGamemode (gamemode)
	self.Gamemode = gamemode;
end