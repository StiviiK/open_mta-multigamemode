-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	Main.lua                ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

addEventHandler("onResourceStop", resourceRoot, function ()
	for _, gamemode in ipairs(Gamemode.registeredGamemodes) do
		gamemode:unregister()
	end
	
	delete(Gamemode)
	delete(Playermanager)
	delete(Database)
end)

addEventHandler("onResourceStart", resourceRoot, function ()
	Database:connect("127.0.0.1", "root", "", "multi-sa", "share=1")
end)