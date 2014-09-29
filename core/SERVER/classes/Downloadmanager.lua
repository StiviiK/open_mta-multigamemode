Downloadmanager = {}

-- Custom Events
addEvent("Downloadmanager.startDownload", true)
addEvent("Donwloadmanager.onPlayerDownloadFinish", true)

function Downloadmanager:new (meta, gamemode)
	Check("Downloadmanager.new", "string", meta, "Meta-File")
	if not fileExists(meta) then
		error("Warning @ Downloadmanager.new [Meta-File not found]", 2)
	end

	local self = setmetatable({
		gamemodeID = gamemode:getInfo("ID"),
		Meta = xmlLoadFile(meta),
		c_tempFiles = {}, -- File Path storage for the client verification
	}, {__index = Downloadmanager})
	
	for i in ipairs(xmlNodeGetChildren(self.Meta)) do
		local child = xmlFindChild(self.Meta, "file", i - 1)
		if child then
			local xmlData = xmlNodeGetAttributes(child)
			if fileExists(xmlData["src"]) then
                local file = fileOpen(xmlData["src"])
				table.insert(self.c_tempFiles, {xmlData["src"], file:md5()})
				fileClose(file)
			end
		end
	end
	
	xmlUnloadFile(self.Meta)
	gamemode.tmp["fileManager"] = self
	return self;
end

function Downloadmanager:sendToClient (client)
	triggerClientEvent(client, "Downloadmanager.verifyFiles", client, self.c_tempFiles, self.gamemodeID)
end

function Downloadmanager.startDownload (c_tempFiles, gamemodeID)
    local gamemode = Gamemode:getGamemodeFromID(gamemodeID)
    local self = gamemode.tmp["fileManager"]
    local playerInstance = setmetatable({ -- i know, it is not completely necessary but now it is safer :)
		cache = c_tempFiles,
		filesToDownload = {},
		c_Data = {
			["compSize"] = 0,
			["compCount"] = 0
		},
		player = client,
	}, {__index = self})

	for _, v in ipairs(playerInstance.cache) do
		if fileExists(v) then
            local file = fileOpen(v)
            local size = file:getSize()
            local data = file:base64()
			--local file = fileOpen(v)
			--local size = fileGetSize(file)
			--local data = fileRead(file, size)

			if data ~= nil then
				playerInstance.c_Data["compSize"] = playerInstance.c_Data["compSize"] + size
				playerInstance.c_Data["compCount"] = playerInstance.c_Data["compCount"] + 1
		
				table.insert(playerInstance.filesToDownload, {
					base64Encode(v),
					data,
					base64Encode(size)
				})
			end
			
			fileClose(file)
            error(file:getSize())
		end
    end
    playerInstance.cache = nil

    if select('#', unpack(playerInstance.filesToDownload)) > 0 then
        triggerClientEvent(playerInstance.player, "Downloadmanager.prepareDownload", playerInstance.player, playerInstance.c_Data)

        for _, v in ipairs(playerInstance.filesToDownload) do
            --triggerLatentClientEvent(playerInstance.player, "", 750000, false, client, v)
        end




        playerInstance.onFinishFunc = bind(Downloadmanager.onDownloadFinish, playerInstance)
        addEventHandler("Donwloadmanager.onPlayerDownloadFinish", playerInstance.player, playerInstance.onFinishFunc)

        addEventHandler("onPlayerQuit", playerInstance.player, function ()
            for _, handle in ipairs(getLatentEventHandles(source)) do
                cancelLatentEvent(source, handle)
            end

            removeEventHandler("Donwloadmanager.onPlayerDownloadFinish", playerInstance.player, playerInstance.onFinishFunc)
        end)
	else
        if rawget(gamemode, "onPlayerDownloadFinished") then
           rawget(gamemode, "onPlayerDownloadFinished")(gamemode, playerInstance.player)
        end
    end
end
addEventHandler("Downloadmanager.startDownload", root, Downloadmanager.startDownload)

function Downloadmanager:onDownloadFinish ()
    -- self == Playerinstance (Downloadmanager) from the player who finished downloading
    outputDebugString(Gamemode:getGamemodeFromID(self.gamemodeID):getInfo("Name"))
end

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
