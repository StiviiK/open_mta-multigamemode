-- Startup
outputDebugString("------ Starting the Gamemode ------")
	if devSettings.startup["Databasemanager"] then
		outputDebugString("[STARTING] Databasemanager")
		require("core/SERVER/classes/Database.lua")
	end
	if devSettings.startup["Playerclass"] then
		outputDebugString("[STARTING] Playerclass")
		require("core/SERVER/classes/Player.lua")
	end
	if devSettings.startup["Playermanager"] then
		outputDebugString("[STARTING] Playermanager")
		require("core/SERVER/classes/Playermanager.lua")
	end
	if devSettings.startup["Gamemodemanager"] then
		outputDebugString("[STARTING] Gamemodemanager")
		require("core/SERVER/classes/Gamemode.lua")
	end
	if devSettings.startup["Elementmanager"] then
		outputDebugString("[STARTING] Elementmanager")
		require("core/SERVER/classes/Elementmanager.lua")
	end
	if devSettings.startup["Permissionmanager"] then
		outputDebugString("[STARTING] Permissionmanager")
		require("core/SERVER/classes/Permissionmanager.lua")
	end
	if devSettings.startup["Mapmanager"] then
		outputDebugString("[STARTING] Mapmanager")
		require("core/SERVER/classes/Mapmanager.lua")
	end
		if devSettings.startup["Downloadmanager"] then
		outputDebugString("[STARTING] Downloadmanager")
		require("core/SERVER/classes/Downloadmanager.lua")
	end
	
	setGameType("Multigamemode by StiviK")
outputDebugString("------ Startup finished ------")

-- Stop
addEventHandler("onResourceStop", resourceRoot, function ()
	outputDebugString("------ Stopping the Gamemode ------")
	if (Playermanager) then
		outputDebugString("[CALLING] Playermanager: destructor")
		delete(Playermanager)
	end
	if (Database) then
		outputDebugString("[CALLING] Database: destructor")
		delete(Database)
	end
	if (Mapmanager) then
		outputDebugString("[CALLING] Mapmanager: destructor")
		delete(Mapmanager)
	end
	if (Gamemode) then
		outputDebugString("[CALLING] Gamemodemanager: destructor")
		--delete(Gamemode) -- Causes Error
		Gamemode:destructor()
	end
	
	outputDebugString("------ End ------")
end)

--Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)