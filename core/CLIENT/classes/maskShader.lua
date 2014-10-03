maskShader = {}

function maskShader:create (image, mask)
	local obj = setmetatable({}, {__index = self})
	obj.imageTex = dxCreateTexture(image or "gamemodes/lobby/FILES/images/account/default.jpg")
	obj.maskTex = dxCreateTexture(mask or "core/FILES/shader/mask/mask.png")
	obj.maskShader = dxCreateShader("core/FILES/shader/mask/maskShader.fx")
	
	if not obj.maskShader then
		error("\n[Shader] Could not create the maskShader. Please user debugscript 3!", 2)
	elseif not obj.imageTex then
		error("\n[Shader] Could not create the imageTexture.", 2)
	elseif not obj.maskTex then
		error("\n[Shader] Could not create the maskTexture.", 2)
	end
	
	dxSetShaderValue(obj.maskShader, "ScreenTexture", obj.imageTex)
	dxSetShaderValue(obj.maskShader, "MaskTexture", obj.maskTex)
	
	outputDebugString("[Shader] The maskShader was successfully created.")
	return obj;
end

function maskShader:update (image, mask)
	if image ~= false then
		destroyElement(self.imageTex)
		self.imageTex = dxCreateTexture(image or "gamemodes/lobby/FILES/images/account/default.jpg")
	end
	if mask ~= false then
		destroyElement(self.maskTex)
		self.maskTex = dxCreateTexture(mask or "core/FILES/shader/mask/mask.png")
	end
	
	dxSetShaderValue(self.maskShader, "ScreenTexture", self.imageTex)
	dxSetShaderValue(self.maskShader, "MaskTexture", self.maskTex)
end

function maskShader:render (x, y, w, h)
	if self.maskShader then
		dxDrawImage(x, y, w, h, self.maskShader)
	end
end

function maskShader:destroy ()
	if self.maskShader then
		destroyElement(self.maskShader)
		outputDebugString("[Shader] The maskShader was successfully destroyed.")
	end
	if self.imageTex then
		destroyElement(self.imageTex)
	end
	if self.maskTex then
		destroyElement(self.maskTex)
	end
	
	self.maskShader = false
	self.imageTex = false
	self.maskTex = false
end