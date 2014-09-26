-- Example for Gamemodes
Example = Gamemode{nil, "Example", "Example Gamemode", "StiviK", nil, 16, 2, {}, {}} -- Registrieren wir einen neuen Gamemode
--[[ Registrier Argumente
1: nil: so wird die ID automatisch zu gewiesen
2: "Example": Dies ist der Name des Gamemodes
3: "Example Gamemode": Dies ist die beschreibung des Gamemodes
4: "StiviK": Dies ist der Autor des Gamemodes
5: nil: so wird die Diemension für die Spieler automatisch zugewiesen
6: 16: max. Spieler anzahl
7: 2: benötigte Spieler anzahl damit der Gamemode weiter ausgeführt wird
8: {}: Blip Argumente, müssen in einer Table sein! (hier eine leere Table damit kein Blip erstellt wird)
9: {}: Marker Argumente, müssen in einer Table sein! (hier eine leere Table damit kein Marker erstellt wird)
--]]
function Example:sayHelloToThePlayer (player) -- Dass ist jetzt eine Custom funktion, die lassen wir aufrufen wenn ein spieler den Gamemode betritt^
	if isElement(player) then -- validieren wir ob es wirklich ein spieler ist
		outputChatBox(("Guten Tag, %s! Wie geht's?"):format(getPlayerName(player)), player) -- senden wir ihm eine Nachricht!
	end
end

function Example:onPlayerJoin (player) -- Diese Funktion wird von dem Gamemodemanager aufgerufen wenn ein Spieler den Gamemode betritt
	Example:sayHelloToThePlayer(player) -- rufen wir unsere Funktion auf, die nur der Gamemode "Basejump" hat und aufrufen kann
end

addCommandHandler("joinExample", function (player)
	player:getGamemode():removePlayer(player) -- entfehren wir den Spieler aus seinem Aktuellen Gamemode
	Example:addPlayer(player) -- jetzt setzen wir ihn in unseren Basejump Gamemode
end)
