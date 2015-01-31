--[[---------------------------------------------------------
   Name: gamemode:SetPlayerSpeed( )
   Desc: Sets the player's run/walk speed
-----------------------------------------------------------]]
function GM:SetPlayerSpeed( ply, walk, run )

	ply:SetWalkSpeed( walk )
	ply:SetRunSpeed( run )
	
end


--[[---------------------------------------------------------
   Name: gamemode:OnPlayerChat()
		Process the player's chat.. return true for no default
-----------------------------------------------------------]]
function GM:OnPlayerChat( player, strText, bTeamOnly, bPlayerIsDead )
	
	--
	-- I've made this all look more complicated than it is. Here's the easy version
	--
	-- chat.AddText( player, Color( 255, 255, 255 ), ": ", strText )
	--
	
	local tab = {}
	
	if ( bPlayerIsDead ) then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "*DEAD* " )
	end
	
	if ( bTeamOnly ) then
		table.insert( tab, Color( 123, 32, 29 ) )
		table.insert( tab, "(GLOBAL) " )
	end
	
	if ( IsValid( player ) ) then
		table.insert( tab, player )
	else
		table.insert( tab, "Console" )
	end
	
	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": "..strText )
	
	chat.AddText( unpack(tab) )

	return true
	
end

--[[---------------------------------------------------------
   Name: gamemode:PlayerNoClip( player, bool )
   Desc: Player pressed the noclip key, return true if
		  the player is allowed to noclip, false to block
-----------------------------------------------------------]]
function GM:PlayerNoClip( pl, on )
	
	if GetConVar( "sv_cheats" ):GetInt() > 0 then return true end

	-- For development purposes
	if pl.IsPixelTail and pl:IsPixelTail() then return true end

	-- Allow noclip if we're in single player
	if ( game.SinglePlayer() ) then return true end
	
	-- Don't if it's not.
	return false
	
end

local meta = FindMetaTable( "Player" )
if !meta then 
	return
end

function meta:GetTranslatedModel()

	local model = self:GetModel()

	if model == "models/player/urban.mbl" then
		return "models/player/urban.mdl"
	end

	model = string.Replace( model, "models/humans/", "models/" )
	model = string.Replace( model, "models/", "models/" )

	/*if !string.find( model, "models/player/" ) then
		model = string.Replace( model, "models/", "models/player/" )
	end*/

	return model

end

function meta:SetProperties( ent )

	if !IsValid( ent ) then return end

	ent.GetPlayerColor = function() return self:GetPlayerColor() end
	ent:SetMaterial( self:GetMaterial() )
	ent:SetSkin( self:GetSkin() )
	ent:SetBodygroup( 1, self:GetBodygroup(1) )

end