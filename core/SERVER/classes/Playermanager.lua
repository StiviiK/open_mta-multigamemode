-- This is the playermanager class for a MultiGamemode
Playermanager = {};
table.insert(core.startedClasses, {Playermanager, "Playermanager"})
addEvent("onClientReady", true)

function Playermanager:constructor ()
	-- Add the EventHandler Functions
	self.onReadyFunc = bind(self.onPlayerReady, self)
	self.onQuitFunc = bind(self.onQuit, self)
	self.onChatFunc = bind(self.onChat, self)
	self.onGamemodeJoinFunc = bind(self.onGamemodeJoin, self)
	self.onGamemodeLeftFunc = bind(self.onGamemodeLeft, self)
	
	-- Add the EventHandlers
	addEventHandler("onClientReady", root, self.onReadyFunc)
	addEventHandler("onPlayerQuit", root, self.onQuitFunc)
	addEventHandler("onPlayerChat", root, self.onChatFunc)
	addEventHandler("onPlayerGamemodeJoin", root, self.onGamemodeJoinFunc)
	addEventHandler("onPlayerGamemodeLeft", root, self.onGamemodeLeftFunc)
end

function Playermanager:destructor ()
	-- Remove the EventHandlers
	removeEventHandler("onClientReady", root, self.onReadyFunc)
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

function Playermanager:onPlayerReady (player)
	bindKey(source, "y", "down", "chatbox", "Global")
	bindKey(source, "x", "down", "chatbox", "Private")
   
	if Core:isClasspresent(Statistics) then
		if Statistics:isClasspresent(Statistics_Playerdata) then
			Statistics_Playerdata:addPlayer(player)
		end
	end
	
	Gamemode:getGamemodeFromID(1):addPlayer(player)
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
			--source:getGamemode():sendMessage(("#0678ee%s#d9d9d9: %s"):format(getPlayerName(source), message), 255, 255, 255, true)
			source:getGamemode():sendMessage(("#8A0808[#0678ee%s #FE8A00=> #0678ee%s#8A0808] #0678ee%s#d9d9d9: %s"):format(getPlayerName(source), source:getGamemode():getInfo("Name"), getPlayerName(source), message), 255, 255, 255, true)
		elseif (messageType == 1) then
		elseif (messageType == 2) then
		end
	else
		outputChatBox("#0678ee[Chat] #d9d9d9You have to be in a Gamemode!", source, 255, 255, 255, true)
	end
end

function Playermanager:onPublicChat (player, _, ...)
	local message = table.concat({...}, " ")
		
	for _, v in ipairs(getElementsByType("player")) do
		--v:sendMessage(("#8A0808*Global* #0678ee[%s] %s#d9d9d9: %s"):format(player:getGamemode():getInfo("Name"), getPlayerName(player), message), 255, 255, 255, true)
		v:sendMessage(("#8A0808[#0678ee%s #FE8A00=> #0678ee%s#8A0808] #0678ee%s#d9d9d9: %s"):format(getPlayerName(player), "Global", getPlayerName(player), message), 255, 255, 255, true)
	end
end
addCommandHandler("Global", bind(Playermanager.onPublicChat, Playermanager))

function Playermanager:onPrivateChat (player, _, target, ...)
	local message = table.concat({...}, " ")
	
	local target = getPlayerFromName(target)
	if target then
		if target ~= player then
			player:sendMessage(("#8A0808[#0678eeme #FE8A00=> #0678ee%s#8A0808] #0678ee%s#d9d9d9: %s"):format(getPlayerName(target), getPlayerName(player), message), 255, 255, 255, true)
			target:sendMessage(("#8A0808[#0678ee%s #FE8A00=> #0678eeme#8A0808] #0678ee%s#d9d9d9: %s"):format(getPlayerName(player), getPlayerName(player), message), 255, 255, 255, true)
		end
	end
end
addCommandHandler("Private", bind(Playermanager.onPrivateChat, Playermanager))

function Playermanager:onGamemodeJoin (player, info)
	outputDebug("[Playermanager] "..player:getName().." has joined the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

function Playermanager:onGamemodeLeft (player, info)
	outputDebug("[Playermanager] "..player:getName().." has left the Gamemode '"..info.Name.."' (ID: "..info.ID..") ("..info.PlayerCount.."/"..info.maxPlayers..")")
end

Playermanager:constructor()
--Playermanager:destructor()