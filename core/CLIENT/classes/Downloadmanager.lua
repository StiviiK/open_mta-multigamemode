Downloadmanager = {}
Downloadmanager.cache = {}

function Downloadmanager.verifyFiles (...)
	local oldArgs = {...}
	local newArgs = {{}, oldArgs[2]}

	for _, v in ipairs(oldArgs[1]) do
		if not fileExists(v[1]) then
			outputDebugString(v[1])

			table.insert(newArgs[1], v[1])
		else
			local file = fileOpen(v[1])
			local data = file:md5()
			fileClose(file)

            if data ~= v[2] then
                outputDebugString(v[1])

                table.insert(newArgs[1], v[1])
            end
        end
    end

	triggerServerEvent("Downloadmanager.startDownload", root, unpack(newArgs))
end
addEvent("Downloadmanager.verifyFiles", true)
addEventHandler("Downloadmanager.verifyFiles", root, Downloadmanager.verifyFiles)

function Downloadmanager.prepareClient ()

end



















triggerServerEvent("onClientReady", localPlayer, getLocalPlayer())