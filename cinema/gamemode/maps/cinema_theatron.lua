game.AddParticles( "particles/cinema_fx.pcf" )
PrecacheParticleSystem( "cn_rain" )

Location.Add( "cinema_theatron",
{

	[ "Lobby" ] =
	{
		Min = Vector( -515.17193603516, -1427.5533447266, -20.195838928223 ),
		Max = Vector( 521.00085449219, 4.4969038963318, 410.99740600586 ),
	},


	[ "Theater #1" ] =
	{
		Min = Vector( -2034.5607910156, 1006.8955688477, -80.47876739502 ),
		Max = Vector( -691.22741699219, 1941.6989746094, 538.93444824219 ),
	},

	[ "Theater #2" ] =
	{
		Min = Vector( 622.73846435547, 779.41314697266, -119.10536956787 ),
		Max = Vector( 1993.6649169922, 1902.1906738281, 600.06420898438 ),
	},

	[ "Left Wing" ] =
	{
		Min = Vector( -1529.9309082031, -447.18112182617, -5.1717448234558 ),
		Max = Vector( -516.01611328125, 128.62678527832, 148.8177947998 ),
	},

	[ "Right Wing" ] =
	{
		Min = Vector( 514.36254882813, -391.40307617188, -13.028125762939 ),
		Max = Vector( 1550.673828125, 134.18215942383, 198.708984375 ),
	},

	[ "Men's Bathroom" ] =
	{
		Min = Vector( 518.7890625, -1028.9625244141, -22.301418304443 ),
		Max = Vector( 906.95074462891, -496.02767944336, 141.60182189941 ),
	},

	[ "Women's Bathroom" ] =
	{
		Min = Vector( -906.80114746094, -1027.4053955078, -14.880827903748 ),
		Max = Vector( -510.84283447266, -505.12573242188, 139.19288635254 ),
	},

	[ "Concessions" ] =
	{
		Min = Vector( -414.78909301758, 5.2761745452881, -27.878173828125 ),
		Max = Vector( 388.34725952148, 261.86242675781, 133.07136535645 ),
	},

	[ "Private Theater #1" ] =
	{
		Min = Vector( -1734.1312255859, -1136.4696044922, -40.398372650146 ),
		Max = Vector( -1013.1742553711, -650.52453613281, 279.88903808594 ),
	},

	[ "Private Theater #2" ] =
	{
		Min = Vector( -2739.845703125, -1136.3590087891, -50.352893829346 ),
		Max = Vector( -2008.2265625, -662.44708251953, 296.28726196289 ),
	},

	[ "Private Theater #3" ] =
	{
		Min = Vector( 913.95922851563, -1117.9099121094, -47.429630279541 ),
		Max = Vector( 1648.2966308594, -635.8330078125, 298.12783813477 ),
	},

	[ "Private Theater #4" ] =
	{
		Min = Vector( 1918.5902099609, -1107.4350585938, -41.656314849854 ),
		Max = Vector( 2640.4851074219, -630.02233886719, 292.02615356445 ),
	},

	[ "Unknown" ] =
	{
		Min = Vector( 1244.9357910156, -2546.5344238281, -843.10437011719 ),
		Max = Vector( 2210.9982910156, -1666.1209716797, -459.64486694336 ),
	},

} )

if SERVER then
	
	local UseCooldown = 0.3 -- seconds
	hook.Add( "PlayerUse", "PrivateTheaterLightSwitch", function( ply, ent )

		if ply.LastUse and ply.LastUse + UseCooldown > CurTime() then
			return false
		end

		-- Always admit admins
		if ply:IsAdmin() then return true end

		-- Only private theater owners can switch the lights
		local Theater = ply:GetTheater()
		if Theater and Theater:IsPrivate() and ent:GetClass() == "func_button" then

			ply.LastUse = CurTime()

			if Theater:GetOwner() != ply then
				Theater:AnnounceToPlayer( ply, 'Theater_OwnerUseOnly' )
				return false
			end

		end

		return true

	end )

end