-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	EXAMPLE                 ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

-- This is the testgamemode for a MultiGamemode-- TESTS
newgamemode = Gamemode{1, "myNewGamemode", "This is a test gamemode!", nil, 32, 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode
newgamemode:addPlayer(getRandomPlayer()) -- set the player in our new gamemode

-- "Private"-Methode (nur aufrufbar durch den spezifischen gamemode)
function newgamemode:spawnPlayer(player)  -- add a new method to the gamemode
    if (self:isPlayerInGamemode(player)) then -- check if the player is really in our new gamemode!
		spawnPlayer(player, 0, 0, 3)
    else
		outputChatBox("player ist not in this gamemode!")
    end
end
newgamemode:spawnPlayer(getRandomPlayer()) -- now we spawn the player (via the new a method from the new gamemode)