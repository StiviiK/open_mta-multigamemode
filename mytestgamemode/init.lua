-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	TestGamemode            ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

-- This is the testgamemode for a MultiGamemode
TestGamemode = Gamemode{nil, "TestGamemode", "This is a test gamemode!", "StiviK", nil, 32, 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode

addEventHandler("onMarkerHit", TestGamemode.Marker, function (ele, dim)
	if (getElementType(ele) == "player") then
		if (dim) then
			TestGamemode:addPlayer(ele)
		end
	end
end)

local Map = Mapmanager:loadMap(TestGamemode, "mytestgamemode/test.map")
addCommandHandler("testa", function ()
	Map:unloadMap()
end)