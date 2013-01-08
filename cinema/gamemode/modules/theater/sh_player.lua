local meta = FindMetaTable("Player")
if !meta then return end

function meta:InTheater()
	return self:GetDTBool(0) or false
end

function meta:SetInTheater( inTheater )
	return self:SetDTBool(0, inTheater or false)
end

function meta:GetTheater()
	return theater.GetByLocation(self:GetLocation())
end