local SERVICE = {}

SERVICE.Name 			= "Viooz"
SERVICE.IsTimed 		= true
SERVICE.TheaterType 	= THEATER_PRIVATE

local DataPattern = "^/movies/(%d+)%-.-%.html"
local TitlePattern = "</span><span>(.-)</span></a>"
local DurationPattern = "Duration: <span>(.-) min</span>"
local ThumbnailPattern = '<img height="%d-" width="%d-" title=".-" alt=".-" src="(.-)" />'

function SERVICE:Match( url )
	PrintTable(url)
	print("Viooz Match:")
	print(string.match( url.path, DataPattern ))
	return string.match( url.host, "viooz.co" ) and
		string.match( url.path, DataPattern )
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match( url.path, DataPattern )

	return info.Data and info or false

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		local info = {}
		info.title = string.match( body, TitlePattern ) or "(Unknown)"
		info.duration = string.match( body, DurationPattern )
		info.thumbnail = string.match( body, ThumbnailPattern )

		info.duration = tonumber(info.duration) * 60 -- minutes to seconds

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "http://viooz.co/movies/%s-.html", data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'viooz', SERVICE )