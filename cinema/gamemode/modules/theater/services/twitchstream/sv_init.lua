AddCSLuaFile "shared.lua"
local pcall = pcall
local SERVICE = include "shared.lua"

local THUMB_URL = "https://static-cdn.jtvnw.net/previews-ttv/live_user_%s-1280x720.jpg"

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )
	local info = {}
	info.title = ("Twitch Stream: %s"):format(data)
	info.thumbnail = THUMB_URL:format(data)

	if onSuccess then
		pcall(onSuccess, info)
	end
end

theater.RegisterService( "twitchstream", SERVICE )