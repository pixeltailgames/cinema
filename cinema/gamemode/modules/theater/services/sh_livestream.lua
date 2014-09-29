local SERVICE = {}

SERVICE.Name   		= "Livestream"
SERVICE.IsTimed 		= false
SERVICE.TheaterType 	= THEATER_PRIVATE

function SERVICE:Match( url )
	return string.match( url.host, "www.livestream.com" ) or
			string.match( url.host, "mogulus.com" )
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = string.match( url.path, "^/([%w_-]+)$" )
	
	if !info.Data or string.len(info.Data) < 1 then
		return false
	end

	return info

end

function SERVICE:GetVideoInfo(data, onSuccess, onFailure)
	
	local onReceive = function( body, length, headers, code )
		
		local response = util.JSONToTable(body)
		
		if length == 0 then
            return onFailure(404)
        end
		
		response = response.channel
		
		if response.isLive == false then
			return onFailure('Service_StreamOffline')
		end
		
		local info = {}
		info.thumbnail = response.image.url
		
		-- Setup title according to the available data
		if response.title then
			info.title = "Livestream : " .. response.title
		else
			info.title = "Livestream Stream"
		end
		
		if onSuccess then
			pcall(onSuccess, info)
		end
		
    end
	
	local url = string.format( "http://x%sx.api.channel.livestream.com/2.0/info.json", data:gsub("_", "-") )
	self:Fetch( url, onReceive, onFailure )
	
end

theater.RegisterService( 'livestream', SERVICE )
