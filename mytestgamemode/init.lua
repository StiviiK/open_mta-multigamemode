-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	PlayerClass Extension   ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

-- This is the testgamemode for a MultiGamemode

newgamemode = Gamemode{nil, "TestGamemode", "This is a test gamemode!", "StiviK", nil, 32, 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode
newgamemode:addPlayer(getRandomPlayer())

function newgamemode:spawnPlayer(player)
    if (self:isPlayerInGamemode(player)) then
		spawnPlayer(player, 0, 0, 3)
    else
		outputChatBox("player ist not in this gamemode!")
    end
end
newgamemode:spawnPlayer(getRandomPlayer())