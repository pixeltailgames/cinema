local cinema_thirdpersondist = CreateClientConVar("cinema_thirdpersondistance", 100, true)
if SERVER then
	util.AddNetworkString("cinema_querykinect")
else //CLIENT
	concommand.Add("cinema_startkinect", function(ply, cmd, args ) 
		local available = motionsensor && motionsensor.IsAvailable() 
		if !available then 
			print("You don't have an enabled device!") 
			RunConsoleCommand("act", "muscle")
			return 
		end
		
		net.Start("cinema_querykinect")
		net.SendToServer()

		if (!motionsensor.IsActive() ) then
			motionsensor.Start()
		end
	end )

	hook.Add( "KeyPress", "TheaterTurnOffController", function( ply, key )
		if key == IN_FORWARD || key == IN_BACK || key == IN_MOVELEFT || key == IN_MOVERIGHT || key == IN_JUMP then
			if ply:GetDTBool( 3) then
				RunConsoleCommand("cinema_stopkinect")
			end
		end
	end )

end

net.Receive("cinema_querykinect", function(length, ply)
	if IsValid( ply ) && !IsValid( ply.rag ) then
		ply.rag = ents.Create("prop_ragdoll")
		ply.rag:SetModel( ply:GetModel() )
		ply.rag:SetPos( ply:GetPos() + ply:GetViewOffset() )
		ply.rag:Spawn()
		ply.rag:Activate()
		ply.rag:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		ply.rag.Controlled = true
		ply.rag:SetOwner( ply )

		ply.controller = ents.Create("ragdoll_motion")
		ply.controller:SetPos( ply:GetPos() + ply:GetViewOffset() )
		ply.controller:SetAngles( Angle( 0, ply:EyeAngles().yaw, 0 ))
		ply.controller:SetRagdoll( ply.rag )
		ply.controller:SetController( ply )
		ply.controller:Spawn()
		ply.controller.Controlled = true
		ply.controller:SetOwner( ply )


		ply:SetDTBool( 3, true ) //set the last dtvar so if we add more and no one found this yet things wont break
		ply:SetDTEntity( 3, ply.rag )
		ply:SetNoDraw( true )
		ply.ViewSelfAng = ply:EyeAngles()
	end
end )

concommand.Add("cinema_stopkinect", function(ply, cmd, args ) 
	if SERVER then
		if IsValid( ply ) then
			ply:SetNoDraw( false )
			if IsValid( ply.rag ) then ply.rag:Remove() end
			if IsValid( ply.controller ) then ply.controller:Remove() end

			ply:SetDTBool( 3, false )
			ply:SetDTEntity( 3, nil )
		end
	end
end )

hook.Add("PlayerDisconnected", "TheaterCleanControllers", function()

	timer.Simple( 3, function() 
		for k, v in pairs( ents.GetAll() ) do
			if IsValid( v ) && v.Controlled && !IsValid( v:GetOwner() ) then v:Remove() end
		end
	end )
end )

hook.Add( "InputMouseApply", "TheaterViewRagdoll", function( cmd, x, y, ang )

	local ply = LocalPlayer()

	if IsValid(ply) and ply:GetDTBool( 3) then

		local ang = ply.ViewSelfAng or ang
		local yaw = ( x * -GetConVar( "m_yaw" ):GetFloat() )
		local pitch = ( y * GetConVar( "m_pitch" ):GetFloat() )
		
		ang.y = ang.y + yaw
		ang.p = ang.p + pitch

		ply.ViewSelfAng = ang

		return true

	end

end )

hook.Add("CalcView", "TheaterSpectateRagdoll", function(ply, pos, ang, fov)

	if ply:GetDTBool( 3) && IsValid( ply:GetDTEntity(3) ) then
		local fwd = ply.ViewSelfAng or ply:EyeAngles()
		
		local ragdoll = ply:GetDTEntity( 3)
		local dist = math.Clamp(cinema_thirdpersondist:GetInt(), 10, 1500)
		local center = ragdoll:GetPos() + Vector( 0, 0, 50 )
		local trace = util.TraceLine({start = center, endpos = center + fwd:Forward() * -dist, mask = MASK_OPAQUE})
		if trace.Fraction < 1 then
			dist = dist * trace.Fraction
		end
		
		return {
			["origin"] = center + (fwd:Forward() * -dist * 0.95),
			["angles"] = Angle(fwd.p + 2, fwd.y, fwd.r)
		}

	end
	
end )

hook.Add("RenderScreenspaceEffects", "TheaterRagdollDisableLegs", function()
	if IsValid(LocalPlayer()) and LocalPlayer():GetDTBool(3) then
		LocalPlayer().ShouldDisableLegs = true
	end
end )