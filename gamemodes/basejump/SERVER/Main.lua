Basejump = Gamemode{nil, "Basejump", "Basejump Gamemode", "StiviK", nil, 16, 2, {}, {}}

function Basejump:sayHelloToThePlayer (player) -- Dass ist jetzt eine Custom funktion, die lassen wir aufrufen wenn ein spieler den Gamemode betritt^
	if isElement(player) then -- validieren wir ob es wirklich ein spieler ist
		outputChatBox(("Guten Tag, %s! Wie geht's?"):format(getPlayerName(player)), player) -- senden wir ihm eine Nachricht!
	end
end

function Basejump:onPlayerJoin (player) -- Diese Funktion wird von dem Gamemodemanager aufgerufen wenn ein Spieler den Gamemode betritt
	Basejump:sayHelloToThePlayer(player) -- rufen wir unsere Funktion auf, die nur der Gamemode "Basejump" hat und aufrufen kann
end

addCommandHandler("joinBasejump", function (player)
	player:getGamemode():removePlayer(player) -- entfehren wir den Spieler aus seinem Aktuellen Gamemode
	Basejump:addPlayer(player) -- jetzt setzen wir ihn in unseren Basejump Gamemode
end)