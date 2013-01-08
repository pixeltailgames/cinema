module( "Location", package.seeall )


hook.Add( "PlayerThink", "LocationThink", function( ply )

	local oldloc = ply:GetLocation()
	local loc = Find( ply )
	if oldloc == loc then return end
	
	ply:SetLocation(loc)

	-- Player, New Location, Old Location
	hook.Call( "PlayerChangeLocation", GAMEMODE, ply, loc, oldloc )

end )

-- Lua refresh theater fix (used in development)
hook.Add("OnReloaded", "ResetPlayerLocations", function()
	timer.Simple( 0.1, function()
		for _, ply in pairs(player.GetAll()) do
			ply:SetInTheater(false)
			hook.Call( "PlayerChangeLocation", GAMEMODE, ply, ply:GetLocation(), 0 )
		end
	end)
end)