local SERVICE = {}

SERVICE.Name 		= "Blip"
SERVICE.IsTimed 	= true

function SERVICE:Match( url )
	return string.match( url.host, "blip.tv" ) and
		string.match( url.path, "^/[%w_-]+/[%w_-]+-%d+$" )
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = url.encoded

	return info

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		body = string.sub(body,18,length-4) -- fix json response

		local response = util.JSONToTable(body)

		if !response.Post then
			return pcall(onFailure, 404)
		end

		local info = {}
		info.title = response.Post.title
		info.duration = response.Post.media.duration
		info.data = response.Post.postsId
		info.thumbnail = response.Post.thumbnailUrl

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = data .. "?skin=json"
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'blip', SERVICE )