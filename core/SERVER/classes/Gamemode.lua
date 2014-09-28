Gamemode = {}
-- Class Tables
Gamemode.registeredGamemodes = {}

-- Metatable
Gamemode.__metatable = false
Gamemode.__call = function (self, properties)
	if not self:getGamemodeFromID(properties[1] or #self.registeredGamemodes + 1) then
		local obj = setmetatable(
			{
				ID = properties[1] or #self.registeredGamemodes + 1,
				Name = properties[2] or "[WARNING] No Name given!",
				Description = properties[3] or "No Description given!",
				Author = properties[4],
				Dimension = properties[5] or self:getFreeDimension(),
				Players = {},
				maxPlayers = properties[6] or 16,
				minPlayers = properties[7] or 1,
				PlayerCount = 0,
				Blip = (#properties[8] >= 3 and createBlip(unpack(properties[8]))) or false,
				Marker = (#properties[9] >= 3 and createMarker(unpack(properties[9]))) or false,
				Element = createElement("Gamemode_Element", properties[1]),
				Elements = {
					["ped"] = {},
					["vehicle"] = {},
					["object"] = {},
					["pickup"] = {},
					["marker"] = {},
					["colshape"] = {},
					["blip"] = {},
					["ped"] = {},
					["radararea"] = {}
				},
				Maps = {},
				tmp = {}
			}, {
				__index = self,
				__metatable = self.__metatable
			}
		)
		
		self.registeredGamemodes[obj.ID] = obj;
			
		outputDebugString(("[Gamemodemanager] Registered a new Gamemode: '%s' (ID: %d)"):format(obj.Name, obj.ID))
			
		return obj;
	else
		outputDebugString(("[Gamemodemanager] Can't register a new Gamemode! (ID: %d, Name: %s)"):format(properties[1] or #Gamemode.registeredGamemodes + 1, properties[2]))
			
		return false;
	end
end
setmetatable(Gamemode, {__call = Gamemode.__call})

function Gamemode:destructor ()
	for _, gamemode in ipairs(Gamemode.registeredGamemodes) do
		gamemode:unregister()
	end
end

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
	
	for key, _ in pairs(self) do
		self[key] = nil; -- Delete the complete gamemode data
    end
end

function Gamemode:isValid (gamemode)
	if (self == Gamemode) then
		for _, v in pairs(self.registeredGamemodes) do
			if (v == gamemode) then
				return true;
			end
		end
	end
	
	return false;
end

function Gamemode:getFreeDimension ()
	if (self == Gamemode) then
		for dim = 1, 500 do
			for i in ipairs(self.registeredGamemodes) do
				if (self.registeredGamemodes[i].Dimension ~= dim) then
					return dim;
				end
			end
		end
	end
	
	return false;
end

fileFlush()

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
	if (player:getGamemode() ~= self) then
		if (self.PlayerCount + 1 <= self.maxPlayers) then
			-- Player
			player:setGamemode(self)
			player:setDimension(self.Dimension)
			
			-- Gamemode
			self.Players[player] = {}
			self.PlayerCount = self.PlayerCount + 1
			
			self:sendMessage(("#0678ee* %s #d9d9d9has joined this room (%d/%d) #0678ee*"):format(getPlayerName(player), self.PlayerCount, self.maxPlayers), 0, 0, 0, true)
		
			-- Call some Events
			triggerEvent("onPlayerGamemodeJoin", self.Element, player, self:getInfo())
			-- Direct call
			if rawget(self, "onPlayerJoin") then
				rawget(self, "onPlayerJoin")(self, player, self:getInfo())
			end
			
			if (self.minPlayers == self.PlayerCount) then
				triggerEvent("onGamemodeMinimumPlayerReached", self.Element, player, self:getInfo())
				-- Experimental
				RPC:callListener("onGamemodeMinimumPlayerReached", self.Element, player, self:getInfo())
				-- Direct call
				if rawget(self, "onMinimumPlayerReached") then
					rawget(self, "onMinimumPlayerReached")(self, player, self:getInfo())
				end
			end
		end
	end
end

function Gamemode:removePlayer (player)
	assert(player ~= nil, "Bad Argument @ Gamemode.removePlayer [Expectet Player at Argument 1, got "..type(player).."]")
	assert(player:getGamemode() ~= nil, "Bad Argument @ Gamemode.removePlayer [Player isn't in a Gamemode!]")

	if (player:getGamemode() == self) then
		-- Player
		player:setGamemode(nil)
		player:setDimension(0)
		
		-- Gamemode
		self.Players[player] = nil;
		self.PlayerCount = self.PlayerCount - 1

		-- Eventhandler
		triggerEvent("onPlayerGamemodeLeft", self.Element, player, self:getInfo())
		-- Direct call
		if rawget(self, "onPlayerLeft") then
			rawget(self, "onPlayerLeft")(gamemode, player, gamemode:getInfo())
		end
	else
		-- Player
		local gamemode = player:getGamemode()
		player:setGamemode(nil)
		player:setDimension(0)
		
		-- Gamemode
		gamemode.Players[player] = nil;
		gamemode.PlayerCount = gamemode.PlayerCount - 1
		
		-- Eventhandler
		triggerEvent("onPlayerGamemodeLeft", self.Element, player, gamemode:getInfo())
		-- Direct call
		if rawget(self, "onPlayerLeft") then
			rawget(self, "onPlayerLeft")(gamemode, player, gamemode:getInfo())
		end
		
		-- Special
		gamemode = nil
	end
	
	self:sendMessage(("#0678ee* %s #d9d9d9has left this room (%d/%d) #0678ee*"):format(getPlayerName(player), self.PlayerCount, self.maxPlayers), 0, 0, 0, true)
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
		Dimension = self.Dimension,
		Players = self.Players,
		maxPlayers = self.maxPlayers,
		minPlayers = self.minPlayers,
		PlayerCount = self.PlayerCount,
		Blip = self.Blip,
		Marker = self.Marker,
		Element = self.Element
	}
end

function Gamemode:sendMessage (msg, r, g, b, cc)
	for value, _ in pairs(self.Players) do
		outputChatBox(msg, value, r, g, b, cc)
	end
end