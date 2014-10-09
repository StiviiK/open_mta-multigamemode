dxMoveable = {
	elements = {}
}

function dxMoveable:createMoveable (w, h, b)
	local self = setmetatable({
		renderTarget = dxCreateRenderTarget(w, h, b),
		posX = 0,
		posY = 0,
		w = w,
		h = h,
		cursorOffX = 0,
		cursorOffY = 0,
		alpha = 100,
		tempposX = 0,
		tempposY = 0
	}, {
		__index = self
	})
	
	if not dxMoveable.renderFunc then
		dxMoveable.renderFunc = bind(dxMoveable.render, dxMoveable)
		addEventHandler("onClientRender", root, dxMoveable.renderFunc)
	end
	
	table.insert(dxMoveable.elements, 1, self)
	
	return self;
end

function dxMoveable:destroyElement ()
	if isElement(self.renderTarget) then
		dxSetRenderTarget(self.renderTarget, true)
			-- Clear it.
		dxSetRenderTarget()
		
		destroyElement(self.renderTarget)
	end

	if table.find(dxMoveable.elements, self) then 
		table.remove(dxMoveable.elements, table.find(dxMoveable.elements, self))
	end
	
	if table.getn(dxMoveable.elements) == 0 then
		removeEventHandler("onClientRender", root, dxMoveable.renderFunc)
		dxMoveable.renderFunc = nil
	end
end

function dxMoveable:render ()
	if Cursor.active then
		local currElement = nil
		for i, v in ipairs(self.elements or {}) do
			if isCursorOverRectangle(v.posX, v.posY, v.w , v.h) then
				--error("YEAH")
				currElement = v
				break;
			end
		end
		

		currElement = Cursor.currElement or currElement
		
		if currElement then
			if Cursor.currElement == currElement then
				currElement.alpha = 150
				currElement.tempposX, currElement.tempposY = Cursor.newX + currElement.cursorOffX, Cursor.newY + currElement.cursorOffY
				
				if (currElement.tempposX - 10 >= 0) and (currElement.tempposX + 10 <= (screenW - currElement.w)) and (currElement.tempposY - 10 >= 0) and (currElement.tempposY + 10 <= (screenH - currElement.h)) then
					currElement.posX, currElement.posY = currElement.tempposX, currElement.tempposY
				end
			else
				if currElement.alpha == 150 then
					currElement.alpha = 100
				end
			end
			
			dxDrawRectangle(currElement.posX - 10, currElement.posY - 10, currElement.w + 20, currElement.h + 20, tocolor(255, 255, 255, currElement.alpha))
		end
	end
end