if CLIENT then
	
	translations = {}

	local Languages = {}
	local DefaultId = "en"

	function translations.GetLanguage()
		return "en" -- TODO: Get user's language
	end

	function translations.Format( key, ... )
		local lang = translations.GetLanguage()
		local value = Languages[lang] and Languages[lang][key] or Languages[DefaultId][key]
		if not value then value = key end
		return string.format( value, ... )
	end

	function translations.Register( id, tbl )
		if not ( id and tbl ) then return end
		if not Languages[id] then Languages[id] = {} end
		for k, v in pairs( tbl ) do
			Languages[id][k] = v
		end
	end

	T = translations.Format

end

-- Load language files
local LanguageFiles = file.Find( GM.FolderName .. "/gamemode/localization/*", "LUA" )
for _, filename in pairs( LanguageFiles ) do
	if SERVER then
		AddCSLuaFile( "localization/" .. filename )		
	else
		LANG = {}
		include( "localization/" .. filename )
		translations.Register( LANG.Id, LANG )
		LANG = nil
	end
end
