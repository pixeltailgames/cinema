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
	Name: PlayerChangeTheater
	Desc: Called when the player changes location. Determines if the
		player has entered or exited a theater.
---------------------------------------------------------------------------*/
local function PlayerChangeTheater( ply, loc, old )

	local Theater = theater.GetByLocation( loc )
	local OldTheater = theater.GetByLocation( old )
	
	-- Player left theater
	if OldTheater then

		theater.PlayerLeave( ply, old )

		if !Theater then
			ply:SetInTheater(false)
		end
		
		hook.Run( "OnPlayerExitTheater", ply, Theater )

	end

	-- Player entered theater
	if Theater then

		theater.PlayerJoin( ply, loc )
		ply:SetInTheater(true)

		hook.Run( "OnPlayerEnterTheater", ply, Theater )

	end

end
hook.Add( "PlayerChangeLocation", "TheaterInit", PlayerChangeTheater )