Downloadmanager = {}

function Downloadmanager:new (meta, gamemode)
	Check("Downloadmanager.new", "string", meta, "Meta-File")
	if not fileExists(meta) then
		error("Warning @ Downloadmanager.new [Meta-File not found]", 2)
	end

	local self = setmetatable({
		gamemodeID = gamemode:getInfo("ID"),
		Meta = xmlLoadFile(meta),
		c_Files = {}, -- Client Files
		c_tempFiles = {}, -- File Path storage for the client verification
		c_Data = {
			currCount = 0, -- Only necessary for the Client
			compCount = 0,
			currSize = 0, -- Only necessary for the Client
			compSize = 0
		}
	}, {__index = Downloadmanager})
	
	for i in ipairs(xmlNodeGetChildren(self.Meta)) do
		local child = xmlFindChild(self.Meta, "file", i - 1)
		if child then
			local xmlData = xmlNodeGetAttributes(child)
			table.insert(self.c_tempFiles, xmlData["src"])
		end
	end
	
	xmlUnloadFile(self.Meta)
	gamemode.tmp["fileManager"] = self
	return self;
end

function Downloadmanager:sendToClient (client)
	triggerClientEvent(client, "testEvent1", root, self.c_tempFiles, self.gamemodeID)
end

function Downloadmanager.downloadFile (c_tempFiles, gamemodeID)
	local gamemode = Gamemode:getGamemodeFromID(gamemodeID)
	local self = gamemode.tmp["fileManager"]
	gamemode.tmp["fileManager"] = nil -- Delete the tmp Data

	self.c_tempFiles = c_tempFiles
	
	for i, v in ipairs(self.c_tempFiles) do
		if fileExists(v) then
			local file = fileOpen(v)
			local size = fileGetSize(file)
			local data = fileRead(file, size)
			
			if data ~= nil then
				self.c_Data["compSize"] = self.c_Data["compSize"] + size
				self.c_Data["compCount"] = self.c_Data["compCount"] + 1
		
				table.insert(self.c_Files, {
					v,
					data,
					size
				})
			end
			
			fileClose(file)
		end
	end
	
	triggerClientEvent(client, "Downloadmanager_prepareDownload", client, self.c_Data)
	
	for i, v in ipairs(self.c_Files) do
		triggerLatentClientEvent(client, "", 750000, false, client, v)
	end
	
	addEventHandler("onPlayerQuit", client, function ()
		for _, handle in ipairs(getLatentEventHandles(source)) do 
			cancelLatentEvent(source, handle)
		end
	end)
end
addEvent("testEvent2", true)
addEventHandler("testEvent2", root, Downloadmanager.downloadFile)

--[[
	if fileExists(xmlData["src"]) then
		local file = fileOpen(xmlData["src"])
		local size = fileGetSize(file)
		local data = fileRead(file, size)
		
		if data ~= nil then
			self.c_Data["compSize"] = self.c_Data["compSize"] + size
			self.c_Data["compCount"] = self.c_Data["compCount"] + 1
	
			table.insert(self.c_Files, {
				xmlData["src"],
				data,
				size
			})
		end
	end
--]]