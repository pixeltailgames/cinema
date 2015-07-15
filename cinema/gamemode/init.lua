AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'player_shd.lua' )
AddCSLuaFile( 'sh_load.lua' )
AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'translations.lua' )

include( 'shared.lua' )
include( 'player.lua' )

resource.AddWorkshop( "118824086" ) -- cinema gamemode
resource.AddWorkshop( "119060917" ) -- cinema_theatron

timer.Create( "TheaterPlayerThink", 1, 0, function()
	for _, v in pairs( player.GetAll() ) do
		if ( !IsValid( v ) ) then continue end
		
		hook.Call( "PlayerThink", GAMEMODE, v )
	end
end )

--[[---------------------------------------------------------
   Name: gamemode:DoPlayerDeath( )
   Desc: Carries out actions when the player dies 		 
-----------------------------------------------------------]]
function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:CreateRagdoll()
	
	ply:AddDeaths( 1 )
	
	if ( attacker:IsValid() && attacker:IsPlayer() ) then
	
		if ( attacker == ply ) then
			attacker:AddFrags( -1 )
		else
			attacker:AddFrags( 1 )
		end
		
	end
	
end


-- Set the ServerName every 30 seconds in case it changes..
-- This is for backwards compatibility only - client can now use GetHostName()
local function HostnameThink()

	SetGlobalString( "ServerName", GetHostName() )

end

timer.Create( "HostnameThink", 30, 0, HostnameThink )

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanHearPlayersVoice( )
   Desc: Decides whether the 	 
-----------------------------------------------------------]]
function GM:PlayerCanHearPlayersVoice( listener, talker )

	-- Check for theater module first
	if !theater then
		return true
	end

	local Voice3D = GetConVar("cinema_allow_3dvoice"):GetBool()
	local ListenerInTheater = listener:InTheater()
	local TalkerInTheater = talker:InTheater()

	-- Both players in theater
	if ListenerInTheater and TalkerInTheater then
		return listener:GetLocation() == talker:GetLocation() and 
			GetConVar("cinema_allow_voice"):GetBool(), Voice3D

	-- One player in theater
	elseif (ListenerInTheater and !TalkerInTheater) ||
		(!ListenerInTheater and TalkerInTheater) then
		return false, Voice3D

	-- Both players in non-theater areas (Lobby)
	else

		return true, Voice3D

	end

end

function GM:PlayerSwitchFlashlight( ply, enable )

	-- Admins are immune to flashlight restrictions
	if ply:IsAdmin() then
		return true
	end

	-- Only allow disabling the flashlight in theaters
	if ply.InTheater and ply:InTheater() then
		return !enable
	end

	if ply.NextFlashlightSwitch and ply.NextFlashlightSwitch > CurTime() then
		return false
	else
		ply.NextFlashlightSwitch = CurTime() + 1
	end

	return true

end