if Core:isClasspresent(Statistics) then
	Statistics_Playerdata = {}
	Statistics_Playerdata.players = {}
	table.insert(Statistics.classes, {"Playerdata", Statistics_Playerdata})

	function Statistics_Playerdata:addPlayer (player)
		if isElement(player) and getPlayerName(player) then
			Statistics_Playerdata.players[player] = { -- Todo: Import the Data from the Database
				Globals = {
					playtime = 0,
					messagesSent = 0,
					messagesReceived = 0,
				
				},
				GamemodeData = {}
			}
					
			for i in ipairs(Gamemode.registeredGamemodes) do
				Statistics_Playerdata.players[player]["GamemodeData"][i] = { -- Todo: Import the Data from the Database 
					
				}
			end
		end
	end
end