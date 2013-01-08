ENT.Base = "base_point"
ENT.Type = "anim"

--[[---------------------------------------------------------
   Name: KeyValue
   Desc: Called when a keyvalue is added to us
-----------------------------------------------------------]]
function ENT:KeyValue( key, value )

	if !self.keyvalues then
		self.keyvalues = {}
	end

	self.keyvalues[key] = value

end