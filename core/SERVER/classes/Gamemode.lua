-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	Gamemodemanager         ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

-- This is the gamemode manager class for a MultiGamemode
Gamemode = {
	registeredGamemodes = {},
	maxAllowedGamemodes = 16
};

setmetatable(Gamemode, {
    __call = function (_, properties)
		if (not Gamemode:getGamemodeFromID(properties[1] or #Gamemode.registeredGamemodes + 1) and (#Gamemode.registeredGamemodes < Gamemode.maxAllowedGamemodes)) then
			local obj = setmetatable(
				{
					ID = properties[1] or #Gamemode.registeredGamemodes + 1,
					Name = properties[2] or "[WARNING] No Name given!",
					Description = properties[3] or "No Description given!",
					Author = properties[4],
					Dimension = properties[5] or Gamemode:getFreeDimension(),
					Players = {},
					maxPlayers = properties[6] or 16,
					minPlayers = properties[7] or 1,
					PlayerCount = 0,
					Blip = createBlip(unpack(properties[8])) or false,
					Marker = createMarker(unpack(properties[9])) or false
				}, {__index = Gamemode}
			)
		
			Gamemode.registeredGamemodes[obj.Dimension] = obj;
			
			outputDebugString(("[Gamemodemanager] Registered a new Gamemode: '%s' (ID: %d)"):format(obj.Name, obj.ID))
			
			addEventHandler("onMarkerHit", obj.Marker, function (hitelement)
			end)
			
			return obj;
		else
			outputDebugString(("[Gamemodemanager] Can't register a new Gamemode! (ID: %d, Name: %s)"):format(properties[1], properties[2]))
			
			return false;
		end
    end
})

-- Globale Methode (aufrufbar via alle Gamemodes)
function Gamemode:unregister ()
	Gamemode.registeredGamemodes[self.ID] = nil; -- remove the gamemode in the registeredGamemodes Table
	outputDebugString(("[Gamemodemanager] Unregistered Gamemode: %s (ID: %d)"):format(self.Name, self.ID))

	if (self.Blip and isElement(self.Blip)) then
		destroyElement(self.Blip)
	end
	
	if (self.Marker and isElement(self.Marker)) then
		destroyElement(self.Marker)
	end
	
	if (#self.Players > 0) then
		for player, _ in pairs(self.Players) do
			self:removePlayer(player) -- Remove all players
		end
	end
	
	for key, value in pairs(self) do
		self[key] = nil; -- Delete the complete gamemode data
	end
	
	return {}; 
	-- return a emtpy table because if you overide the gamemode varriable with the return of this function all gamemode functions also will be removed!
end

function Gamemode:getFreeDimension ()
	if (self == Gamemode) then
		for i = 1, 500 do
			if (self.registeredGamemodes[i] == nil) then
				return i;
			end
		end
	end
	
	return false;
end

function Gamemode:getGamemodeFromID (id)
	if (self == Gamemode) then
		for _, gamemode in pairs(self.registeredGamemodes) do
			if (gamemode.ID == id) then
				return gamemode;
			end
		end
	end
	
	return false;
end

function Gamemode:addPlayer (player)
	if (self.PlayerCount + 1 < self.maxPlayers) then
		if (player:getGamemode() ~= self) then
			-- Player
			player:setGamemode(self)
			player:setDimension(self.Dimension)
			
			-- Gamemode
			self.Players[player] = {}
			self.PlayerCount = self.PlayerCount + 1
			
			self:sendMessage(("#0678ee* #0678ee%s #d9d9d9has joined the Gamemode (%d/%d) #0678ee*"):format(getPlayerName(player), self.PlayerCount, self.maxPlayers), 0, 0, 0, true)
		end
	end
end

function Gamemode:removePlayer (player)
	assert(player:getGamemode() ~= nil, "Bad Argument @ Gamemode.removePlayer [Player isn't in a Gamemode!]")

	if (player:getGamemode() == self) then
		-- Player
		player:setGamemode(nil)
		player:setDimension(0)
		
		-- Gamemode
		self.Players[player] = nil;
		self.PlayerCount = self.PlayerCount - 1
	else
		-- Player
		local gamemode = player:getGamemode()
		player:setGamemode(nil)
		player:setDimension(0)
		
		-- Gamemode
		gamemode.Players[player] = nil;
		gamemode.PlayerCount = gamemode.PlayerCount - 1
		
		-- Special
		gamemode = nil
	end
	
	self:sendMessage(("#0678ee* #0678ee%s #d9d9d9has left the Gamemode(%d/%d) #0678ee*"):format(getPlayerName(player), self.PlayerCount, self.maxPlayers), 0, 0, 0, true)
end

function Gamemode:isPlayerInGamemode (player)
	if (player:getGamemode() ~= nil) then	
		if (player:getGamemode() == self) then
			return true;
		else
			return false;
		end
	end
end

function Gamemode:setInfo (key, value)
	if (type(key) == "string") and (self[key] ~= nil) then
		self[key] = value;
	end
end

function Gamemode:getInfo (key)
	if (type(key) == "string") and (self[key] ~= nil) then
		return self[key];
	end
	
	return {
		ID = self.ID,
		Name = self.Name,
		Description = self.Description,
		Author = self.Author,
		maxPlayers = self.maxPlayers,
		minPlayers = self.minPlayers,
		PlayerCount = self.PlayerCount,
	}
end

function Gamemode:sendMessage (msg, r, g, b, cc)
	for value, _ in pairs(self.Players) do
		outputChatBox(msg, value, r, g, b, cc)
	end
end
