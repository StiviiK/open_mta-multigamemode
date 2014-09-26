Bloodmoney = Gamemode{nil, "Bloodmoney", "Bloodmoney Gamemode (Battlefield Hardline)", "StiviK", nil, 32, 12, {}, {}}


addEvent("onClientReady", true)
addEventHandler("onClientReady", root, function ()
	Bloodmoney.downloadData = Downloadmanager:new("metafiles/meta_lobby.xml", Bloodmoney)
	Bloodmoney.downloadData:sendToClient(getRandomPlayer())
end)

Mapmanager:loadMap(Bloodmoney, "metafiles/meta_lobby.xml")