Downloadmanager = {}

function Downloadmanager.verifyFiles (...)
	triggerServerEvent("testEvent2", root, ...)
end
addEvent("testEvent1", true)
addEventHandler("testEvent1", root, Downloadmanager.verifyFiles)

triggerServerEvent("onClientReady", root)