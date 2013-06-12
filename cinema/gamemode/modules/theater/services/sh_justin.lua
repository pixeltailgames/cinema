local SERVICE = {}

SERVICE.Name 			= "Justin.TV Stream"
SERVICE.IsTimed 		= false
SERVICE.TheaterType 	= THEATER_PRIVATE

function SERVICE:Match( url )
	return string.match( url.host, "justin.tv" )
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match( url.path, "/([%w_]+)$" )

	if !info.Data or string.len(info.Data) < 1 then
		return false
	end

	return info

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		-- Remove [] chars
		body = string.sub( body, 2, length - 1 )

		-- Stream offline
		if body == "" then
			return onFailure( 'Service_StreamOffline' )
		end

		local response = util.JSONToTable(body)

		response = response.channel

		local info = {}
		info.thumbnail = response.screen_cap_url_large
		info.title = response.title

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "http://api.justin.tv/api/stream/list.json?channel=%s", data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'justinstream', SERVICE )