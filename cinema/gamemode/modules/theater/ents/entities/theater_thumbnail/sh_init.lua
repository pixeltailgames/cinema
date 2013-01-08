ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.Model = Model( "models/sunabouzu/thumbnail_case.mdl" )

function ENT:SetupDataTables()
	self:DTVar("String", "name", 0)
	self:DTVar("String", "title", 1)
	self:DTVar("String", "thumbnail", 2)
end

function ENT:TheaterName()
	return self:GetDTString(0)
end

function ENT:Title()
	return self:GetDTString(1)
end

function ENT:ThumbnailURL()
	return self:GetDTString(2)
end

function ENT:OnRemove()

	if CLIENT and ValidPanel(self.HTML) then
		self.HTML:Remove()
	end

end

function ENT:UpdateTransmitState()
    return TRANSMIT_PVS
end