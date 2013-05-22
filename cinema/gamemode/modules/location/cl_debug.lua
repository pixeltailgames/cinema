/*

	The Cinema location system is built from old
	GMod Tower code. Credit goes to Voided for
	the beautiful debugging system.

*/

module( "Location", package.seeall )

DebugEnabled = CreateClientConVar( "cinema_debug_locations", "0", false, false )

DebugLocStart = nil
DebugLocEnd = nil

// we use this so that the bottom of a box will be lower than the player's position
FootOffset = Vector( 0, 0, -5 )


/*
	Location editing utilities
	
	These two concommands are designed to simplify location creation.
	Simply run cinema_loc_start, move to create a desired box, then run cinema_loc_end and grab the lua printed to the console.
	This requires you to be an admin!
*/

concommand.Add( "cinema_loc_start", function( ply, cmd, args )
	if !ply:IsAdmin() then return end
	
	DebugLocStart = LocalPlayer():GetPos() + FootOffset
	
	hook.Add( "PostDrawTranslucentRenderables", "CinemaDebugLocation", function()
		Debug3D.DrawBox( DebugLocStart, LocalPlayer():GetPos() )
	end	)
	
end )

concommand.Add( "cinema_loc_end", function ( ply, cmd, args )
	if !ply:IsAdmin() then return end
	
	DebugLocEnd = LocalPlayer():GetPos() + FootOffset
	hook.Remove( "PostDrawTranslucentRenderables", "CinemaDebugLocation" )
	
	local min = DebugLocStart
	local max = DebugLocEnd
	
	if ( min:Length() > max:Length() ) then
		local temp = min
		min = max
		max = temp
	end
	
	OrderVectors( min, max )
	
	MsgN( "[ \"Name\" ] =" )
	MsgN( "{" )
	MsgN( "\tMin = Vector( " .. min.x .. ", " .. min.y .. ", " .. min.z .. " )," )
	MsgN( "\tMax = Vector( " .. max.x .. ", " .. max.y .. ", " .. max.z .. " )," )
	MsgN( "}," )
	
end )

// location visualizer for debugging
hook.Add( "PostDrawTranslucentRenderables", "CinemaDebugLocations", function ()

	if ( !DebugEnabled:GetBool() ) then return end
	
	for k, v in pairs( GetLocations() or {} ) do
	
		local center = ( v.Min + v.Max ) / 2
		
		Debug3D.DrawBox( v.Min, v.Max )
		Debug3D.DrawText( center, k, "HUDNumber5" )
		
		if ( !v.Teleports ) then continue end
		
		for _, tele in ipairs( v.Teleports ) do
		
			local min = tele + Vector( -20, -20, 0 )
			local max = tele + Vector( 20, 20, 80 )
			local center = ( min + max ) / 2
			
			local text = k .. "\nTeleport"
			
			Debug3D.DrawBox( min, max, Color( 0, 255, 0, 255 ) )
			Debug3D.DrawText( center, text, "HUDNumber5", Color( 50, 255, 50, 255 ), 0.25 )
			
		end
	end
	
end )
