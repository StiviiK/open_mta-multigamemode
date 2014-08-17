-- #######################################
-- ## Project: MTA Ekonomie				##
-- ## Name: dxClass.lua					##
-- ## Author: StiviK					##
-- ## Version: 1.0						##
-- #######################################

-- CLASS TABLE --
dxElement = {};

setmetatable(dxElement, {
	__call = function (_, type, ...)
		local self = setmetatable({}, {__index = dxElement})
		self.screenX, self.screenY = guiGetScreenSize()
		
		if (type:lower() == "edit") then
			self:createEdit(...)
		elseif (type:lower() == "button") then
			self:createButton(...)
		end
		
		outputDebugString("[CALLING] dxElement: Constructor ("..tostring(self)..")")
		
		return self;
	end
})

-- CLASS FUNCTION (edit) --
function dxElement:createEdit (x, y, w, h, text, size, font, c1, c2, c3, a, pg, masked)
	if type(x) == "number" and type(y) == "number" and type(w) == "number" and type(h) == "number" and type(text) == "string" and type(size) == "number" and type(c1) == "number" and type(c2) == "number" and type(c3) == "number" and type(a) == "number" and type(pg) == "boolean" and type(masked) == "boolean" then
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self.t = text
		self.mt = ""
		self.tmt = ""
		self.s = size
		self.f = font
		self.c1 = c1
		self.c2 = c2
		self.c3 = c3
		self.a = a
		self.pg = pg
		self.m = masked
		self.editable = true
		self.sh = false
		self.backTimer = false
		
		-- functions
		self.render = function () self:renderEdit() end		
		self.onClick = function (button, state) self:onEditClick(button, state) end
		self.onCharacter = function (character, press) self:onEditCharacter(character, press) end
		
		-- insert in da table
		self.handles = {
			["onClick"] = self.onClick,
			["onClientRender"] = self.render,
			["onClientKey"] = self.onCharacter
		}
		
		-- eventhandlers
		addEventHandler("onClientClick", root, self.onClick)
		addEventHandler("onClientKey", root, self.onCharacter)
		addEventHandler("onClientRender", root, self.render)
	else
		outputDebugString("[dxElement] Bad Argument @ 'createEdit'", 1)
	end
end

function dxElement:renderEdit ()
	dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(self.c1, self.c2, self.c3, self.a), self.pg)
		
	if self.m then
		for i = 1, #self.t do
			self.mt = "*"..self.mt
			self.tmt = self.mt
		end
				
		if self.tactv then
			dxDrawText(self.mt.."|", self.x + 2, (self.y+(self.h/2)), self.x, (self.y+(self.h/2)), tocolor(0, 0, 0, 255), self.s, self.f, "left", "center", false, false, self.pg)
		else
			dxDrawText(self.mt, self.x + 2, (self.y+(self.h/2)), self.x, (self.y+(self.h/2)), tocolor(0, 0, 0, 255), self.s, self.f, "left", "center", false, false, self.pg)
		end
				
		self.mt = ""
	else
		if self.tactv then
			dxDrawText(self.t.."|", self.x + 2, (self.y+(self.h/2)), self.x, (self.y+(self.h/2)), tocolor(0, 0, 0, 255), self.s, self.f, "left", "center", false, false, self.pg)
		else
			dxDrawText(self.t, self.x + 2, (self.y+(self.h/2)), self.x, (self.y+(self.h/2)), tocolor(0, 0, 0, 255), self.s, self.f, "left", "center", false, false, self.pg)
		end
	end
end

local validKeys = {
	'a',
	'b',
	'c',
	'd',
	'e',
	'f',
	'g',
	'h',
	'i',
	'j',
	'l',
	'k',
	'm',
	'n',
	'o',
	'p',
	'q',
	'r',
	's',
	't',
	'u',
	'v',
	'w',
	'x',
	'y',
	'z',
	'backspace',
	'space',
	'lshift',
	'-',
	'.',
	',',
	'0',
	'1',
	'2',
	'3',
	'4',
	'5',
	'6',
	'7',
	'8',
	'9',
	'<'
}

local specialKeys = {
	["q"] = "@"
}

function dxElement:isValidKey (character)
	for _, key in ipairs(validKeys) do
		if key:lower() == character:lower() then
			return true;
		end
	end
		
	return false;
