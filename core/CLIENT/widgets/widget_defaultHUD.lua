widget_defaultHUD = {}

function widget_defaultHUD:create ()
	self.skin = maskShader:create("gamemodes/lobby/FILES/images/account/default.jpg", "core/FILES/shader/mask/mask_round.png")
	
	setPlayerHudComponentVisible("all", false)
	showChat(false)
	
	--self.renderTarget = dxCreateRenderTarget(305, 120, true)
	self.renderTarget = dxMoveable:createMoveable(305, 100, true)
	self.renderTarget.posX, self.renderTarget.posY = 10, 10
		
	self.renderFunc = function () self:render() end
	addEventHandler("onClientRender", root, self.renderFunc)
end

function widget_defaultHUD:render ()
	localPlayer.level = localPlayer.level or 25
	localPlayer.currEXP = localPlayer.currEXP or 55522
	localPlayer.nextlvlEXP = localPlayer.nextlvlEXP or 70000
	localPlayer.percentEXP = localPlayer.percentEXP or (localPlayer.nextlvlEXP / localPlayer.currEXP) * 100

	if fileExists(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer))) then
		self.skin:update(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer)), false)
	else
		self.skin:update("gamemodes/lobby/FILES/images/account/default.jpg", false)
	end
	
	dxSetRenderTarget(self.renderTarget.renderTarget, true)
		dxSetBlendMode("modulate_add")
	
		self.skin:render(0, 0, 100, 100)
		dxDrawText(getMainTime(), 104, 0, 176, 27, tocolor(255, 255, 255, 255), 2.00, "sans", "left", "top", false, false, false, false, false)
		dxDrawLine(104, 27, 285, 27, tocolor(255, 255, 255, 255), 1, false)
		if DEBUG then
			dxDrawText(("%s ( %sms )"):format(localPlayer.name, localPlayer.ping), 176, 9, 286, 27, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		else
			dxDrawText(("%s"):format(localPlayer.name), 176, 9, 286, 27, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		end
		dxDrawRectangle(104, 46, 182, 14, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(104, 46, ((182 / localPlayer.percentEXP) * 100), 14, tocolor(254, 138, 0, 189), false)
		dxDrawText(("Level: %s"):format(localPlayer.level), 104, 30, 286, 44, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "bottom", true, false, false, false, false)
		dxDrawText(("%s $"):format(convertNumber(localPlayer.money)), 104, 30, 286, 44, tocolor(255, 255, 255, 255), 1.00, "default-bold", "right", "bottom", true, false, false, false, false)
		dxDrawText(("%s / %s EXP"):format(localPlayer.currEXP, localPlayer.nextlvlEXP), 104, 46, 286, 60, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		--dxDrawText("", 124, 80, 306, 94, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false) -- "+ 3999 EXP"
		dxDrawRectangle(104, 65, 182, 14, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(104, 65, ((182 * localPlayer.health) / 100), 14, (localPlayer.health > 20 and tocolor(0, 125, 0, 189) or tocolor(125, 0, 0, 255)), false)
		dxDrawRectangle(104, 65, ((182 * localPlayer.armor) / 100), 14, tocolor(0, 0, 125, 189), false)
		dxDrawText(("%s %s"):format(math.round(localPlayer.health), "%"), 104, 65, 286, 79, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
	
		--[[
		self.skin:render(20, 20, 100, 100)
		dxDrawRectangle(20, 20, 100, 100)
		dxDrawText(getMainTime(), 124, 20, 196, 47, tocolor(255, 255, 255, 255), 2.00, "sans", "left", "top", false, false, false, false, false)
		dxDrawLine(124, 47, 305, 47, tocolor(255, 255, 255, 255), 1, false)
		if DEBUG then
			dxDrawText(("%s ( %sms )"):format(localPlayer.name, localPlayer.ping), 196, 29, 306, 47, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		else
			dxDrawText(("%s"):format(localPlayer.name), 196, 29, 306, 47, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		end
		dxDrawRectangle(124, 66, 182, 14, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(124, 66, ((182 / localPlayer.percentEXP) * 100), 14, tocolor(254, 138, 0, 189), false)
		dxDrawText(("Level: %s"):format(localPlayer.level), 124, 52, 306, 66, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "bottom", true, false, false, false, false)
		dxDrawText(("%s $"):format(convertNumber(localPlayer.money)), 124, 52, 306, 66, tocolor(255, 255, 255, 255), 1.00, "default-bold", "right", "bottom", true, false, false, false, false)
		dxDrawText(("%s / %s EXP"):format(localPlayer.currEXP, localPlayer.nextlvlEXP), 124, 66, 306, 80, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		dxDrawText("", 124, 80, 306, 94, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false) -- "+ 3999 EXP"
		dxDrawRectangle(124, 84, 182, 14, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(124, 84, ((182 * localPlayer.health) / 100), 14, (localPlayer.health > 20 and tocolor(0, 125, 0, 189) or tocolor(125, 0, 0, 255)), false)
		dxDrawRectangle(124, 84, ((182 * localPlayer.armor) / 100), 14, tocolor(0, 0, 125, 189), false)
		dxDrawText(("%s %s"):format(math.round(localPlayer.health), "%"), 124, 84, 306, 98, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		--dxDrawRectangle(124, 102, 182, 14, tocolor(0, 0, 0, 137), false)
		--dxDrawRectangle(124, 102, (182 * localPlayer.armor) / 100, 14, tocolor(0, 36, 96, 189), false)
		--dxDrawText(("%s %s"):format(localPlayer.armor, "%"), 124, 102, 306, 116, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		--]]
		
		dxSetBlendMode("blend")
	dxSetRenderTarget()
	
	dxDrawImage(self.renderTarget.posX, self.renderTarget.posY, self.renderTarget.w, self.renderTarget.h, self.renderTarget.renderTarget)
end

function widget_defaultHUD:destroy ()
	self.skin:destroy()
	
	setPlayerHudComponentVisible("all", true)
	showChat(true)
	
	removeEventHandler("onClientRender", root, self.renderFunc)
end

widget_defaultHUD:create()