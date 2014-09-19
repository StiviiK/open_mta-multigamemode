-- This is the Elementmanager for a MultiGamemode
-- (it needs to be a part of the Gamemode-Class)

function Gamemode:getElementsByType (type, startat)
	-- Todo: At startat abillity
	return self.Elements[type] or {};
end

function Gamemode:destroyElement (element)
	if isElement(element) then -- Todo: Check if it is an Element in the Gamemode
		for type, table in pairs(self.Elements) do
			for index, ele in ipairs(table) do
				if ele == element then
					destroyElement(element)
					return true
				end
			end
		end
	end
	
	return false
end

function Gamemode:createBlip (...)
	local element = createBlip(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createBlipAttachedTo (element, ...)
	if (getElementDimension(element) ~= self.Dimension) then
		setElementDimension(element, self.Dimension)
	end
	
	local element = createBlipAttachedTo(element, ...)
	setElementDimension(element, self.Dimensio)
		
	if (element) then
		table.insert(self.Elements["blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCircle (...)
	local element = createColCircle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCuboid (...)
	local element = createColCuboid(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColPolygon (...)
	local element = createColPolygon(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColRectangle (...)
	local element = createColRectangle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColSphere (...)
	local element = createColSphere(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColTube (...)
	local element = createColTube(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["colshape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createMarker (...)
	local element = createMarker(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["marker"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createObject (...)
	local element = createObject(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["object"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPed (...)
	local element = createPed(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ped"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPickup (...)
	local element = createPickup(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["pickup"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createRadarArea (...)
	local element = createRadarArea(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["radararea"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createVehicle (...)
	local element = createVehicle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["vehicle"], element)
		return element;
	else
		return false;
	end
end
