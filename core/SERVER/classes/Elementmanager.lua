-- This is the Elementmanager for a MultiGamemode
-- (it needs to be a part of the Gamemode-Class)

function Gamemode:createBlip (...)
	local element = createBlip(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createBlipAttachedTo (...)
	local element = createBlipAttachedTo(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCircle (...)
	local element = createColCircle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCuboid (...)
	local element = createColCuboid(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColPolygon (...)
	local element = createColPolygon(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColRectangle (...)
	local element = createColRectangle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColSphere (...)
	local element = createColSphere(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColTube (...)
	local element = createColTube(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createMarker (...)
	local element = createMarker(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Marker"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createObject (...)
	local element = createObject(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Object"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPed (...)
	local element = createPed(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Ped"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPickup (...)
	local element = createPickup(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Pickup"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createRadarArea (...)
	local element = createRadarArea(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["RadarArea"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createVehicle (...)
	local element = createVehicle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Vehicle"], element)
		return element;
	else
		return false;
	end
end