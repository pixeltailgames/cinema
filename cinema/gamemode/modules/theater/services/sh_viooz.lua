local SERVICE = {}

SERVICE.Name 			= "Viooz"
SERVICE.IsTimed 		= true
SERVICE.TheaterType 	= THEATER_PRIVATE

local UrlPattern = "http://viooz.co/movies/%s-.html"
local DataPattern = "^/movies/(%d+)%-.-%.html"
local TitlePattern = "</span><span>(.-)</span></a>"
local DurationPattern = "Duration: <span>(.-) min</span>"
local ThumbnailPattern = '<img height="%d-" width="%d-" title=".-" alt=".-" src="(.-)" />'

function SERVICE:Match( url )
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

	local url = string.format( UrlPattern, data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'viooz', SERVICE )

if CLIENT then

	--[[
		Viooz hooks
		Overrides default player behavior
	]]

	local JS_AddTheaterScript = [[
var script = document.createElement('script');
script.src = 'http://localhost/cinema/js/theater.js';
document.body.appendChild(script);
]]

	local JS_OnTheaterReady = [[
function onTheaterReady() {
	theater.setVolume(%s);
	theater.loadVideo('%s','%s','%s');
}
]]

	hook.Add( "PreVideoLoad", "PreVioozLoad", function( Video )

		-- Video must be Viooz
		if Video:Type() ~= "viooz" then
			return true
		end

		local VioozUrl = string.format( UrlPattern, Video:Data() )

		local panel = theater.ActivePanel()
		panel:Stop()
		panel:OpenURL( VioozUrl )

		local startTime = CurTime() - Video:StartTime()

		-- TODO
		panel.OnFinishLoading = function(self)

			local str = string.format( JS_OnTheaterReady,
				theater.GetVolume(), Video:Type(),
				string.JavascriptSafe(Video:Data()), startTime )
			self:RunJavascript(str)

			self:RunJavascript(JS_AddTheaterScript)
		end

		hook.Run( "PostVideoLoad", Video )

		return false

	end )

end