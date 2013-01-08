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

theater.RegisterService( "base", SERVICE )