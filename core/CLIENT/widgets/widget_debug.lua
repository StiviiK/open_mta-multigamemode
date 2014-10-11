if DEBUG then
	function Debug.renderInformations ()
		localPlayer.dxStatus = dxGetStatus()
		localPlayer.NetworkStats = getNetworkStats()
			
		dxSetRenderTarget(Debug.DebugWindow1.renderTarget, true)
			dxSetBlendMode("modulate_add")
				
			dxDrawRectangle(0, 0, 259, 254, tocolor(0, 0, 0, 155), false)
			dxDrawRectangle(10, 6, 238, 37, tocolor(0, 0, 0, 151), false)
			dxDrawText("Debug Informations", 10, 10, 248, 38, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", true, false, false, false, false)
			dxDrawText(("Client Version: %s (%s)"):format(localPlayer.version["tag"], localPlayer.version["type"]), 9, 48, 248, 66, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Graphic Card: %s"):format(localPlayer.dxStatus["VideoCardName"]), 9, 76, 248, 94, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("vRAM: %s MB"):format(localPlayer.dxStatus["VideoCardRAM"]), 9, 94, 248, 112, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("free vRAM (to MTA): %s MB"):format(localPlayer.dxStatus["VideoMemoryFreeForMTA"]), 9, 112, 248, 130, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Test Mode: %s"):format(localPlayer.dxStatus["TestMode"]), 9, 130, 248, 148, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Bytes received: %s (%s)"):format(localPlayer.NetworkStats["bytesReceived"], sizeFormat(localPlayer.NetworkStats["bytesReceived"])), 9, 158, 248, 176, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Bytes send: %s (%s)"):format(localPlayer.NetworkStats["bytesSent"], sizeFormat(localPlayer.NetworkStats["bytesSent"])), 10, 176, 249, 194, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Packets received: %s"):format(localPlayer.NetworkStats["packetsReceived"]), 9, 194, 248, 212, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Packets send: %s"):format(localPlayer.NetworkStats["packetsSent"]), 9, 212, 248, 230, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			dxDrawText(("Packets loss: %s%s"):format(localPlayer.NetworkStats["packetlossLastSecond"], "%"), 9, 230, 249, 248, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
			
			dxSetBlendMode("blend")
		dxSetRenderTarget()

		dxDrawImage(Debug.DebugWindow1.posX, Debug.DebugWindow1.posY, Debug.DebugWindow1.w, Debug.DebugWindow1.h, Debug.DebugWindow1.renderTarget)

		--[[dxDrawRectangle(1312, 80, 258, 254, tocolor(0, 0, 0, 155), false)
		dxDrawText("Debug Informations", 1322, 90, 1560, 118, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawRectangle(1322, 86, 238, 37, tocolor(0, 0, 0, 151), false)
		dxDrawText(("Client Version: %s (%s)"):format(localPlayer.version["tag"], localPlayer.version["type"]), 1321, 128, 1560, 146, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Graphic Card: %s"):format(localPlayer.dxStatus["VideoCardName"]), 1321, 156, 1560, 174, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("vRAM: %s MB"):format(localPlayer.dxStatus["VideoCardRAM"]), 1321, 174, 1560, 192, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("free vRAM (to MTA): %s MB"):format(localPlayer.dxStatus["VideoMemoryFreeForMTA"]), 1321, 192, 1560, 210, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Test Mode: %s"):format(localPlayer.dxStatus["TestMode"]), 1321, 210, 1560, 228, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Bytes received: %s (%s)"):format(localPlayer.NetworkStats["bytesReceived"], sizeFormat(localPlayer.NetworkStats["bytesReceived"])), 1321, 238, 1560, 256, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Bytes send: %s (%s)"):format(localPlayer.NetworkStats["bytesSent"], sizeFormat(localPlayer.NetworkStats["bytesSent"])), 1321, 256, 1560, 274, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Packets received: %s"):format(localPlayer.NetworkStats["packetsReceived"]), 1321, 274, 1560, 292, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Packets send: %s"):format(localPlayer.NetworkStats["packetsSent"]), 1321, 292, 1560, 310, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		dxDrawText(("Packets loss: %s%s"):format(localPlayer.NetworkStats["packetlossLastSecond"], "%"), 1321, 310, 1560, 328, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", true, false, false, false, false)
		--]]
		
		--[[dxSetRenderTarget(Debug.DebugWindow2.renderTarget, true)
			dxSetBlendMode("modulate_add")
					
			dxDrawRectangle(0, 0, 259, 254, tocolor(0, 0, 0, 155))
			dxDrawRectangle(10, 6, 238, 37, tocolor(0, 0, 0, 151), false)
			dxDrawText("Player Informations", 10, 10, 248, 38, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", true, false, false, false, false)
				
			dxDrawText("Name: StiviK", 10, 48, 247, 66, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Health: 100%", 10, 66, 247, 84, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Armor: 0%", 10, 84, 247, 102, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Skin: 56", 10, 102, 247, 120, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Position: 0, 0, 0", 10, 120, 247, 138, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Interrior: 16", 10, 138, 247, 156, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Diemension: 1", 10, 156, 247, 174, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
			dxDrawText("Ping: 2ms", 10, 174, 247, 192, tocolor(254, 254, 254, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
				
			dxSetBlendMode("blend")
		dxSetRenderTarget()
		dxDrawImage(Debug.DebugWindow2.posX, Debug.DebugWindow2.posY, 259, 254, Debug.DebugWindow2.renderTarget)--]]
		
		guiSetText(Version.debug_label, ("Debugging-Mode: %s (%s FPS)"):format(DEBUG and "enabled" or "disabled", localPlayer:getFPS()))
	end
end
Debug:constructor() -- Change!!