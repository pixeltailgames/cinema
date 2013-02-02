hook.Add( "OnPlayerChat", "TheaterChatFilter", function( ply, text, teamOnly, isDead )

	if !IsValid(ply) or teamOnly then return end

	local LocalInTheater = LocalPlayer():InTheater()
	local PlayerInTheater = ply:InTheater()

	-- One player in theater
	if ( (LocalInTheater and !PlayerInTheater) or
		(!LocalInTheater and PlayerInTheater) ) and
		LocalPlayer():GetLocation() != ply:GetLocation() then

		local msg = string.format("%s: %s", ply:Nick(), text)

		local Theater = ply:GetTheater()
		if Theater then
			msg = "(" .. Theater:Name() .. ") " .. msg
		end

		-- Print message to console for logging purposes
		print( msg )

		return true

	end

end )