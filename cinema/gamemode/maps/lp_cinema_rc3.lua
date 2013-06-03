Location.Add( "lp_cinema_rc3",
{

	[ "Entrance" ] =
	{
		Min = Vector( 58.739582061768, 1025.1486816406, -28.207374572754 ),
		Max = Vector( 945.72784423828, 1668.7130126953, 313.57202148438 ),
	},
	
	[ "Lobby" ] =
	{
		Min = Vector( -20.570646286011, -760.60040283203, -22.252363204956 ),
		Max = Vector( 1029.9267578125, 1028.6015625, 524.95721435547 ),
	},

	[ "Lobby " ] =
	{
		Min = Vector( -88.318634033203, -1096.5361328125, 43.408634185791 ),
		Max = Vector( 1257.0656738281, -759.04089355469, 332.33898925781 ),
	},
	
	[ "Restroom" ] =
	{
		Min = Vector( -635.43182373047, -647.58258056641, -13.020117759705 ),
		Max = Vector( 41.016635894775, -108.98025512695, 130.48645019531 ),
	},

	[ "Theater Hallway" ] =
	{
		Min = Vector( -582.96160888672, -3724.9155273438, -9.9199104309082 ),
		Max = Vector( 281.70657348633, -1076.7954101563, 320 ),
	},

	[ "Private Theater Lobby" ] =
	{
		Min = Vector( 1210.5618896484, -2121.1040039063, 31.730175018311 ),
		Max = Vector( 1987.3839111328, -761.59686279297, 331.8137512207 ),
	},

	[ "Theater 1" ] =
	{
		Min = Vector( 1276.0891113281, -753.62561035156, -74.043838500977 ),
		Max = Vector( 1802.4069824219, -119.57205963135, 268.62536621094 ),
		Theater = {
			Name = "Theater 1",
			Flags = THEATER_PRIVATE,
			Pos = Vector(1312,-145,240),
			Ang = Angle(0,0,0),
			Width = 460,
			Height = 460 * 8.4/16,
			ThumbInfo = {
				Pos = Vector( 1730, -778, 129 ),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	[ "Theater 2" ] =
	{
		Min = Vector( 1992.0043945313, -1417.48046875, -74.663749694824 ),
		Max = Vector( 2634.248046875, -895.44390869141, 262.9421081543 ),
		Theater = {
			Name = "Theater 2",
			Flags = THEATER_PRIVATE,
			Pos = Vector(2607,-928,240),
			Ang = Angle(0,-90,0),
			Width = 460,
			Height = 460 * 8.4/16,
			ThumbInfo = {
				Pos = Vector( 1969, -963, 129 ),
				Ang = Angle(0, 180, 0)
			}
		}
	},

	[ "Theater 3" ] =
	{
		Min = Vector( 1344.6174316406, -2762.2094726563, -73.503799438477 ),
		Max = Vector( 1860.0968017578, -2127.2963867188, 264.29132080078 ),
		Theater = {
			Name = "Theater 3",
			Flags = THEATER_PRIVATE,
			Pos = Vector(1824,-2735,240),
			Ang = Angle(0,180,0),
			Width = 460,
			Height = 460 * 8.4/16,
			ThumbInfo = {
				Pos = Vector( 1790, -2106, 129 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Theater 4" ] =
	{
		Min = Vector( 564.13494873047, -1735.6352539063, -70.400604248047 ),
		Max = Vector( 1202.0277099609, -1210.8370361328, 271.22839355469 ),
		Theater = {
			Name = "Theater 4",
			Flags = THEATER_PRIVATE,
			Pos = Vector(594,-1700,240),
			Ang = Angle(0,90,0),
			Width = 460,
			Height = 460 * 8.4/16,
			ThumbInfo = {
				Pos = Vector( 1222, -1280, 129 ),
				Ang = Angle(0, 0, 0)
			}
		}
	},

	[ "VIP Lobby Stairs" ] =
	{
		Min = Vector( 270.94876098633, -3404.4372558594, -236.2706451416 ),
		Max = Vector( 464.03833007813, -2203.0798339844, 324.10784912109 ),
	},

	[ "VIP Lobby" ] =
	{
		Min = Vector( 307.07693481445, -3399.1105957031, -235.4725189209 ),
		Max = Vector( 1581.4605712891, -2878.5754394531, 68.505668640137 ),
	},

	[ "VIP Theater" ] =
	{
		Min = Vector( 471.69003295898, -2885.6618652344, -233.36697387695 ),
		Max = Vector( 1219.1823730469, -2108.1340332031, 335.44393920898 ),
		Theater = {
			Name = "VIP Theater",
			Flags = THEATER_NONE,
			Pos = Vector(497, -2816, 256),
			Ang = Angle(0,90,0),
			Width = 640,
			ThumbInfo = {
				Pos = Vector( 288, -2490, 128 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "VIP Hallway" ] =
	{
		Min = Vector( 627.38317871094, -2108.9775390625, -300 ),
		Max = Vector( 1243.0301513672, -410.72430419922, -52.644165039063 ),
	},

	[ "VIP Entrance Stairs" ] =
	{
		Min = Vector( 639.56701660156, -799.38641357422, -273.97869873047 ),
		Max = Vector( 836.54382324219, -257.47122192383, 100 ),
	},

	[ "Theater 5" ] =
	{
		Min = Vector( -2143.9265136719, -3087.1096191406, -40 ),
		Max = Vector( -579.01818847656, -1271.1527099609, 979.17364501953 ),
		Theater = {
			Name = "Theater 5",
			Flags = THEATER_REPLICATED,
			Pos = Vector(-2090,-2976,945),
			Ang = Angle(0,90,0),
			Width = 1600,
			Height = 1600 * 7.05/16,
			ThumbInfo = {
				Pos = Vector( -121, -1677, 128 ),
				Ang = Angle(0, 0, 0)
			}
		}
	},

	[ "Theater 6" ] =
	{
		Min = Vector( -132.98751831055, -5278.59375, -83.097427368164 ),
		Max = Vector( 1677.1958007813, -3722.5969238281, 976.70745849609 ),
		Theater = {
			Name = "Theater 6",
			Flags = THEATER_REPLICATED,
			Pos = Vector(1568,-5230,944),
			Ang = Angle(0,180,0),
			Width = 1600,
			Height = 1600 * 7.05/16,
			ThumbInfo = {
				Pos = Vector( 190, -3434, 128 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Secret Theater" ] =
	{
		Min = Vector( -2065.5346679688, -4614.5400390625, -140.04862976074 ),
		Max = Vector( -134.29107666016, -3117.5637207031, 722.94610595703 ),
		Theater = {
			Name = "Secret Theater",
			Flags = THEATER_PRIVATE,
			Pos = Vector( -1699, -4352, 324 ),
			Ang = Angle(0,90,0),
			Width = 512,
			Height = 256
		}
	},

} )

if CLIENT then
	
	hook.Add( "InitPostEntity", "DisableHDR", function()

		-- This command attempts to save the game and change levels.
		-- By playing in multiplayer, saving the game isn't allowed.
		if not game.SinglePlayer() then
			RunConsoleCommand( "mat_hdr_level", 0 )
		end

	end )

end