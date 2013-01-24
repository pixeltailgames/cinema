local PlayerMeta = FindMetaTable("Player")
if !PlayerMeta then return end

local Developers = {
	"STEAM_0:0:0",			// Lua refresh error
	"STEAM_0:1:6044247",	// MacDGuy
	"STEAM_0:1:18712009",	// Foohy
	"STEAM_0:1:15862026",	// Sam
	"STEAM_0:0:5129735",	// Mr. Sunabouzu
	"STEAM_0:0:15339565",	// Clopsy
	"STEAM_0:1:4556804",	// Azuisleet
}

function PlayerMeta:IsPixelTail()
	if !IsValid(self) then return false end
	return table.HasValue( Developers, self:SteamID() )
end