end

function dxElement:isCursorOverEdit ()
	if self ~= nil then
		local cX, cY = getCursorPosition()
		
		if isCursorShowing() then
			return ((cX*self.screenX > self.x) and (cX*self.screenX < self.x+self.w)) and ( (cY*self.screenY > self.y) and (cY*self.screenY < self.y+self.h));
		else
			return false;
		end
	end
end

function dxElement:onEditClick (button, state)
	if self ~= nil then
		if (button == "left") and (state == "down") then
			if self:isCursorOverEdit() then
				self.tactv = true;
			else
				self.tactv = false;
			end
		end
	end
end

function dxElement:onEditCharacter (character, press)
	if self.tactv and (self.editable) then
		if (press) then
			if (character == "lshift") then
				self.sh = true
				return;
			elseif (character == "ralt") then
				self.ralt = true
				return;
			elseif (character == "backspace") then
				self.backTimer = setTimer(
					function ()
						self.t = string.sub(self.t, 1, #self.t - 1)
						return;
					end, 100, -1)
				return;
			end	
		
			if self:isValidKey(character) and (not isChatBoxInputActive()) and (not isConsoleActive()) and (not isMainMenuActive()) then
				if (not self.m) then
					if (character == "space") and (dxGetTextWidth(self.t, self.s, self.f) <= (self.w) - 14) then
						self.t = self.t.." "
						return;
					end
					
					if (character == "backspace") and (#self.t > 0) then
						self.t = string.sub(self.t, 1, #self.t - 1)
						return;
					end
					
					if (character ~= "backspace") and (dxGetTextWidth(self.t, self.s, self.f) <= (self.w) - 14) then
						if (self.sh) then
							self.t = self.t..character:upper()
						elseif (self.ralt) then
							self.t = self.t..specialKeys[character:lower()]
						else
							self.t = self.t..character
						end
					end
				else
					if (character == "space") and (dxGetTextWidth(self.tmt, self.s, self.f) <= (self.w) - 14) then
						self.t = self.t.." "
						return;
					end
					
					if (character == "backspace") and (#self.t > 0) then
						self.t = string.sub(self.t, 1, #self.t - 1)
						return;
					end
						
					if (character ~= "backspace") and (dxGetTextWidth(self.tmt, self.s, self.f) <= (self.w) - 14) then
						if (self.sh) then
							self.t = self.t..character:upper()
						elseif (self.ralt) then
							self.t = self.t..specialKeys[character:lower()]
						else
							self.t = self.t..character
						end
					end
				end
			end
		else
			if (character == "lshift") then
				self.sh = false
				return;
			elseif (character == "ralt") then
				self.ralt = false
				return;
			elseif (character == "backspace") then
				if (isTimer(self.backTimer)) then
					killTimer(self.backTimer)
				end
			end	
		end
	end
end

function dxElement:setEditText (text)
	if self ~= nil then
		if type(text) == "string" then
			self.t = text;
			
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

function dxElement:getEditText ()
	if self ~= nil then
		return self.t;
	end
end

function dxElement:setEditColor (c1, c2, c3, alpha)
	if self ~= nil then
		if type(c1) == "number" and type(c2) == "number" and type(c3) == "number" and type(alpha) == "number" then
			self.c1 = c1
			self.c2 = c2
			self.c3 = c3
			self.a = alpha
			
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

-- CLASS FUNCTION (button) --
function dxElement:createButton (x, y, w, h, text, size, font, c1, c2, c3, a, pg, funcname, hover, click, image, ...)
	if type(x) == "number" and type(y) == "number" and type(w) == "number" and type(h) == "number" and type(text) == "string" and type(size) == "number" and type(c1) == "number" and type(c2) == "number" and type(c3) == "number" and type(funcname) == "function" then
		
		if (hover == nil) then
			hover = true
		end
			
		if (click == nil) then
			click = true
		end
			
		if (click and (not hover)) then	-- Hover needs to be true for click
			hover = true 
		end
		
		self.x = x
		self.y = y
		self.w = w
		self.h = h
		self.t = text
		self.s = size
		self.f = font
		self.pg = pg
		self.c1 = c1
		self.c2 = c2
		self.c3 = c3
		self.a = a
		self.cfunc = funcname
		self.click = click
		self.hover = hover
		self.image = image
		self.arg = {...}
	
		-- functions
		self.render = function () self:renderButton() end
		self.onClick = function (button, state) self:onClickOnButton(button, state) end
		
		-- insert in da table
		self.handles = {
			["onClientClick"] = self.onClick,
			["onClientRender"] = self.render
		}
		
		-- eventhandlers
		addEventHandler("onClientClick", root, self.onClick)
		addEventHandler("onClientRender", root, self.render)
	else
		outputDebugString("Bad Argument @ 'dxCreateButton'", 1)
	end
end

function dxElement:renderButton ()
	if (not self.image) then
		if self:isCursorOverButton() then
			dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(self.c1 + 50, self.c2 + 50, self.c3 + 50, self.a), self.pg)
		else
			dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(self.c1, self.c2, self.c3, self.a), self.pg)
		end
				
		dxDrawText(self.t, (self.x+(self.w/2)), (self.y+(self.h/2)), (self.x+(self.w/2)), (self.y+(self.h/2)), tocolor(255, 255, 255, self.a), self.s, self.f, "center", "center", false, false, self.pg)
	else
		dxDrawImage(self.x, self.y, self.w, self.h, self.image, 0, 0, 0, tocolor(255, 255, 255, self.a), pg)
		dxDrawText(self.t, self.x + (50)*px, self.y + (120)*py, self.x, self.y, tocolor(255, 255, 255, 255), size, font, "center", "center", false, false, self.pg)
	end
end

function dxElement:isCursorOverButton ()
	if self ~= nil then
		local cX, cY = getCursorPosition()
		
		if isCursorShowing() and self.hover then
			return ((cX*self.screenX > self.x) and (cX*self.screenX < self.x+self.w)) and ( (cY*self.screenY > self.y) and (cY*self.screenY < self.y+self.h));
		else
			return false;
		end
	end
end

function dxElement:onClickOnButton (button, state)
	if (button == "left") and (state == "down") and self ~= nil then		
		if self:isCursorOverButton() and self.click then
			--setSoundVolume(playSound("FILES/sounds/Notification/pop.mp3"), 0.3)
		
			if #self.arg >= 1 then
				self:getButtonFunction()(unpack(self.arg))
			else
				self:getButtonFunction()()
			end
		end
	end
end

function dxElement:getButtonFunction ()
	if self ~= nil then
		return self.cfunc;
	else
		return false;
	end
end

function dxElement:setButtonColor (c1, c2, c3, alpha)
	if self ~= nil then
		if type(c1) == "number" and type(c2) == "number" and type(c3) == "number" and type(alpha) == "number" then
			self.c1 = c1
			self.c2 = c2
			self.c3 = c3
			self.a = alpha
			
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

function dxElement:setButtonPosition (x, y, w, h)
	if self ~= nil then
		if type(x) == "number" and type(y) == "number" and type(w) == "number" and type(h) == "number" then
			self.x = x
			self.y = y
			self.w = w
			self.h = h
			
			return true;
		else
			return false;
		end
	else
		return false;
	end	
end

function dxElement:setButtonText (text)
	if self ~= nil then
		if type(text) == "string" then
			self.t = text
		else
			return false;
		end
	else
		return false;
	end
end

function dxElement:setButtonHoverEnabled (boolean)
	if self ~= nil then
		if type(boolean) == "boolean" then
			self.hover = boolean
		else
			return false;
		end
	else
		return false;
	end
end

function dxElement:setButtonClickable (boolean)
	if self ~= nil then
		if type(boolean) == "boolean" then
			self.click = boolean
			
			if (not self.hover) and (boolean == true) then
				self.hover = true
			end
		else
			return false;
		end
	else
		return false;
	end
end

function dxElement:buttonSetVisible (bool)
    if self ~= nil then
		if type(bool) == "boolean" then
			self.oa = self.a
            self.a = (bool and self.oa) or 0
            self.hover = bool
			self.click = bool
        else
			return false
		end
	else
		return false
	end
end

function dxElement:destructor ()
	if self ~= nil then
		for index, value in pairs(self.handles) do
			removeEventHandler(index, root, value)
		end
		
		outputDebugString("[CALLING] dxElement: Destructor ("..tostring(self)..")")
		
		return true;
	else
		return false;
	end
end