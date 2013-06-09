local SERVICE = {}

SERVICE.Name 	= "YouTube"
SERVICE.IsTimed = true

function SERVICE:Match( url )
	return string.match( url.host, "youtu.?be[.com]?" )
end

function SERVICE:GetURLInfo( url )

	local info = {}

	-- http://www.youtube.com/watch?v=(videoId)
	if url.query and url.query.v then
		info.Data = url.query.v

	-- http://www.youtube.com/v/(videoId)
	elseif url.path and string.match(url.path, "^/v/([%a%d-_]+)") then
		info.Data = string.match(url.path, "^/v/([%a%d-_]+)")

	-- http://youtu.be/(videoId)
	elseif string.match(url.host, "youtu.be") and 
		url.path and string.match(url.path, "^/([%a%d-_]+)$") and
		( !info.query or #info.query == 0 ) then -- short url
		info.Data = string.match(url.path, "^/([%a%d-_]+)$")
	end

	-- Start time, #t=123s or ?t=123s
	if (url.fragment and url.fragment.t) or (url.query and url.query.t) then

		local time = (url.fragment and url.fragment.t) and url.fragment.t or url.query.t

		local seconds = tonumber(string.match(time, "(%d+)s"))
		local minutes = tonumber(string.match(time, "(%d+)m"))
		local hours = tonumber(string.match(time, "(%d+)h"))

		if seconds then
			time = seconds
		end

		if minutes then
			time = tonumber(time) and time or 0
			time = time + (minutes * 60)
		end
		
		if hours then
			time = tonumber(time) and time or 0
			time = time + (hours * 60 * 60)
		end

		if time then
			info.StartTime = time
		end

	end

	if info.Data then
		return info
	else
		return false
	end

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		if string.match( body, "noembed" ) then
			return onFailure( "The requested video is embed disabled." )
		elseif string.match( body, "paidContent" ) then
			return onFailure( "The requested video is purchasable content and can't be played." )
		end

		local info = {}
		info.title = string.match( body, "<title type='text'>([^\n]+)</title>" )
		info.duration = string.match( body, "duration seconds='(%d+)'" )
		info.thumbnail = string.match( body, "thumbnail url='(.+)0.jpg'" )

		if info.thumbnail then
			info.thumbnail = info.thumbnail .. "0.jpg"
		end

		if string.match( body, "<yt:state name='processing'/>" ) then
			info.type = 'youtubelive'
		end

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "http://gdata.youtube.com/feeds/api/videos/%s", data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'youtube', SERVICE )


local SERVICE = {}

SERVICE.Name 		= "YouTube Live"
SERVICE.IsTimed 	= false
SERVICE.TheaterType = THEATER_PRIVATE

-- Implementation is found in 'youtube' service.
-- GetVideoInfo switches to 'youtubelive'

theater.RegisterService( 'youtubelive', SERVICE )