-- Client Version
localPlayer.version = getVersion()

-- Count FPS
localPlayer.fps = {FPS = 0, realFPS = 0, lastTick = getTickCount()}
addEventHandler("onClientRender", root, function ()
	if (getTickCount() - localPlayer.fps.lastTick) >= 1000 then
		localPlayer.fps.lastTick = getTickCount()
		localPlayer.fps.realFPS = localPlayer.fps.FPS
		localPlayer.fps.FPS = 0
	end
	
	localPlayer.fps.FPS = localPlayer.fps.FPS + 1
end)

function localPlayer:getFPS ()
	return localPlayer.fps.realFPS
end