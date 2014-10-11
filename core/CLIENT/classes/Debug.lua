if DEBUG then
	Debug = {}

	function Debug:constructor ()
		addCommandHandler("setpos", function (_, posX, posY)
			self.renderTarget.posX, self.renderTarget.posY = tonumber(posX), tonumber(posY)
		end)
		
		self.DebugWindow1 = dxMoveable:createMoveable(259, 254, true)
		--self.DebugWindow2 = dxMoveable:createMoveable(259, 254, true)
		
		self.DebugWindow1.posX, self.DebugWindow1.posY = screenW - 269, 10
		--Debug.DebugWindow1.w, Debug.DebugWindow1.h = Debug.DebugWindow1.w/1.2, Debug.DebugWindow1.h/1.2
		--self.DebugWindow2.posX, self.DebugWindow2.posY = screenW - 269, 274

		addEventHandler("onClientRender", root, self.renderInformations)
		
		Version.debug_label = guiCreateLabel(1, screenH - 15, 500, 18, ("Debugging-Mode: %s ([unknown] FPS)"):format(DEBUG and "enabled" or "disabled"), false)
		guiSetAlpha(Version.debug_label, 0.53)
		
		if string.find(VERSION, "dev") then
			Version.info_label = guiCreateLabel(1, screenH - 15, 500, 18, ("WARNING: This Server is running a Development Build! (%s)"):format(VERSION), false)
			guiSetAlpha(Version.info_label, 0.53)
			guiSetPosition(Version.debug_label, 1, screenH - 30, false)
		end
	end
	
	function Debug:destructor ()
		removeEventHandler("onClientRender", root, self.renderInformations)
	end
end