local SERVICE = {}

SERVICE.Name 			= "URL"
SERVICE.IsTimed 		= false
SERVICE.TheaterType 	= THEATER_PRIVATE
SERVICE.Hidden 			= true

SERVICE.ValidExtensions = { '', 'html', 'htm', 'xhtml', 'dhtml', 'php', 'asp', 'aspx' }

function SERVICE:Match( url )
	return SERVER and GetConVar("cinema_allow_url"):GetBool()
end

function SERVICE:GetURLInfo( url )

	local info = {}
	info.Data = url.encoded

	return info

end

function SERVICE:GetVideoInfo( data, onSuccess, onFailure )

	local info = {}
	info.data = data

	local onReceive = function( body, length, headers, code )

		info.title = string.match( body, "<title>(.*)</title>" ) or "(Unknown)"

		if onSuccess then
			pcall(onSuccess, info)
		end

	end

	-- Parse url
	local status, url = pcall( url.parse2, data )

	if status and url and url.path then
		
		local ext = string.GetExtensionFromFilename( url.path )

		if ext == nil or table.HasValue( self.ValidExtensions, ext ) then
			self:Fetch( data, onReceive, onFailure )
			return
		end

	end

	if onSuccess then
		pcall(onSuccess, info)
	end

end

theater.RegisterService( 'url', SERVICE )