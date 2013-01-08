module( "Loader", package.seeall )

BaseGamemode = GM.FolderName

local function GetFileList( strDirectory, strGamemode )
	
	local files = {}

	local realDirectory = strGamemode .. "/gamemode/" .. strDirectory .. "/*"
	local findFiles, findFolders = file.Find( realDirectory, "LUA" )

	for k, v in pairs( table.Add(findFiles, findFolders) ) do
	
		if ( v == "." || v == ".." || v == ".svn" ) then continue end
		
		table.insert( files, v )
		
	end
	
	return files
	
end

local function IsLuaFile( strFile )
	return ( string.sub( strFile, -4 ) == ".lua" )
end

local function IsDirectory( strDir )
	return ( string.GetExtensionFromFilename( strDir ) == nil )
end

local function LoadFile( strDirectory, strGamemode, strFile )
	
	local prefix = string.sub( strFile, 0, 3 )
	local realFile = strGamemode .. "/gamemode/" .. strDirectory .. "/" .. strFile

	if ( prefix == "cl_" ) then
		
		if SERVER then
			AddCSLuaFile( realFile )
		else
			include( realFile )
		end
	
	elseif ( prefix == "sh_" ) then
	
		if SERVER then
			AddCSLuaFile( realFile )
		end
		
		include( realFile )
		
	elseif ( prefix == "sv_" || strFile == "init.lua" ) then
	
		if SERVER then
			include( realFile )
		end
		
	end
	
end

function LoadAction( strDirectory, strGamemode, funcAction )

	local entList = GetFileList( strDirectory, strGamemode )
	
	for _, v in pairs( entList ) do
	
		local entDir = strDirectory .. "/" .. v
		local entFiles = GetFileList( entDir, strGamemode )

		funcAction( entDir, entFiles, v, strGamemode )
		
	end
	
end

function LoadEntities( entDir, entFiles, entName, strGamemode )

	_G.ENT = {}
	
	for _, entFile in pairs( entFiles ) do
		LoadFile( entDir, strGamemode, entFile )
	end
	
	if _G.ENT.Type then
		scripted_ents.Register( _G.ENT, entName, false )
	end
	
	_G.ENT = nil
	
end

function LoadEnts( strDirectory, strGamemode )

	local strDirectory = strDirectory .. "/ents"
	local fileList = GetFileList( strDirectory, strGamemode )

	for _, v in pairs( fileList ) do

		local entFolder = strDirectory .. "/" .. v
		
		if ( v == "entities" ) then
			LoadAction( entFolder, strGamemode, LoadEntities )
		end
		
	end
	
end

function Load( strDirectory, strGamemode )
	
	if ( !strGamemode ) then
		strGamemode = BaseGamemode
	end
	
	local fileList = GetFileList( strDirectory, strGamemode )

	if table.HasValue( fileList, "ents" ) then
		LoadEnts( strDirectory, strGamemode )
	end

	for k, v in pairs( fileList ) do
	
		if ( IsLuaFile( v ) ) then
		
			LoadFile( strDirectory, strGamemode, v )
			
		elseif ( v != "ents" ) then // we won't go into ents folders

			local strNextDir = strDirectory .. "/" .. v
			
			if IsDirectory( strNextDir ) then
				Load( strNextDir, strGamemode ) // go deeper. BWOOOOOONG!!
			end
			
		end
	end
	
end