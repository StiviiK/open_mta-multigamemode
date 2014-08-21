Lobby = Gamemode{nil, "Lobby", "This is the Lobby", "StiviK", 0, getMaxPlayers(), 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode
--Mapmanager:loadMap(Lobby, "mytestgamemode/testa.map")

function Lobby:onPlayerJoin (player)
	player:setInterior(18)
	player:setPosition(1717.84912, -1651.28259, 20.23014)
	player:setRotation(0, 0, 223.45709228516)
end

addEventHandler("onPlayerGamemodeJoin", root, function ()
	if (Lobby:isPlayerInGamemode(source)) then
		Lobby:onPlayerJoin(source)
	end
end)