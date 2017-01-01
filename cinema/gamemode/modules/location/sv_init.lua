module( "Location", package.seeall )

-- Prevent sending clients a theater video too early
local DelayThinkSeconds = 3

function Initialize()
	if LocBrushes != {} then
		for brushKey, brush in pairs(LocBrushes) do
			if IsValid(brush) then -- This refuses to be true, for some reason...
				brush:Remove()
			end
			brush = nil
			LocBrushes[brushKey] = nil
		end
	end
	for locName, loc in pairs(GetLocations()) do
		local brush = ents.Create("base_brush")
		brush:Spawn()
		brush:SetSolid(SOLID_BBOX)
		brush:SetCollisionBoundsWS(loc.Min, loc.Max)
		brush:SetTrigger(true)
		brush.locIndex = loc.Index
		function brush:EndTouch(ply)
			if !ply:IsPlayer() then return end
			while IsValid(ply) do
				repeat
					if RealTime() - ply.LocationChangeTime > 2 then -- Make sure they didn't _just_ change location
						ply:SetLocation(0) -- Set to Unknown after exiting a Brush Area in case they're not entering another one
					end
					
					break
				until ply:IsConnected() and (ply:TimeConnected() >= DelayThinkSeconds)
				break
			end
		end
		function brush:StartTouch(ply)
			if !ply:IsPlayer() then return end
			while IsValid(ply) do
				repeat
					local oldloc = ply:GetLocation()
					local loc = self.locIndex
					if oldloc == loc then return end
					
					ply:SetLocation(loc)
					ply.LocationChangeTime = RealTime()
					
					-- Player, New Location, Old Location
					hook.Call( "PlayerChangeLocation", GAMEMODE, ply, loc, oldloc )
					break
				until ply:IsConnected() and (ply:TimeConnected() >= DelayThinkSeconds)
				break
			end
		end
		table.insert(LocBrushes, brush)
	end
end

hook.Add("OnReloaded", "ReinitializeLocationBrushes", function()
	timer.Simple(0.5, function()
		Initialize()
	end)
end)

hook.Add("InitPostEntity", "InitializeLocationBrushes", function()
	timer.Simple(0.5, function()
		Initialize()
	end)
end)

-- Lua refresh theater fix (used in development)
hook.Add("OnReloaded", "ResetPlayerLocations", function()
	timer.Simple( 0.1, function()
		for _, ply in pairs(player.GetAll()) do
			ply:SetInTheater(false)
			hook.Call( "PlayerChangeLocation", GAMEMODE, ply, ply:GetLocation(), 0 )
		end
	end)
end)
