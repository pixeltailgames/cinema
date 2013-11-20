/*---------------------------------------------------------------------------
	Name: PreVideoLoad
	Desc: Called prior to a video loading. Return true in a hook
		to prevent the default behavior for loading videos. This is 
		useful if you want to implement custom player actions for
		a new video type.
---------------------------------------------------------------------------*/
function GM:PreVideoLoad( Video )

end


/*---------------------------------------------------------------------------
	Name: PostVideoLoad
	Desc: Called after a video has loaded.
---------------------------------------------------------------------------*/
function GM:PostVideoLoad( Video )

	local startTime = CurTime() - Video:StartTime()

	-- Output debug information
	Msg("Loaded Video\n")
	Msg("\tTitle:\t\t"..tostring(Video:Title()).."\n")
	Msg("\tType:\t\t"..tostring(Video:Type()).."\n")
	Msg("\tData:\t\t"..tostring(Video:Data()).."\n")
	Msg("\tTime:\t\t"..tostring(startTime).."\n")
	Msg("\tDuration:\t"..tostring(Video:Duration()).."\n")
	Msg( string.format("\tRequested by %s (%s)", Video:GetOwnerName(),
		Video:GetOwnerSteamID() ) .."\n" )

	-- Keep previous video for refreshing the theater
	theater.LastVideo = Video

end