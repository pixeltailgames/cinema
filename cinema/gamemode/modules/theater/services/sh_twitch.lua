local API_KEY = "aij4xm67u1f3fxtrr8b5nqr78enrwv"

local THEATER_JS = [[(function() {
'use strict';
		
class CinemaTwitchPlayer {
	constructor() {
		this.intervalId = setInterval(this.forcePlay.bind(this), 5000);
	}
	
	get player() {
		return window.player;
	}

	get matureBtn() {
		return this._matureBtn ||
			(this._matureBtn = document.querySelector('#mature-link'));
	}

	// Fix for Twitch stream not starting
	forcePlay() {
		if (!this.player) {
			return;
		} else if (this.player.isPlaying()) {
			clearInterval(this.intervalId);
			this.intervalId = undefined;
		} else {
			if (!this.clickedMatureBtn && this.matureBtn) {
				this.matureBtn.click();
				this.clickedMatureBtn = true;
				this._matureBtn = undefined;
			} else {
				this.player.pause();
				this.player.play();
			}
		}
	}
	
	setVolume(volume) {
		if (this.player) {
			this.player.setVolume(volume / 100);
		}
	}

	enableHD(on) {}
	sync(seconds) {}
};

window.theater = new CinemaTwitchPlayer();
}());]]

local SERVICE = {}

SERVICE.Name 		= "Twitch.TV"
SERVICE.IsTimed 	= true

function SERVICE:Match( url )
	return string.match(url.host, "twitch.tv") and
		string.match(url.path, "^/videos/(%d+)")
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match(url.path, "^/videos/(%d+)")

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

		info.data = data

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	local url = string.format( "https://api.twitch.tv/kraken/videos/%s?client_id=%s", data, API_KEY )
	self:Fetch( url, onReceive, onFailure )

end

if CLIENT then

	local TWITCH_URL = "https://player.twitch.tv/?video=v%s&time=%ss"

	function SERVICE:LoadVideo( Video, panel )

		local startTime = math.ceil(math.max(CurTime() - Video:StartTime(), 0))
		local url = TWITCH_URL:format( Video:Data(), startTime )

		local panel = theater.ActivePanel()
		panel:Stop()
		panel:OpenURL( url )

		panel.OnFinishLoading = function(self)
			panel:RunJavascript(THEATER_JS)
		end

	end

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

	local url = string.format( "https://api.twitch.tv/kraken/streams/%s?client_id=%s", data, API_KEY )
	self:Fetch( url, onReceive, onFailure )

end

if CLIENT then

	local TWITCH_URL = "https://player.twitch.tv/?channel=%s"

	function SERVICE:LoadVideo( Video, panel )

		local url = TWITCH_URL:format( Video:Data() )

		local panel = theater.ActivePanel()
		panel:Stop()
		panel:OpenURL( url )

		panel.OnFinishLoading = function(self)
			panel:RunJavascript(THEATER_JS)
		end

	end

end

theater.RegisterService( 'twitchstream', SERVICE )
