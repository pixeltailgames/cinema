
include( 'shared.lua' )

/*
	Unsupported Notifications
*/
local MapFont = "MapFont"
local p = 10
local w, h
local MapMessage
surface.CreateFont( MapFont, { font = "Open Sans Condensed Light", size = 28, weight = 200 } )

if Location and !Location.GetLocations() then

	MapMessage = "The current map is unsupported by the Cinema gamemode"
	local MapMessage2 = "Press F1 to open the official map on workshop"

	hook.Add( "HUDPaint", "DrawMapMessage", function()
		
		surface.SetFont( MapFont )

		w, h = surface.GetTextSize( MapMessage )
		draw.RoundedBox( 4, (ScrW()/2) - w/2 - p, h - p, w + p*2, h + p*2, Color(0,0,0,200) )
		draw.SimpleText( MapMessage, MapFont, ScrW() / 2, h, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
		
		w, h = surface.GetTextSize( MapMessage2 )
		draw.RoundedBox( 4, (ScrW()/2) - w/2 - p, h - p + h*2, w + p*2, h + p*2, Color(0,0,0,200) )
		draw.SimpleText( MapMessage2, MapFont, ScrW() / 2, h*3, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

	end )

	control.Add( KEY_F1, function( enabled, held )
		if enabled and !held then
			steamworks.ViewFile( 119060917 )
		end
	end )

elseif system.IsOSX() then

	MapMessage = "Cinema is currently unsupported on Mac OS X, sorry :("

	hook.Add( "HUDPaint", "DrawMapMessage", function()
		
		surface.SetFont( MapFont )

		w, h = surface.GetTextSize( MapMessage )
		draw.RoundedBox( 4, (ScrW()/2) - w/2 - p, h - p, w + p*2, h + p*2, Color(0,0,0,200) )
		draw.SimpleText( MapMessage, MapFont, ScrW() / 2, h, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

	end )

else
	-- lua refresh fix
	hook.Remove( "HUDPaint", "DrawMapMessage" )
end

/*
	HUD Elements to hide
*/
GM.HUDToHide = {
	"CHudHealth",
	"CHudSuitPower",
	"CHudBattery",
	"CHudCrosshair",
	"CHudAmmo",
	"CHudSecondaryAmmo",
	"CHudZoom"
}

--[[---------------------------------------------------------
   Name: gamemode:HUDShouldDraw( name )
   Desc: return true if we should draw the named element
-----------------------------------------------------------]]
function GM:HUDShouldDraw( name )

	-- Allow the weapon to override this
	local ply = LocalPlayer()
	if ( IsValid( ply ) ) then
	
		local wep = ply:GetActiveWeapon()
		
		if (wep && wep:IsValid() && wep.HUDShouldDraw != nil) then
		
			return wep.HUDShouldDraw( wep, name )
			
		end
		
	end

	return !table.HasValue(self.HUDToHide, name)

end

--[[---------------------------------------------------------
   Name: gamemode:HUDPaint( )
   Desc: Use this section to paint your HUD
-----------------------------------------------------------]]
function GM:HUDPaint()

	hook.Run( "HUDDrawTargetID" )
	-- hook.Run( "HUDDrawPickupHistory" )
	hook.Run( "DrawDeathNotice", 0.85, 0.04 )

end

--[[---------------------------------------------------------
   Name: gamemode:HUDPaint( )
   Desc: Use this section to paint your HUD
-----------------------------------------------------------]]
function GM:HUDDrawTargetID()
	return false
end

--[[---------------------------------------------------------
   Name: CalcView
   Allows override of the default view
-----------------------------------------------------------]]
function GM:CalcView( ply, origin, angles, fov, znear, zfar )
	
	local Vehicle	= ply:GetVehicle()
	local Weapon	= ply:GetActiveWeapon()
	
	local view = {}
	view.origin 		= origin
	view.angles			= angles
	view.fov 			= fov
	view.znear			= znear
	view.zfar			= zfar
	view.drawviewer		= false

	--
	-- Let the vehicle override the view
	--
	if ( IsValid( Vehicle ) ) then return GAMEMODE:CalcVehicleView( Vehicle, ply, view ) end

	--
	-- Let drive possibly alter the view
	--
	if ( drive.CalcView( ply, view ) ) then return view end
	
	--
	-- Give the player manager a turn at altering the view
	--
	player_manager.RunClass( ply, "CalcView", view )

	-- Give the active weapon a go at changing the viewmodel position
	
	if ( IsValid( Weapon ) ) then
	
		local func = Weapon.GetViewModelPosition
		if ( func ) then
			view.vm_origin,  view.vm_angles = func( Weapon, origin*1, angles*1 ) -- Note: *1 to copy the object so the child function can't edit it.
		end
		
		local func = Weapon.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( Weapon, ply, origin*1, angles*1, fov ) -- Note: *1 to copy the object so the child function can't edit it.
		end
	
	end
	
	return view
	
end

--
-- If return true: 		Will draw the local player
-- If return false: 	Won't draw the local player
-- If return nil:	 	Will carry out default action
--
function GM:ShouldDrawLocalPlayer( ply )

	return player_manager.RunClass( ply, "ShouldDrawLocal" )

end

--[[---------------------------------------------------------
   Name: gamemode:CreateMove( command )
   Desc: Allows the client to change the move commands 
			before it's send to the server
-----------------------------------------------------------]]
function GM:CreateMove( cmd )
	if ( player_manager.RunClass( LocalPlayer(), "CreateMove", cmd ) ) then return true end
end