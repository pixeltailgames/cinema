AddCSLuaFile('cl_init.lua')
AddCSLuaFile('sh_init.lua')
include('sh_init.lua')

resource.AddFile( "models/sunabouzu/thumbnail_case.mdl" )
resource.AddFile( "materials/models/sunabouzu/thumbnail_case.vmt" )
resource.AddFile( "materials/theater/STATIC.vmt" )

function ENT:Initialize()

	self:SetModel( self.Model )

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	
	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:EnableMotion( false )
	end

	self:DrawShadow( false )

end

function ENT:SetTheaterName( str )
	self:SetDTString(0, str)
end

function ENT:SetTitle( str )
	self:SetDTString(1, str)
end

function ENT:SetThumbnail( url )
	self:SetDTString(2, url)
end