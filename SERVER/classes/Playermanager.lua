-- #######################################
-- ## Project: 	Test's		    		##
-- ## Name: 	PlayerClass Extension   ##
-- ## Author:	StiviK					##
-- ## Version: 	1.0						##
-- #######################################

-- This is the playermanager class for a MultiGamemode
Playermanager = {};

function Playermanager:constructor ()
	-- add da events
	--addEventHandler("onPlayerJoin", root, bind(self.playerJoin, self))
	addEventHandler("onPlayerQuit", root, bind(self.onQuit, self))
	addEventHandler("onPlayerChat", root, bind(self.onChat, self))
end

function Playermanager:onQuit ()
	local gamemode = source:getGamemode()
	if (gamemode ~= nil) then
		gamemode:removePlayer(source)
	end
end

function Playermanager:onChat (message, messageType)
	cancelEvent();
	
	if (source:getGamemode()) then
		if (messageType == 0) then
			source:getGamemode():sendMessage(("#0678ee%s#d9d9d9: %s"):format(getPlayerName(source), message), 255, 255, 255, true)
		elseif (messageType == 1) then
		elseif (messageType == 2) then
		end
	else
		outputChatBox(("#0678ee%s #d9d9d9%s"):format("[Chat]", "You have to be in a Gamemode!"), source, 255, 255, 255, true)
	end
end
Playermanager:constructor()