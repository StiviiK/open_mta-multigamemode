form_defaultHUD = {}

function form_defaultHUD.create ()
	form_defaultHUD.skin = maskShader:create("gamemodes/lobby/FILES/images/account/default.jpg", "core/FILES/shader/mask/mask_round.png")
	
	setPlayerHudComponentVisible("all", false)
	showChat(false)
	
	addEventHandler("onClientRender", root, form_defaultHUD.render)
end

function form_defaultHUD.render ()
	localPlayer.level = localPlayer.level or 13
	localPlayer.currEXP = localPlayer.currEXP or 23144
	localPlayer.nextlvlEXP = localPlayer.nextlvlEXP or 54345
	localPlayer.percentEXP = localPlayer.percentEXP or (localPlayer.nextlvlEXP / localPlayer.currEXP) * 100

	form_defaultHUD.skin:update("gamemodes/lobby/FILES/images/account/skins/"..getElementModel(localPlayer)..".jpg", false)
	form_defaultHUD.skin:render(20, 20, 100, 100)
	dxDrawText(getMainTime(), 124, 20, 196, 47, tocolor(255, 255, 255, 255), 2.00, "sans", "left", "top", false, false, false, false, false)
	dxDrawLine(124, 47, 305, 47, tocolor(255, 255, 255, 255), 1, false)
	dxDrawText(localPlayer.name, 196, 29, 306, 47, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
	dxDrawRectangle(124, 66, 182, 14, tocolor(0, 0, 0, 137), false)
	dxDrawRectangle(124, 66, (182 / localPlayer.percentEXP) * 100, 14, tocolor(254, 138, 0, 189), false)
	dxDrawText(("Level: %s"):format(localPlayer.level), 124, 52, 306, 66, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "bottom", true, false, false, false, false)
	dxDrawText(("%s / %s EXP"):format(localPlayer.currEXP, localPlayer.nextlvlEXP), 124, 66, 306, 80, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("", 124, 80, 306, 94, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false) -- "+ 3999 EXP"
end

function form_defaultHUD.destroy ()
	form_defaultHUD.skin:destroy()
	
	setPlayerHudComponentVisible("all", true)
	showChat(true)
	
	removeEventHandler("onClientRender", root, form_defaultHUD.render)
end

form_defaultHUD.create()