Lobby = Gamemode{nil, "Lobby", "This is the Lobby", "StiviK", 0, getMaxPlayers(), 1, {0, 0, 0, 21}, {0, 0, 3, "cylinder", 1}} -- Register a new Gamemode
--Lobby:createMarker(1712.0999755859, -1639.9000244141, 19.200000762939, "cylinder", 1, 0, 4, 100)

local marker = Lobby:createMarker(1726.93713, -1638.32935, 20.29, "corona", 1, 125, 0, 0)
setElementInterior(marker, 18)
addEventHandler("onMarkerHit", marker, function (hitele, dim)
	if (getElementType(hitele) == "player" and dim) then
		kickPlayer(hitele, "Server", "Du hast den Server erfolgreich verlassen.")
	end
end)

function Lobby:onPlayerJoin (player)
	spawnPlayer(player, 0, 0, 0, 0, math.random(312))

	if (getPlayerName(player) == "StiviK") then
		setElementModel(player, 62)
		giveWeapon(player, 23, 99999999999999, true)
	end
	
	setElementInterior(player, 18)
	setElementPosition(player, 1717.84912, -1651.28259, 20.23014)
	setElementRotation(player, 0, 0, 223.45709228516)
	setElementAlpha(player, 200)
end