-- This is the playermanager class for a MultiGamemode
Playermanager = {};

function Playermanager:constructor ()
	-- Add the EventHandler Functions
	self.onResourceStartFunc = bind(self.onResourceStart, self)
	self.onJoinFunc = bind(self.onJoin, self)
	self.onQuitFunc = bind(self.onQuit, self)
	self.onChatFunc = bind(self.onChat, self)
	self.onGamemodeJoinFunc = bind(self.onGamemodeJoin, self)
	self.onGamemodeLeftFunc = bind(self.onGamemodeLeft, self)
	
	-- Add the EventHandlers
	addEventHandler("onResourceStart", resourceRoot, self.onResourceStartFunc)
	addEventHandler("onPlayerJoin", root, self.onJoinFunc)
	addEventHandler("onPlayerQuit", root, self.onQuitFunc)
	addEventHandler("onPlayerChat", root, self.onChatFunc)
	addEventHandler("onPlayerGamemodeJoin", root, self.onGamemodeJoinFunc)
	addEventHandler("onPlayerGamemodeLeft", root, self.onGamemodeLeftFunc)
end

function Playermanager:destructor ()
	-- Remove the EventHandlers
	removeEventHandler("onResourceStart", root, self.onResourceStartFunc)
	removeEventHandler("onPlayerJoin", root, self.onJoinFunc)
	removeEventHandler("onPlayerQuit", root, self.onQuitFunc)
	removeEventHandler("onPlayerChat", root, self.onChatFunc)
	removeEventHandler("onPlayerGamemodeJoin", root, self.onGamemodeJoinFunc)
	removeEventHandler("onPlayerGamemodeLeft", root, self.onGamemodeLeftFunc)
	
	-- Delete the EventHandler Functions
	self.onResourceStartFunc = nil
	self.onJoinFunc = nil
	self.onQuitFunc = nil
	self.onChatFunc = nil
	self.onGamemodeJoinFunc = nil
	self.onGamemodeLeftFunc = nil
end

function Playermanager:onResourceStart ()
	for _, player in ipairs(getElementsByType("player")) do
		bindKey(player, "z", "down", "chatbox", "Global")
	
		local lobby = Gamemode:getGamemodeFromID(1)
		--[[local gm = player:getGamemode()
		if (gm) then
			gm:removePlayer(player)
		end--]]
		lobby:addPlayer(player)
	end
end

function Playermanager:onJoin ()
	bindKey(source, "y", "down", "chatbox", "Global")
	
	local lobby = Gamemode:getGamemodeFromID(1)
	--[[local gm = source:getGamemode()
	if (gm) then
		gm:removePlayer(source)
	end--]]
	lobby:addPlayer(source)
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
		outputChatBox("#0678ee[Chat] #d9d9d9You have to be in a Gamemode!", source, 255, 255, 255, true)
	end
end

function Playermanager:onPublicChat (player, cmd, ...)
	local message = table.concat({...}, " ")
		
	for _, v in ipairs(getElementsByType("player")) do
		v:sendMessage(("#8A0808*Global* #0678ee[%s] %s #d9d9d9: %s"):format(player:getGamemode():getInfo("Name"), getPlayerName(player), message), 255, 255, 255, true)
	end
end
addCommandHandler("Global", bind(Playermanager.onPublicChat, Playermanager))

function Playermanager:onGamemodeJoin (player, info)
	outputDebugString("[Playermanager] "..player:getName().." has joined the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

function Playermanager:onGamemodeLeft (player, info)
	outputDebugString("[Playermanager] "..player:getName().." has left the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

Playermanager:constructor()
--Playermanager:destructor()