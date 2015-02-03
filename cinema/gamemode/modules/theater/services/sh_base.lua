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

local HttpHeaders = {
	["Cache-Control"] = "no-cache",
	["Connection"] = "keep-alive",

	-- Required for Google API requests; uses browser API key.
	["Referer"] = "http://cinema.pixeltailgames.com/",

	-- Don't use improperly formatted GMod user agent in case anything actually
	-- checks the user agent.
	["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36"
}

function SERVICE:Fetch( url, onReceive, onFailure )

	local request = {
		url			= url,
		method		= "GET",
		headers     = HttpHeaders,

		success = function( code, body, headers )
			code = tonumber( code ) or 0

			if code == 200 or code == 0 then
				onReceive( body, body:len(), headers, code )			
			else
				print( "FAILURE: " .. code )
				pcall( onFailure, code )
			end
		end,

		failed = function( err )
			if isfunction( onFailure ) then
				pcall( onFailure, err )
			end
		end
	}

	HTTP( request )

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )
	onFailure( "GetVideoInfo: No implementation found for Video API." )
end

if CLIENT then
	
	function SERVICE:LoadVideo( Video, panel )

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