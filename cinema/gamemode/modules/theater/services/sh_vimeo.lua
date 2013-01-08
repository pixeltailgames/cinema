local SERVICE = {}

SERVICE.Name 	= "Vimeo"
SERVICE.IsTimed = true

function SERVICE:Match( url )
	return string.match(url.host, "vimeo.com") and string.match(url.path, "^/(%d+)")
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match(url.path, "/(%d+)")

	return info

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		local json = util.JSONToTable(body)

		if !json[1] then
			return onFailure(404)
		end

		local info = {}
		info.title = json[1].title
		info.duration = json[1].duration
		info.thumbnail = json[1].thumbnail_medium

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "http://vimeo.com/api/v2/video/%s.json", data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'vimeo', SERVICE )