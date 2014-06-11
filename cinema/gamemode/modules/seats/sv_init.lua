ChairOffsets = {
	["models/sunabouzu/lobby_chair.mdl"] = {
		{ Pos = Vector(5.2, 0, 34.1), Ang = Angle(0, 0, 0) }
	},
	["models/gmod_tower/theater_seat.mdl"] = {
		{ Pos = Vector(1, -5, 23), Ang = Angle(10, 180, 0) }
	},
	["models/sunabouzu/theater_curve_couch.mdl"] = {
		{ Pos = Vector(-73.6, 17.3, 18.8), Ang = Angle(0, -128, 0) },
		{ Pos = Vector(-65.2, 50.3, 18.8), Ang = Angle(0, -128, 0) },
		{ Pos = Vector(-37.5, 71.7, 18.8), Ang = Angle(0, -153, 0) },
		{ Pos = Vector(0, 80, 18.8), Ang = Angle(0, -180, 0) },
		{ Pos = Vector(37.5, 71.7, 18.8), Ang = Angle(0, 153, 0) },
		{ Pos = Vector(65.2, 50.3, 18.8), Ang = Angle(0, 128, 0) },
		{ Pos = Vector(73.6, 17.3, 18.8), Ang = Angle(0, 128, 0) },
	},
	["models/sunabouzu/theater_sofa01.mdl"] = {
		{ Pos = Vector(-16.8, -0.9, 16.2), Ang = Angle(0, -180, 0) },
		{ Pos = Vector(16.8, -0.9, 16.2), Ang = Angle(0, -180, 0) },
	},
	["models/props_trainstation/traincar_seats001.mdl"] = {
		{ Pos = Vector(4.6150, 41.7277, 18.5313) },
		{ Pos = Vector(4.7320, 14.4948, 18.5313) },
		{ Pos = Vector(4.5561, -13.3913, 18.5313) },
		{ Pos = Vector(5.4507, -40.9903, 18.5313) },
	},
	["models/props_warehouse/office_furniture_couch.mdl"] = {
		{ Pos = Vector(4.6150, 36, -4) },
		{ Pos = Vector(4.7320, 0, -4) },
		{ Pos = Vector(5.4507, -36, -4) },
	},
	["models/props_warehouse/office_furniture_couch.mdl"] = {
		{ Pos = Vector(4.6150, 36, -4) },
		{ Pos = Vector(4.7320, 0, -4) },
		{ Pos = Vector(5.4507, -36, -4) },
	},
	["models/props_c17/furniturechair001a.mdl"] = {
		{ Pos = Vector(0.30538135766983, 0.14535087347031, -6.69970703125) },
	},
	["models/props_combine/breenchair.mdl"] = {
		{ Pos = Vector(6.8169813156128, -2.8282260894775, 16.551658630371) },
	},
}

DefaultSitSound = Sound("sunabouzu/chair_sit.wav")
ChairSitSounds = {
	["models/sunabouzu/theater_curve_couch.mdl"] = Sound("sunabouzu/couch_sit.wav"),
}

local function HandleRollercoasterAnimation( vehicle, player )
	return player:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) 
end

function CreateSeatAtPos(pos, angle)
	local ent = ents.Create("prop_vehicle_prisoner_pod")
	ent:SetModel("models/nova/airboat_seat.mdl")
	ent:SetKeyValue("vehiclescript","scripts/vehicles/prisoner_pod.txt")
	ent:SetPos(pos)
	ent:SetAngles(angle)
	ent:SetNotSolid(true)
	ent:SetNoDraw(true)

	ent.HandleAnimation = HandleRollercoasterAnimation

	ent:Spawn()
	ent:Activate()

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )

	return ent
end

