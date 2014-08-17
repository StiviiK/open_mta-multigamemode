infobox = {}

function infobox:new(...)
	local obj = setmetatable({}, {__index = self})
	obj.timer = nil
	if not obj.add then
		return false
	end
	return obj
end

function infobox:add(_, text, typ)
	self.text = text
	self.typ = typ
	if getTimerDetails(self.timer) >= 1 then
		addEventHandler("onClientRender", getRootElement(), function()
			self:draw()
		end)
		self.timer = setTimer(removeEventHandler, 7500, 1, "onClientRender", getRootElement(), bind(self.draw, self))
	else
		if isTimer(self.timer) then
			killTimer(self.timer)
		end
		self.timer = setTimer(removeEventHandler, 7500, 1, "onClientRender", getRootElement(), bind(self.draw, self))
	end
end

function infobox:draw()
	if self.typ == 1 then
		self.color = {{0, 125, 0, 255}, {255, 255, 255, 255}} -- {{bgcolor}, {textcolor}}
	elseif self.typ == 2 then
		self.color = {{125, 0, 0, 255}, {255, 255, 255, 255}} -- {{bgcolor}, {textcolor}}
	else
		if isTimer(self.timer) then
			return self:add("infobox error - contact the administration", 2)
		end
	end
	-- Draw
	dxDrawRectangle(0, 0, 0, 0, tocolor(unpack(self.color)), true)
	dxDrawText(self.text, 0, 0, 0, 0, tocolor(unpack(self.color)), 1, 'default-bold', 'left', 'top', false, true, true)
end

infobox:new()