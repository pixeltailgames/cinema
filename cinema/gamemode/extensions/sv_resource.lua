resource.ValidExtensions = { "vmt", "png", "mdl", "wav", "mp3", "ttf" }

function resource.AddDirectory( directory, recursive, path )

	if !directory then return end

	-- Remove trailing folder '/'
	if string.match( directory, "/$" ) then
		directory = string.sub( directory, 1, string.len(directory) - 1 )
	end

	-- Set default values
	if recursive == nil then recursive = true end
	if path == nil then path = "GAME" end

	local files, folders = file.Find( directory .. "/*", path )

	for _, v in pairs( files ) do

		local File = directory .. "/" .. v

		if v != "_svn" && v != ".svn" then

			local ext = string.GetExtensionFromFilename(v)
			
			if table.HasValue( resource.ValidExtensions, ext ) then
				local DownloadFile = string.lower( File )
				resource.AddFile( DownloadFile )
			end

		end

	end

	if recursive then

		for _, v in pairs( folders ) do
			resource.AddDirectory( directory .. "/" .. v, recursive, path )
		end

	end

end