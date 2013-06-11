local commands = {
	agree = "agree",
	bow = "bow",
	beckon = "becon",
	cheer = "cheer",
	dance = "dance",
	disagree = "disagree",
	forward = "forward",
	group = "group",
	halt = "halt",
	flail = "zombie",
	laugh = "laugh",
	muscle = "muscle",
	-- point = "point",
	robot = "robot",
	-- salute = "salute",
	sexy = "muscle",
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

			net.Start( "TheaterAnnouncement" )
				net.WriteTable({
					'ActCommand',
					ply:Nick(),
					command
				})
			net.Send( Location.GetPlayersInLocation( ply:GetLocation() ) )

			return ""

		end

	end

end )