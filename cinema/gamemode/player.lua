--[[---------------------------------------------------------
   Name: gamemode:PlayerCanPickupWeapon( )
   Desc: Called when a player tries to pickup a weapon.
		  return true to allow the pickup.
-----------------------------------------------------------]]
function GM:PlayerCanPickupWeapon( player, entity )
	return true
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanPickupItem( )
   Desc: Called when a player tries to pickup an item.
		  return true to allow the pickup.
-----------------------------------------------------------]]
function GM:PlayerCanPickupItem( player, entity )
	return true
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerDisconnected( )
   Desc: Player has disconnected from the server.
-----------------------------------------------------------]]
function GM:PlayerDisconnected( player )
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSay( )
   Desc: A player (or server) has used say. Return a string
		 for the player to say. Return an empty string if the
		 player should say nothing.
-----------------------------------------------------------]]
function GM:PlayerSay( player, text, teamonly )
	return text
end


--[[---------------------------------------------------------
   Name: gamemode:PlayerDeathThink( player )
   Desc: Called when the player is waiting to respawn
-----------------------------------------------------------]]
function GM:PlayerDeathThink( pl )

	if (  pl.NextSpawnTime && pl.NextSpawnTime > CurTime() ) then return end

	if ( pl:KeyPressed( IN_ATTACK ) || pl:KeyPressed( IN_ATTACK2 ) || pl:KeyPressed( IN_JUMP ) ) then
	
		pl:Spawn()
		
	end
	
end

--[[---------------------------------------------------------
	Name: gamemode:PlayerUse( player, entity )
	Desc: A player has attempted to use a specific entity
		Return true if the player can use it
------------------------------------------------------------]]
function GM:PlayerUse( pl, entity )
	return true
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerInitialSpawn( )
   Desc: Called just before the player's first spawn
-----------------------------------------------------------]]
function GM:PlayerInitialSpawn( pl )

	pl:SetTeam( TEAM_UNASSIGNED )
	
	if ( GAMEMODE.TeamBased ) then
		pl:ConCommand( "gm_showteam" )
	end

end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSpawn( )
   Desc: Called when a player spawns
-----------------------------------------------------------]]
function GM:PlayerSpawn( pl )

	--
	-- If the player doesn't have a team in a TeamBased game
	-- then spawn him as a spectator
	--
	if ( GAMEMODE.TeamBased && ( pl:Team() == TEAM_SPECTATOR || pl:Team() == TEAM_UNASSIGNED ) ) then

		GAMEMODE:PlayerSpawnAsSpectator( pl )
		return
	
	end

	-- Stop observer mode
	pl:UnSpectate()

	player_manager.SetPlayerClass( pl, "player_lobby" )
	player_manager.OnPlayerSpawn( pl )
	player_manager.RunClass( pl, "Spawn" )

	-- Call item loadout function
	hook.Call( "PlayerLoadout", GAMEMODE, pl )
	
	-- Set player model
	hook.Call( "PlayerSetModel", GAMEMODE, pl )
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSetModel( )
   Desc: Set the player's model
-----------------------------------------------------------]]
function GM:PlayerSetModel( pl )

	local cl_playermodel = pl:GetInfo( "cl_playermodel" )
	local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
	util.PrecacheModel( modelname )
	pl:SetModel( modelname )
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerLoadout( )
   Desc: Give the player the default spawning weapons/ammo
-----------------------------------------------------------]]
function GM:PlayerLoadout( pl )

	player_manager.RunClass( pl, "Loadout" )
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerDeathSound()
   Desc: Return true to not play the default sounds
-----------------------------------------------------------]]
function GM:PlayerDeathSound()
	return false
end

--[[---------------------------------------------------------
   Name: gamemode:CanPlayerSuicide( ply )
   Desc: Player typed KILL in the console. Can they kill themselves?
-----------------------------------------------------------]]
function GM:CanPlayerSuicide( ply )
	return true
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSwitchFlashlight()
		Return true to allow action
-----------------------------------------------------------]]
function GM:PlayerSwitchFlashlight( ply, SwitchOn )
	return ply:CanUseFlashlight()
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerSpray()
		Return true to prevent player spraying
-----------------------------------------------------------]]
function GM:PlayerSpray( ply )
	
	return false
	
end

--[[---------------------------------------------------------
   Name: gamemode:GetFallDamage()
		return amount of damage to do due to fall
-----------------------------------------------------------]]
function GM:GetFallDamage( ply, flFallSpeed )

	return 0
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanSeePlayersChat()
		Can this player see the other player's chat?
-----------------------------------------------------------]]
function GM:PlayerCanSeePlayersChat( strText, bTeamOnly, pListener, pSpeaker )
	
	-- Local chat functions as global chat in Cinema
	if bTeamOnly then
		return true
	end
	
	-- Players should only receive chat messages from users in the same 
	-- theater if it wasn't global.
	return pSpeaker:GetTheater() == pListener:GetTheater()
	
end

local sv_alltalk = GetConVar( "sv_alltalk" )

--[[---------------------------------------------------------
   Name: gamemode:PlayerCanHearPlayersVoice()
		Can this player see the other player's voice?
		Returns 2 bools. 
		1. Can the player hear the other player
		2. Can they hear them spacially
-----------------------------------------------------------]]
function GM:PlayerCanHearPlayersVoice( pListener, pTalker )
	
	local alltalk = sv_alltalk:GetInt()
	if ( alltalk > 1 ) then return true, alltalk == 2 end

	return pListener:Team() == pTalker:Team(), false
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerShouldTaunt( ply, actid )
-----------------------------------------------------------]]
function GM:PlayerShouldTaunt( ply, actid )
	
	-- The default behaviour is to always let them act
	-- Some gamemodes will obviously want to stop this for certain players by returning false
	return true
		
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerStartTaunt( ply, actid, length )
-----------------------------------------------------------]]
function GM:PlayerStartTaunt( ply, actid, length )
		
end


--[[---------------------------------------------------------
   Name: gamemode:AllowPlayerPickup( ply, object )
-----------------------------------------------------------]]
function GM:AllowPlayerPickup( ply, object )
	
	-- Should the player be allowed to pick this object up (using ENTER)?
	-- If no then return false. Default is HELL YEAH

	return true
		
end