hook.Add("KeyRelease", "EnterSeat", function(ply, key)
	if key != IN_USE || ply:InVehicle() || (ply.ExitTime && CurTime() < ply.ExitTime + 1) then return end

	local eye = ply:EyePos()
	local trace = util.TraceLine({start=eye, endpos=eye+ply:GetAimVector()*100, filter=ply})

	if !IsValid(trace.Entity) then return end

	local model = trace.Entity:GetModel()

	local offsets = ChairOffsets[model]
	if !offsets then return end

	local usetable = trace.Entity.UseTable or {}
	local pos = -1

	if #offsets > 1 then
		local localpos = trace.Entity:WorldToLocal(trace.HitPos)
		local bestpos, bestdist = -1

		for k,v in pairs(offsets) do
			local dist = localpos:Distance(v.Pos)
			if !usetable[k] && (bestpos == -1 || dist < bestdist) then
				bestpos, bestdist = k, dist
			end
		end

		if bestpos == -1 then return end
		pos = bestpos
	elseif !usetable[1] then
		pos = 1
	else
		return
	end

	usetable[pos] = true
	trace.Entity.UseTable = usetable

	ply.EntryPoint = ply:GetPos()
	ply.EntryAngles = ply:EyeAngles()
	ply.SeatEnt = trace.Entity
	ply.SeatPos = pos

	local ang = trace.Entity:GetAngles()
	if offsets[pos].Ang then
		ang:RotateAroundAxis(trace.Entity:GetForward(), offsets[pos].Ang.p)
		ang:RotateAroundAxis(trace.Entity:GetUp(), offsets[pos].Ang.y)
		ang:RotateAroundAxis(trace.Entity:GetRight(), offsets[pos].Ang.r)
	else
		ang:RotateAroundAxis(trace.Entity:GetUp(), -90)
	end

	local s = CreateSeatAtPos(trace.Entity:LocalToWorld(offsets[pos].Pos), ang)
	s:SetParent(trace.Entity)
	s:SetOwner(ply)

	ply:EnterVehicle(s)

	s:EmitSound( ChairSitSounds[model] or DefaultSitSound, 100, 100 )
end)

hook.Add("CanPlayerEnterVehicle", "EnterSeat", function(ply, vehicle)
	if vehicle:GetClass() != "prop_vehicle_prisoner_pod" then return end

	if vehicle.Removing then return false end
	return (vehicle:GetOwner() == ply)
end)

local airdist = Vector(0,0,48)

function TryPlayerExit(ply, ent)
	local pos = ent:GetPos()
	local trydist = 8
	local yawval = 0
	local yaw = Angle(0, ent:GetAngles().y, 0)

	while trydist <= 64 do
		local telepos = pos + yaw:Forward() * trydist
		local trace = util.TraceEntity({start=telepos, endpos=telepos - airdist}, ply)

		if !trace.StartSolid && trace.Fraction > 0 && trace.Hit then
			ply:SetPos(telepos)
			return
		end

		yaw:RotateAroundAxis(yaw:Up(), 15)
		yawval = yawval + 15
		if yawval > 360 then
			yawval = 0
			trydist = trydist + 8
		end
	end

	print("player", ply, "couldn't get out")
end

local function PlayerLeaveVehicle( vehicle, ply )
	if vehicle:GetClass() != "prop_vehicle_prisoner_pod" then return end

	if !IsValid(ply.SeatEnt) then
		return true
	end

	if ply.SeatEnt && ply.SeatEnt.UseTable then
		ply.SeatEnt.UseTable[ply.SeatPos] = false
	end
	ply.SeatPos = 0
	ply.SeatEnt = nil

	ply.ExitTime = CurTime()
	ply:ExitVehicle()

	ply:SetEyeAngles(ply.EntryAngles)

	local trace = util.TraceEntity({start=ply.EntryPoint, endpos=ply.EntryPoint}, ply)

	if vehicle:GetPos():Distance(ply.EntryPoint) < 128 && !trace.StartSolid && trace.Fraction > 0 then
		ply:SetPos(ply.EntryPoint)
	else
		TryPlayerExit(ply, vehicle)
	end

	if !vehicle.bSlots then
		vehicle.Removing = true
		vehicle:Remove()
	end

	ply:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )

	return false

end

hook.Add("CanExitVehicle", "Leave", PlayerLeaveVehicle)

function PlayerExitLeft( ply )
	if ply:IsPlayer() then
		local Vehicle = ply:GetVehicle()
		
		if IsValid( Vehicle ) then
			PlayerLeaveVehicle( Vehicle, ply )
		end
	end
end

hook.Add("PlayerLeaveVehicle", "VehicleLeft", PlayerExitLeft)
hook.Add("PlayerDeath", "VehicleKilled", PlayerExitLeft)
hook.Add("PlayerSilentDeath", "VehicleKilled", PlayerExitLeft)
hook.Add("EntityRemoved", "VehicleCleanup", PlayerExitLeft)
