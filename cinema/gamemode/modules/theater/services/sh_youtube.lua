--[[
Credits to veitikka (https://github.com/veitikka) for fixing YouTube service and writing the
Workaround with a Metadata parser.
--]]

local SERVICE = {}

SERVICE.Name 	= "YouTube"
SERVICE.IsTimed = true

local METADATA_URL = "https://www.youtube.com/watch?v=%s"

function SERVICE:Match( url )
	return string.match( url.host, "youtu.?be[.com]?" )
end

---
-- Helper function for converting ISO 8601 time strings; this is the formatting
-- used for duration specified in the YouTube v3 API.
--
-- http://stackoverflow.com/a/22149575/1490006
--
local function convertISO8601Time( duration )
	local a = {}

	for part in string.gmatch(duration, "%d+") do
	   table.insert(a, part)
	end

	if duration:find('M') and not (duration:find('H') or duration:find('S')) then
		a = {0, a[1], 0}
	end

	if duration:find('H') and not duration:find('M') then
		a = {a[1], 0, a[2]}
	end

	if duration:find('H') and not (duration:find('M') or duration:find('S')) then
		a = {a[1], 0, 0}
	end

	duration = 0

	if #a == 3 then
		duration = duration + tonumber(a[1]) * 3600
		duration = duration + tonumber(a[2]) * 60
		duration = duration + tonumber(a[3])
	end

	if #a == 2 then
		duration = duration + tonumber(a[1]) * 60
		duration = duration + tonumber(a[2])
	end

	if #a == 1 then
		duration = duration + tonumber(a[1])
	end

	return duration
end

---
-- Get the value for an attribute from a html element
--
local function ParseElementAttribute( element, attribute )
	if not element then return end
	-- Find the desired attribute
	local output = string.match( element, attribute.."%s-=%s-%b\"\"" )
	if not output then return end
	-- Remove the 'attribute=' part
	output = string.gsub( output, attribute.."%s-=%s-", "" )
	-- Trim the quotes around the value string
	return string.sub( output, 2, -2 )
end

---
-- Get the contents of a html element by removing tags
-- Used as fallback for when title cannot be found
--
local function ParseElementContent( element )
	if not element then return end
	-- Trim start
	local output = string.gsub( element, "^%s-<%w->%s-", "" )
	-- Trim end
	return string.gsub( output, "%s-</%w->%s-$", "" )
end

-- Lua search patterns to find metadata from the html
local patterns = {
	["title"] = "<meta%sproperty=\"og:title\"%s-content=%b\"\">",
	["title_fallback"] = "<title>.-</title>",
	["thumb"] = "<meta%sproperty=\"og:image\"%s-content=%b\"\">",
	["thumb_fallback"] = "<link%sitemprop=\"thumbnailUrl\"%s-href=%b\"\">",
	["duration"] = "<meta%sitemprop%s-=%s-\"duration\"%s-content%s-=%s-%b\"\">",
	["live"] = "<meta%sitemprop%s-=%s-\"isLiveBroadcast\"%s-content%s-=%s-%b\"\">",
	["live_enddate"] = "<meta%sitemprop%s-=%s-\"endDate\"%s-content%s-=%s-%b\"\">"
}

function SERVICE:GetURLInfo( url )

	local info = {}

	-- http://www.youtube.com/watch?v=(videoId)
	if url.query and url.query.v and string.len(url.query.v) > 0 then
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

---
-- Function to parse video metadata straight from the html instead of using the API
--
function SERVICE:ParseYTMetaDataFromHTML( html )
	--MetaData table to return when we're done
	local metadata = {}

	-- Fetch title and thumbnail, with fallbacks if needed
	metadata.title = ParseElementAttribute(string.match(html, patterns["title"]), "content")
		or ParseElementContent(string.match(html, patterns["title_fallback"]))

	-- Parse HTML entities in the title into symbols
	metadata.title = url.htmlentities_decode(metadata.title)

	metadata.thumbnail = ParseElementAttribute(string.match(html, patterns["thumb"]), "content")
		or ParseElementAttribute(string.match(html, patterns["thumb_fallback"]), "href")

	-- See if the video is an ongoing live broadcast
	-- Set duration to 0 if it is, otherwise use the actual duration
	local isLiveBroadcast = tobool(ParseElementAttribute(string.match(html, patterns["live"]), "content"))
	local broadcastEndDate = string.match(html, patterns["live_enddate"])
	if isLiveBroadcast and not broadcastEndDate then
		-- Mark as live video
		metadata.duration = 0
	else
		local durationISO8601 = ParseElementAttribute(string.match(html, patterns["duration"]), "content")
		if isstring(durationISO8601) then
			metadata.duration = math.max(1, convertISO8601Time(durationISO8601))
		end
	end

	return metadata
end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local onReceive = function( body, length, headers, code )
		local status, metadata = pcall(self.ParseYTMetaDataFromHTML, self, body)
		if not status  then
			return onFailure( 'Theater_RequestFailed' )
		end

		local info = {}
		info.title = metadata["title"]
		info.thumbnail = metadata["thumbnail"]

		local isLive = metadata["duration"] == 0

		if isLive then
			info.type = 'youtubelive'
			info.duration = 0
		else
			info.duration = metadata["duration"]
		end

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = METADATA_URL:format( data )
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
