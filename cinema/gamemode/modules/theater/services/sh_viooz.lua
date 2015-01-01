local SERVICE = {}

SERVICE.Name 	= "Viooz"
SERVICE.IsTimed = true

local UrlPattern = "http://viooz.ac/movies/%s.html"
local DataPattern = "^/movies/(.-).html"
local TitlePattern = "</span><span>(.-)</span></a>"
local DurationPattern = "Duration: <span>(.-) min</span>"
local ThumbnailPattern = '<img height="%d-" width="%d-" title=".-" alt=".-" src="(.-)" />'

function SERVICE:Match( url )
	return string.match( url.host, "viooz%.%a+" ) and
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

		info.duration = tonumber(info.duration)

		-- Viooz might be returning a Cloudflare page
		if not info.duration then
			return pcall(onFailure, 404)
		end

		info.duration = info.duration * 60 -- minutes to seconds

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( UrlPattern, data )
	self:Fetch( url, onReceive, onFailure )

end

theater.RegisterService( 'viooz', SERVICE )

if CLIENT then

	local JS_AddTheaterScript = [[
var script = document.createElement('script');
script.src = '%s';
document.body.appendChild(script);
]]

	local JS_OnTheaterReady = [[
function onTheaterReady() {
	theater.setVolume(%s);
	theater.loadVideo('%s','%s','%s');
}
]]

	function SERVICE:LoadVideo( Video, panel )

		local theaterJsUrl = string.format( "%s/js/theater.min.js",
			GetConVarString("cinema_url") or
			"http://pixeltailgames.github.io/cinema/" )

		local VioozUrl = string.format( UrlPattern, Video:Data() )

		local panel = theater.ActivePanel()
		panel:Stop()
		panel:OpenURL( VioozUrl )

		local startTime = CurTime() - Video:StartTime()

		panel.OnFinishLoading = function(self)
			-- Begin loading video after loading theater.js
			local str = string.format( JS_OnTheaterReady,
				theater.GetVolume(), Video:Type(),
				string.JavascriptSafe(Video:Data()), startTime )
			self:RunJavascript(str)

			-- Inject theater.js
			str = string.format( JS_AddTheaterScript, 
				string.JavascriptSafe(theaterJsUrl) ) 
			self:RunJavascript(str)
		end

	end

end