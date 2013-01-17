/*---------------------------------------------------------------------------
	Name: PreVideoQueued
	Desc: Called prior to a video being queued. Return false in a hook
		to prevent the requested video from being queued. If you'd like
		to filter videos, do so with this hook.
---------------------------------------------------------------------------*/
function GM:PreVideoQueued( Video, Theater )

	local ply = Video:GetOwner()

	-- This shouldn't happen, but we'll check just in case
	if !IsValid(ply) then return false end

	-- Disregard filtering admin requests
	if ply:IsAdmin() then return true end

	-- Public theaters should be slightly more managed
	if Theater:IsReplicated() then
		
		-- Limit videos to a specified maximum duration
		local MaxDuration = GetConVarNumber("cinema_video_duration_max")
		if Video:Duration() > MaxDuration then

			local msg = string.format( "Public theater requests are limited to %s second(s) in length.", MaxDuration )
			Theater:AnnounceToPlayer( ply, msg )

			return false

		end

	end


	return true

end


/*---------------------------------------------------------------------------
	Name: PrePlayerEnterTheater
	Desc: Called right before the player has joined the theater. Returning
		false here will prevent the player from being added to the theater.
		If you're going to be implementing VIP, use this hook and move the
		player elsewhere.
---------------------------------------------------------------------------*/
function GM:PrePlayerEnterTheater( ply, Theater )

/*
	Example VIP Implementation:

	if Theater:IsPrivileged() and !ply:IsVIP() then

		-- Respawn the player
		ply:Spawn()

		-- Prevent the player from being added to the theater
		-- and being sent videos, etc.
		return false

	end
*/

	return true

end


/*---------------------------------------------------------------------------
	Name: PostPlayerEnterTheater
	Desc: Called after the playing has entered a theater.
---------------------------------------------------------------------------*/
function GM:PostPlayerEnterTheater( ply, Theater )
	
end


/*---------------------------------------------------------------------------
	Name: PrePlayerExitTheater
	Desc: Called before the player leaves a theater.
---------------------------------------------------------------------------*/
function GM:PrePlayerExitTheater( ply, Theater )

end


/*---------------------------------------------------------------------------
	Name: PostPlayerExitTheater
	Desc: Called after the player leaves a theater.
---------------------------------------------------------------------------*/
function GM:PostPlayerExitTheater( ply, Theater )

end


/*---------------------------------------------------------------------------
	Name: PlayerChangeTheater
	Desc: Called when the player changes location. Determines if the
		player has entered or exited a theater.
---------------------------------------------------------------------------*/
local function PlayerChangeTheater( ply, loc, old )

	local Theater = theater.GetByLocation( loc )
	local OldTheater = theater.GetByLocation( old )
	local AllowedInTheater

	-- Do this first to preserve leaving/entering order
	if Theater then
		AllowedInTheater = hook.Run( "PrePlayerEnterTheater", ply, Theater )
	end

	-- Player left theater
	if OldTheater then

		hook.Run( "PrePlayerExitTheater", ply, Theater )

		theater.PlayerLeave( ply, old )

		if !Theater or !AllowedInTheater then
			ply:SetInTheater(false)
		end
		
		hook.Run( "PostPlayerExitTheater", ply, Theater )

	end

	-- Player entered theater
	if Theater and AllowedInTheater then

		theater.PlayerJoin( ply, loc )
		ply:SetInTheater(true)

		hook.Run( "PostPlayerEnterTheater", ply, Theater )

	end

end
hook.Add( "PlayerChangeLocation", "TheaterInit", PlayerChangeTheater )