local SERVICE = include "shared.lua"

local TWITCH_URL = "https://player.twitch.tv/?channel=%s&parent=pixeltailgames.com"
local THEATER_JS = [[
	function testSelector(elem, dataStr) {
		var data = document.querySelectorAll( elem + "[data-test-selector]")
		for (let i=0; i<data.length; i++) {
			var selector = data[i].dataset.testSelector
			if (!!selector && selector === dataStr) {
				return data[i]
				break
			}
		}
	}

	function target(dataStr) {
		var data = document.querySelectorAll( "button[data-a-target]")
		for (let i=0; i<data.length; i++) {
			var selector = data[i].dataset.aTarget
			if (!!selector && selector === dataStr) {
				return data[i]
				break
			}
		}
	}

	function build(player) {
		window.player = player;

		if (!window.theater) {
			class CinemaPlayer {

				get player() {
					return window.player;
				}

				setVolume(volume) {
					if (!!this.player) {
						this.player.volume = volume / 100;
					}
				}

				enableHD(on) { }
			};
			window.theater = new CinemaPlayer();
		}
	}

	function check() {
		var mature = target("player-overlay-mature-accept")
		if (!!mature) {mature.click(); return;}

		var player = document.getElementsByTagName('video')[0];
		if (!testSelector("div", "sad-overlay") && !!player && player.paused == false && player.readyState == 4) {
			build(player);
			clearInterval(intervalId);
		}
	}
	var intervalId = setInterval(check, 150);
]]

function SERVICE:LoadVideo( Video, panel )
	panel:Stop()
	panel:OpenURL( TWITCH_URL:format( Video:Data() ) )

	panel.OnFinishLoading = function(pnl)
		pnl:RunJavascript(THEATER_JS)
	end
end
theater.RegisterService( "twitchstream", SERVICE )