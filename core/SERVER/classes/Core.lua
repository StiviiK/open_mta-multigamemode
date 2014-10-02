Core = {}

function Core:constructor ()
	outputDebugString("------ Starting the core... ------")
	
	-- we need immediately the global core e.g table.insert(core.startedClasses, ...)
	core = self
	
	-- set the game type
	setGameType(getResourceName(getThisResource()).." "..(VERSION or "[unknown build]"))
	
	-- starting the classes
	self.startedClasses = {}
	for _, data in ipairs(devSettings.startup) do
		if data[3] then
			outputDebugString(("[Core] [STARTING] %s"):format(data[1]))
			require(data[2])
		end
	end

	-- connected to the database
	if self:isClasspresent(Database) then
		Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)
	end
	
	outputDebugString("------ Startup of the core finished. ------")
	return self
end

function Core:destructor ()
	if self ~= core then return end
	outputDebugString("------ Stopping the core... ------")
	
	-- disconnect from the database
	if self:isClasspresent(Database) then
		Database:disconnect()
	end
	
	self.sortBackwards = function (a, b)
		if table.find(self.startedClasses, a) > table.find(self.startedClasses, b) then
			return true
		end
		
		return false;
	end
	
	-- delete all loaded classes
	for k, class in spairs(self.startedClasses, self.sortBackwards) do
		outputDebugString(("[Core] [STOPPING] %s"):format(class[2]))
		Core:removeClass(class[1], false)
		self.startedClasses[k] = nil
	end
	
	-- delete the core
	self.destructor = false
	core = nil
	Core:removeClass(Core)
	
	outputDebugString("------ The core has been stopped... ------")
end

function Core:isClasspresent (class)
	for i, v in ipairs(self.startedClasses) do
		if v[1] == class then
			return true;
		end
	end
	
	return false;
end

function Core:removeClass (class, direct)
	--if self:isClasspresent(class) then
		if rawget(class, "destructor") then
			rawget(class, "destructor")(class)
		end
	
		if direct then
			for i, v in ipairs(self.startedClasses) do
				if v[1] == class then
					outputDebugString(("[Core] [STOPPING] %s"):format(v[2]))
					self.startedClasses[i] = nil
				end
			end
		end
		
		for i, v in pairs(_G) do
			if v == class then
				--_G[i] = nil
				if type(_G[i]) == "table" then
					for _i, v in pairs(_G[i]) do
						if isElement(v) then
							destroyElement(v)
						elseif isTimer(v) then
							killTimer(v)
						end
						
						_G[i][_i] = nil
					end
					
					_G[i] = nil
				else
					_G[i] = nil
				end
			end
		end
	--end
end