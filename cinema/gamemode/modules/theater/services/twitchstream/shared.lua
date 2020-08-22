local SERVICE = {}

SERVICE.Name = "Twitch.TV Stream"
SERVICE.IsTimed 	= false
SERVICE.TheaterType = THEATER_PRIVATE

local Ignored = {
	["video"] = true,
	["directory"] = true,
	["downloads"] = true,
}

function SERVICE:Match( url )
	return url.host and url.host:match("twitch.tv")
end

function SERVICE:GetURLInfo( url )
	if url.path then
		local data = url.path:match("/([%w_]+)")
		if (data and not Ignored[data]) then return { Data = data } end
	end

	return false
end

return SERVICE