if CLIENT then
	
	local Debug = CreateClientConVar( "cinema_translation_debug", 0, false, false )

	translations = {}

	local Languages = {}
	local DefaultId = "en"

	function translations.GetLanguage()
		return GetConVarString("gmod_language")
	end

	function translations.GetLanguages()
		return Languages
	end

	function translations.Format( key, ... )
		if !key then return "" end
		if Debug:GetBool() then print("TRANSLATION: " .. key) end
		local lang = translations.GetLanguage()
		local value = Languages[lang] and Languages[lang][key] or Languages[DefaultId][key]
		if not value or Debug:GetBool() then value = key end
		return string.format( value, ... )
	end

	function translations.Register( id, tbl )
		if not ( id and tbl ) then return end
		if not Languages[id] then Languages[id] = {} end
		for k, v in pairs( tbl ) do
			Languages[id][k] = v
		end
	end

	local patterns = {
		format 	= "{{%s:%s}}",
		tag 	= "{{.-}}",
		data 	= "{{(.-):(.-)}}",
		rgb 	= "(%d+),(%d+),(%d+)"
	}

	local function buildTag(name, data)
		return string.format(patterns.format, name, data)
	end

	local function parseTag(tag)
		local key, value = string.match(tag, patterns.data)

		-- Deserialize color
		if key == 'rgb' then
			local r,g,b = string.match(value, patterns.rgb)
			return Color(r,g,b)
		end

		return tag
	end

	function translations.FormatChat( key, ... )
		local value = translations.Format( key, ... )

		-- Parse tags
		if string.find(value, patterns.tag) then

			local tbl = {}

			while true do

				-- Find first tag occurance
				local start, stop = string.find(value, patterns.tag)

				-- Break loop if there are no more tags
				if not start then
					-- Insert remaining fragment of translation
					if value != "" then
						table.insert( tbl, value )
					end
					break
				end

				-- Insert beginning fragment of translation
				if start > 0 then
					local str = value:sub(0, start - 1)
					table.insert( tbl, str )
				end

				-- Extract tag
				local tag = value:sub(start, stop)

				-- Parse and insert tag object
				table.insert( tbl, parseTag(tag) )

				-- Reduce translation string past tag
				value = value:sub(stop + 1, string.len(value))

			end

			value = tbl

		end

		return istable(value) and value or {value}
	end

	function translations.Compile(...)
		local str = ""
		for _, v in pairs({...}) do
			-- Serialize color
			if istable(v) and v.r and v.g and v.b then
				local col = string.format("%d,%d,%d", v.r, v.g, v.b)
				str = str .. buildTag('rgb', col)
			else
				str = str .. tostring(v)
			end
		end
		return str
	end

	T = translations.Format
	C = translations.Compile

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

-- Unset variable
if CLIENT then C = nil end