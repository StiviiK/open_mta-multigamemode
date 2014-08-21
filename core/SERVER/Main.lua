addEventHandler("onResourceStop", resourceRoot, function ()
	outputDebugString("[CALLING] Playermanager: destructor")
	delete(Playermanager)
	outputDebugString("[CALLING] Database: destructor")
	delete(Database)
	outputDebugString("[CALLING] Mapmanager: destructor")
	delete(Mapmanager)
	outputDebugString("[CALLING] Gamemodemanager: destructor")
	--delete(Gamemode) -- Causes Error
	Gamemode:destructor()

	outputDebugString("------ Stopping the Gamemode ------")
end)

outputDebugString("------ Starting the Gamemode ------")
--Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)