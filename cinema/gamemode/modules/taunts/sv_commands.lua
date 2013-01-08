local commands = {
	agree = "agree",
	bow = "bow",
	beckon = "becon",
	cheer = "cheer",
	dance = "muscle",
	disagree = "disagree",
	forward = "forward",
	group = "group",
	halt = "halt",
	flail = "zombie",
	laugh = "laugh",
	-- point = "point",
	-- salute = "salute",
	wave = "wave",
	zombie = "zombie",
}

hook.Add( "PlayerSay", "TheaterActCommands", function( ply, chat )

	if string.StartWith( chat, '/' ) then
		
		if ply:IsPlayingTaunt() then
			return ""
		end

		local command = string.match( chat, "/(.*)" )

		if commands[command] then

			ply:SendLua( "RunConsoleCommand('act', '" .. commands[command] .. "')" )

			local msg = {
				theater.ColHighlight,
				ply:Nick(),
				theater.ColDefault,
				" " .. command .. "s"
			}

			net.Start( "TheaterAnnouncement" )
				net.WriteTable(msg)
			net.Send( Location.GetPlayersInLocation( ply:GetLocation() ) )

			return ""

		end

	end

end )