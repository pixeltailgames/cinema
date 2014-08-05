local SERVICE = {}

SERVICE.Name 		= "Twitch.TV"
SERVICE.IsTimed 	= true

function SERVICE:Match( url )
	return string.match(url.host, "twitch.tv") and
		string.match(url.path, "^/[%w_]+/%a/(%d+)")
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match(url.path, "^/[%w_]+/%a/(%d+)")

	-- Chapter videos use /c/ while archived videos use /b/
	local letter = string.match(url.path, "^/[%w_]+/(%a)/%d+")
	if letter == "c" then
		info.Data = "c" .. info.Data
	else
		info.Data = "b" .. info.Data
	end

	-- Start time
	if url.query and url.query.t then
		local time = tonumber(url.query.t)
		if time then
			info.StartTime = time
		end
	end

	return info

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )

		local response = util.JSONToTable( body )

		-- Stream invalid
		if response.status and response.status == 404 then
			return onFailure("Twitch.TV : " .. tostring(response.message))
		end

		local info = {}
		info.title = response.title
		info.duration = response.length
		info.thumbnail = response.preview

		-- Add 30 seconds to accomodate for ads in video over 5 minutes
		local duration = tonumber(info.duration)
		if duration and duration > ( 60 * 5 ) then
			info.duration = duration + 30
		end

		-- Extract channel name
		local channel = ""
		local PageUrl = url.parse(response.url)
		if PageUrl and PageUrl.path then
			local path = string.Explode("/", PageUrl.path)
			channel = path[2]
		else
			return pcall(onFailure, 404)
		end

		info.data = channel .. "," .. data

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	-- API call fix
	local id = data
	if string.StartWith( id, 'b' ) then
		id = 'a' .. string.sub( id, 2, string.len(id) )
	end

	local url = string.format( "https://api.twitch.tv/kraken/videos/%s", id )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'twitch', SERVICE )


local SERVICE = {}

SERVICE.Name 			= "Twitch.TV Stream"
SERVICE.IsTimed 		= false
SERVICE.TheaterType 	= THEATER_PRIVATE

function SERVICE:Match( url )
	return string.match( url.host, "twitch.tv" )
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

		local response = util.JSONToTable(body)

		-- Stream invalid
		if response.status and response.status == 404 then
			return onFailure("Twitch.TV : " .. tostring(response.message))
		end

		-- Stream is offline
		if !response.stream then
			return onFailure("The requested stream is offline")
		end

		response = response.stream

		local info = {}
		info.thumbnail = response.preview.medium

		-- Setup title according to the available data
		if response.channel and response.channel.status then
			info.title = string.format("%s - %s", response.channel.status, response.channel.name)
		elseif response.game then
			info.title = "Twitch.TV : " .. response.game
		else
			info.title = "Twitch.TV Stream"
		end

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "https://api.twitch.tv/kraken/streams/%s", data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'twitchstream', SERVICE )
