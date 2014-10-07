Version = {}

function Version:constructor ()
	self.ver_label = guiCreateLabel(screenW - 251, screenH - 30, 250, 18, "Open MTA:Multigamemode "..(VERSION or "[unknown build]"), false)
	self.debug_label = guiCreateLabel(1, screenH - 15, 500, 18, ("Debugging-Mode: %s"):format(DEBUG and "enabled" or "disabled"), false)
	guiSetAlpha(self.debug_label, 0.53)
	guiSetAlpha(self.ver_label, 0.53)
	guiLabelSetHorizontalAlign(self.ver_label, "right", false)
	
	if DEBUG and string.find(VERSION, "dev") then
		self.info_label = guiCreateLabel(1, screenH - 15, 500, 18, "WARNING: This Server is running a Development Build! ("..VERSION..")", false)
		guiSetAlpha(self.info_label, 0.53)
		guiSetPosition(self.debug_label, 1, screenH - 30, false)
	end
end

function Version:destructor ()
	if isElement(self.ver_label) then
		destroyElement(self.ver_label)
		self.ver_label = nil
	end
end
Version:constructor() -- Change!