-- This is the playermanager class for a MultiGamemode
Playermanager = {};

function Playermanager:constructor ()
	-- add da events
	addEventHandler("onPlayerJoin", root, bind(self.onJoin, self))
	addEventHandler("onPlayerQuit", root, bind(self.onQuit, self))
	addEventHandler("onPlayerChat", root, bind(self.onChat, self))
	addEventHandler("onPlayerGamemodeJoin", root, bind(self.onGamemodeJoin, self))
	addEventHandler("onPlayerGamemodeLeft", root, bind(self.onGamemodeLeft, self))
end

function Playermanager:onJoin (player, cmd)
	bindKey(player, "z", "down", "chatbox", "Global")
	
	local lobby = Gamemode:getGamemodeFromID(1)
	local gm = player:getGamemode()
	if (gm) then
		gm:removePlayer(player)
	end
	lobby:addPlayer(player)
end
addCommandHandler("haha", bind(Playermanager.onJoin, Playermanager))


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

function Playermanager:onGamemodeJoin (info)
	outputDebugString("[Playermanager] "..source:getName().." has joined the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

function Playermanager:onGamemodeLeft (info)
	outputDebugString("[Playermanager] "..source:getName().." has left the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

Playermanager:constructor()