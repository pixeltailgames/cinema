local meta = FindMetaTable("Player")
if !meta then return end

function meta:GetLocation()
	return self:GetDTInt(0) or 0
end

function meta:GetLastLocation()
	return self.LastLocation or -1
end

function meta:GetLocationName()
	return Location.GetLocationNameByIndex( self:GetLocation() )
end

function meta:SetLocation(locationId)
	self.LastLocation = self:GetLocation()
	return self:SetDTInt(0, locationId)
end