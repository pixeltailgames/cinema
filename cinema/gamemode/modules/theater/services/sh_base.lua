local SERVICE = {}

SERVICE.Name 		= "Base"
SERVICE.IsTimed 	= true

function SERVICE:GetName()
	return self.Name
end

function SERVICE:GetClass()
	return self.ClassName
end

function SERVICE:Match( url )
	return false
end

function SERVICE:GetURLInfo( url )
	return false
end

function SERVICE:Fetch( url, onReceive, onFailure )

	http.Fetch(
		url,
		function(body, length, headers, code)
			if code == 200 or code == 0 then
				onReceive(body, length, headers, code)
			else
				print("FAILURE: " .. code)
				pcall(onFailure, code)
			end
		end,
		function(...) if onFailure then pcall(onFailure, ...) end end
	)

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )
	onFailure( "GetVideoInfo: No implementation found for Video API." )
end

if CLIENT then
	
	function SERVICE:LoadVideo( Video, panel )

		panel.OnFinishLoading = function() end

		local theaterUrl = GetConVarString( "cinema_url" )

		if Video:Type() == "url" then
			panel:OpenURL( Video:Data() )
		elseif panel:GetURL() != theaterUrl then
			panel:OpenURL( theaterUrl )
		end

		local startTime = CurTime() - Video:StartTime()

		-- Set the volume before playing anything
		local str = string.format(
			"if (window.theater) theater.setVolume(%s)", theater.GetVolume() )
		panel:QueueJavascript( str )

		-- Let the webpage handle loading a video
		str = string.format( "if (window.theater) theater.loadVideo( '%s', '%s', %s );",
			Video:Type(), string.JavascriptSafe(Video:Data()), startTime )

		panel:QueueJavascript( str )

	end

end

theater.RegisterService( "base", SERVICE )