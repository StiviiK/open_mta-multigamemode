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
			local gm = ele:getGamemode()
			if (gm) then
				gm:removePlayer(ele)
			end
		
			TestGamemode:addPlayer(ele)
		end
	end
end)

addEventHandler("onPlayerGamemodeJoin", root, function (info)
	if (TestGamemode:isPlayerInGamemode(source)) then
		outputDebugString("Testgamemode")
	end
end)

--Mapmanager:loadMap(TestGamemode, "mytestgamemode/test.map")