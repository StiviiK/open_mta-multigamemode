-- This is the playermanager class for a MultiGamemode
Playermanager = {};

function Playermanager:constructor ()
	-- add da events
	addEventHandler("onPlayerJoin", root, bind(self.onJoin, self))
	addEventHandler("onPlayerQuit", root, bind(self.onQuit, self))
	addEventHandler("onPlayerChat", root, bind(self.onChat, self))
end


function Playermanager:onJoin ()
	bindKey(source, "z", "down", "chatbox", "Global")
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

function Playermanager:onPublicChat (player, cmd, ...)
	local message = table.concat({...}, " ")
		
	for _, v in ipairs(getElementsByType("player")) do
		v:sendMessage(("#0678ee(Global) %s#d9d9d9: %s"):format(getPlayerName(player), message), 255, 255, 255, true)
	end
end
addCommandHandler("Global", bind(Playermanager.onPublicChat, Playermanager))

Playermanager:constructor()