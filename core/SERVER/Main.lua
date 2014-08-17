addEventHandler("onResourceStop", resourceRoot, function ()
	for _, gamemode in ipairs(Gamemode.registeredGamemodes) do
		gamemode:unregister()
	end
	
	delete(Gamemode)
	delete(Playermanager)
	delete(Database)
end)

addEventHandler("onResourceStart", resourceRoot, function ()
	Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)
end)