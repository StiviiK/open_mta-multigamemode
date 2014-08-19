-- This is the mapmanager for a MultiGamemode
Mapmanager = {}

function Mapmanager:loadMap (gm, mapfile)
	if (not Gamemode:isValid(gm)) then
		error("Bad Argument @ Mapmanager.loadMap [Expected Gamemode at Argument 1]", 2)
	elseif (not fileExists(mapfile)) then
		error("Bad Argument @ Mapmanager.loadMap [Expectet Mapfile at Argument 2]", 2)
	end
	
	local file = fileOpen(mapfile)
	if (fileGetSize(file) == 0) then
		assert(fileGetSize(file) > 0, "Bad Argument @ Mapmanager.loadMap [Expected Mapfile at Argument 2, got empty File!]")
	end
	fileClose(file)
	
	local self = setmetatable({}, {__index = Mapmanager})
	self.GamemodeID = gm:getInfo("ID")
	self.Objects = {};
	self.Map = {};
	self.MapFile = xmlLoadFile(mapfile)
	for i, _ in ipairs(xmlNodeGetChildren(self.MapFile)) do
		local child = xmlFindChild(self.MapFile, "object", i - 1)
		if child then
			local xmlData = xmlNodeGetAttributes(child)
			table.insert(self.Objects, {
				["map"] = mapfile,
				["model"] = xmlData["model"],
				["posX"] = xmlData["posX"],
				["posY"] = xmlData["posY"],
				["posZ"] = xmlData["posZ"],
				["rotX"] = xmlData["rotX"],
				["rotY"] = xmlData["rotY"],
				["rotZ"] = xmlData["rotZ"],
				["id"] = xmlData["id"],
				["collisions"] = (xmlData["collisions"] == "true" and true) or (xmlData["collisions"] == "false" and false),
				["alpha"] = xmlData["alpha"],
				["doublesided"] = (xmlData["doublesided"] == "true" and true) or (xmlData["doublesided"] == "false" and false),
				["scale"] = xmlData["scale"],
				["interior"] = xmlData["interior"]
			})
		end
	end
	
	self.coroutine = coroutine.create(bind(self.createObjects, self))
	coroutine.resume(self.coroutine)
	
	return self;
end

function Mapmanager:createObjects ()
	--assert(#self.Objects == 0, "Attempt to create 0 Objects @ Mapmanager.createObjects")
	local gamemode = Gamemode:getGamemodeFromID(self.GamemodeID)
	if (gamemode) then
		outputDebugString("[Mapmanager] Creating "..#self.Objects.." Objects for Gamemode: "..gamemode:getInfo("Name").." (ID: "..gamemode:getInfo("ID")..")")
		self.tmpCounter = 0
		self.startTick = getTickCount()
		
		for i, v in ipairs(self.Objects) do
			self.tmpObject = gamemode:createObject(v["model"], v["posX"], v["posY"], v["posZ"], v["rotX"], v["rotY"], v["rotZ"])

			if (self.tmpObject) then
				setElementID(self.tmpObject, v["id"])
				setElementCollisionsEnabled(self.tmpObject, v["collisions"])
				setElementAlpha(self.tmpObject, v["alpha"])
				setElementDoubleSided(self.tmpObject, v["doublesided"])
				setObjectScale(self.tmpObject, v["scale"])
				setElementInterior(self.tmpObject, v["interior"])
			end
			
			self.Objects[i] = nil
			
			if (not self.Map) then
				self.Map = {};
			end
			
			table.insert(self.Map, self.tmpObject)

			self.tmpCounter = self.tmpCounter + 1	
			
			if (self.tmpCounter == 1000) then
				self.tmpCounter = 0
				setTimer(function () coroutine.resume(self.coroutine) end, 50, 1)
				coroutine.yield(self.coroutine)
			end
		end
		
		outputDebugString("[Mapmanager] Finished creating "..#self.Map.." Objects for Gamemode: "..gamemode:getInfo("Name").." (Took "..math.floor(getTickCount() - self.startTick).."ms)")
	end
end

function Mapmanager:unloadMap ()
	if (type(self.Map) == "table") then
		if (table.getn(self.Map) > 0) then
			self.removeFunction = function ()
				local ObjCount = #self.Map
				
				outputDebugString("[Mapmanager] Removing "..ObjCount.." Objects for Gamemode: "..Gamemode:getGamemodeFromID(self.GamemodeID):getInfo("Name").." (ID: "..Gamemode:getGamemodeFromID(self.GamemodeID):getInfo("Name")..")")
				
				self.startTick = getTickCount()
				self.tmpCounter = 0
			
				for i, v in ipairs(self.Map) do
					destroyElement(v)
					
					self.Map[i] = nil
					self.tmpCounter = self.tmpCounter + 1
					
					if (self.tmpCounter == 1000) then
						self.tmpCounter = 0
						outputDebugString("stop")
						setTimer(function () coroutine.resume(self.coroutine) end, 50, 1)
						coroutine.yield(self.coroutine)
					end
				end
				
				outputDebugString("[Mapmanager] Finished removing "..ObjCount.." Objects for Gamemode: "..Gamemode:getGamemodeFromID(self.GamemodeID):getInfo("Name").." (Took "..math.floor(getTickCount() - self.startTick).."ms)")
			end
			
			self.coroutine = coroutine.create(self.removeFunction)
			coroutine.resume(self.coroutine)
		else
			error("Bad Argument @ Mapmanager.unloadMap [got empty MapTable]", 2)
		end
	else
		error("Bad Argument @ Mapmanager.unloadMap [Expected MapTable, got "..type(self.Map).."]", 2)
	end
end