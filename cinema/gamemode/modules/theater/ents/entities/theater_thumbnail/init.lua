AddCSLuaFile('cl_init.lua')
AddCSLuaFile('sh_init.lua')
include('sh_init.lua')

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