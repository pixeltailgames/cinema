Location.Add( "theater_gcinema", {

	[ "Entrance" ] =
	{
		Min = Vector( -1419.0390625, -2438.0549316406, -23.409111022949 ),
		Max = Vector( 1579.7911376953, -795.29162597656, 489.12609863281 ),
	},

	[ "Lobby" ] =
	{
		Min = Vector( -335.54898071289, -834.86083984375, -21.256698608398 ),
		Max = Vector( 331.14721679688, 975.93469238281, 529.24096679688 ),
	},

	[ "Public Theater 1" ] =
	{
		Min = Vector( -2833.1979980469, -465.02133178711, -323.7939453125 ),
		Max = Vector( -486.01016235352, 1101.3576660156, 500.62933349609 ),
		Theater = {
			Name = "Public Theater 1",
			Flags = THEATER_REPLICATED,
			Pos = Vector( -2589, -190, 350 ),
			Ang = Angle(0,90,0),
			Width = 1024,
			Height = 512,
			ThumbInfo = {
				Pos = Vector( -314, 318, 325 ),
				Ang = Angle(0, 0, 0)
			}
		}
	},

	[ "Public Theater 2" ] =
	{
		Min = Vector( 490.45068359375, -451.67416381836, -413.57528686523 ),
		Max = Vector( 2849.8955078125, 1161.2780761719, 500.63534545898 ),
		Theater = {
			Name = "Public Theater 2",
			Flags = THEATER_REPLICATED,
			Pos = Vector( 2589, 830, 350 ),
			Ang = Angle(0,-90,0),
			Width = 1024,
			Height = 512,
			ThumbInfo = {
				Pos = Vector( 314, 318, 325 ),
				Ang = Angle(0, 180, 0)
			}
		}
	},

	[ "Basement Theater Entrance" ] =
	{
		Min = Vector( -868.29113769531, -3983.4748535156, -1019.6119384766 ),
		Max = Vector( 879.37188720703, -3050.068359375, -708.78607177734 ),
	},

	[ "Basement Theater" ] =
	{
		Min = Vector( -867.44512939453, -5929.8344726563, -1014.3399658203 ),
		Max = Vector( 881.07196044922, -3983.3635253906, -224.58911132813 ),
		Theater = {
			Name = "Basement Theater",
			Flags = THEATER_REPLICATED,
			Pos = Vector( 512, -5629, -400 ),
			Ang = Angle(0,180,0),
			Width = 1024,
			Height = 512,
			ThumbInfo = {
				Pos = Vector( 7, -3577, -845 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Hell Theater" ] =
	{
		Min = Vector( -620.81274414063, -2141.7497558594, -4255.978515625 ),
		Max = Vector( 573.09088134766, 4140.6440429688, -2402.5239257813 ),
		Theater = {
			Name = "Hell Theater",
			Flags = THEATER_PRIVATE,
			Pos = Vector( 192, 417, -3484 ),
			Ang = Angle(0,180,0),
			Width = 384,
			Height = 190
		}
	},

	[ "Dungeon Theater" ] =
	{
		Min = Vector( -912.86499023438, 1844.2559814453, -365.92636108398 ),
		Max = Vector( 927.97497558594, 3366.9819335938, 130 ),
		Theater = {
			Name = "Dungeon Theater",
			Flags = THEATER_REPLICATED,
			Pos = Vector( 190, 2055, -42 ),
			Ang = Angle(0,180,0),
			Width = 384,
			Height = 190,
			ThumbInfo = {
				Pos = Vector( 7, -3577, -845 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "VIP Theater" ] =
	{
		Min = Vector( -1056.6315917969, 3500, -100 ),
		Max = Vector( 1031.2008056641, 5292.6352539063, 863.75415039063 ),
		Theater = {
			Name = "VIP Theater",
			Flags = THEATER_PRIVILEGED,
			Pos = Vector( 232, 3527, 578 ),
			Ang = Angle(0,180,0),
			Width = 464,
			Height = 234,
			ThumbInfo = {
				Pos = Vector( 7, -3577, -845 ),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Pub Theater" ] =
	{
		Min = Vector( -584.41033935547, -1405.4254150391, 479.64831542969 ),
		Max = Vector( 587.36596679688, -320.90960693359, 711.02716064453 ),
		Theater = {
			Name = "Pub Theater",
			Flags = THEATER_REPLICATED,
			Pos = Vector( 120, -1384, 680 ),
			Ang = Angle(0,180,0),
			Width = 240,
			Height = 128
		}
	},

	[ "Private Theater 1" ] =
	{
		Min = Vector( 720.68334960938, 1403.3217773438, 270.52685546875 ),
		Max = Vector( 1246.5190429688, 2150.435546875, 524.49401855469 ),
		Theater = {
			Name = "Private Theater 1",
			Flags = THEATER_PRIVATE,
			Pos = Vector( 1184, 1415, 488 ),
			Ang = Angle(0,180,0),
			Width = 400,
			Height = 192,
			ThumbInfo = {
				-- Pos = Vector( 698, 1950, 340 ),
				Pos = Vector( 708, 2048, 464 ),
				Ang = Angle(0, -180, 0)
			}
		}
	},

	[ "Private Theater 2" ] =
	{
		Min = Vector( 89.546371459961, 2146.0087890625, 264.03634643555 ),
		Max = Vector( 719.5185546875, 2668.5183105469, 520.34588623047 ),
		Theater = {
			Name = "Private Theater 2",
			Flags = THEATER_PRIVATE,
			Pos = Vector( 103, 2208, 488 ),
			Ang = Angle(0,90,0),
			Width = 400,
			Height = 192,
			ThumbInfo = {
				Pos = Vector( 624, 2130, 464 ),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	[ "Private Theater 3" ] =
	{
		Min = Vector( -722.43237304688, 2145.02734375, 275.83377075195 ),
		Max = Vector( -90.836708068848, 2662.8518066406, 539.13446044922 ),
		Theater = {
			Name = "Private Theater 3",
			Flags = THEATER_PRIVATE,
			Pos = Vector( -101, 2608, 488 ),
			Ang = Angle(0,-90,0),
			Width = 400,
			Height = 192,
			ThumbInfo = {
				Pos = Vector( -624, 2130, 464 ),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	[ "Private Theater 4" ] =
	{
		Min = Vector( -1239.3917236328, 1395.7678222656, 275.69482421875 ),
		Max = Vector( -721.37194824219, 2148.2026367188, 514.07659912109 ),
		Theater = {
			Name = "Private Theater 4",
			Flags = THEATER_PRIVATE,
			Pos = Vector( -784, 1415, 488 ),
			Ang = Angle(0,180,0),
			Width = 400,
			Height = 192,
			ThumbInfo = {
				-- Pos = Vector( 698, 1950, 340 ),
				Pos = Vector( -708, 2048, 464 ),
				Ang = Angle(0, 0, 0)
			}
		}
	},

	[ "Top Floor Theater" ] =
	{
		Min = Vector( -310.96578979492, 971.650390625, 538.35803222656 ),
		Max = Vector( 325.26461791992, 2160.3903808594, 892.08532714844 ),
		Theater = {
			Name = "Top Floor Theater",
			Flags = THEATER_PRIVATE,
			Pos = Vector( -200, 2139, 792 ),
			Ang = Angle(0,0,0),
			Width = 400,
			Height = 200
		}
	},

	[ "Luna's Bedroom" ] =
	{
		Min = Vector( -12.533141136169, 12772.05859375, -3094.5539550781 ),
		Max = Vector( 1038.3375244141, 14334.049804688, -2045.6434326172 ),
		Theater = {
			Name = "Luna's Bedroom",
			Flags = THEATER_PRIVATE,
			Pos = Vector( 192, 14313, -2653 ),
			Ang = Angle(0,0,0),
			Width = 640,
			Height = 320
		}
	},

	[ "Arctic Theater" ] =
	{
		Min = Vector( -13322.061523438, 11119.529296875, -1135.0418701172 ),
		Max = Vector( -11203.059570313, 13295.51953125, -237.52056884766 ),
		Theater = {
			Name = "Arctic Theater",
			Flags = THEATER_PRIVATE,
			Pos = Vector( -12921, 12016, -592 ),
			Ang = Angle(0,90,0),
			Width = 640,
			Height = 320
		}
	},

	[ "Slender Theater" ] =
	{
		Min = Vector( -2308.6823730469, 1091.2844238281, -260.3759765625 ),
		Max = Vector( -1914.7735595703, 1545.3917236328, 28.815818786621 ),
		Theater = {
			Name = "Slender Theater",
			Flags = THEATER_REPLICATED,
			Pos = Vector( -2208, 1531, -98 ),
			Ang = Angle(0,0,0),
			Width = 192,
			Height = 100
		}
	},

	[ "VIP Floor" ] =
	{
		Min = Vector( -80.503799438477, 2144.513671875, 247.11721801758 ),
		Max = Vector( 79.902877807617, 3216.0578613281, 418.25817871094 ),
	},
	
	[ "VIP Entrance" ] =
	{
		Min = Vector( -583.04174804688, 3220.5114746094, 251.42886352539 ),
		Max = Vector( 573.45965576172, 3499.5632324219, 387.75061035156 ),
	},

	[ "Super Hidden Room" ] =
	{
		Min = Vector( -64.806373596191, 973.65246582031, -4.4713802337646 ),
		Max = Vector( 66.821266174316, 1104.259765625, 128.87648010254 ),
	},
	
	[ "Lobby Rooftop" ] =
	{
		Min = Vector( -304.06265258789, -302.57995605469, 526.64935302734 ),
		Max = Vector( 303.55523681641, 957.10504150391, 872.72747802734 ),
	},

	[ "Private Theater Floor" ] =
	{
		Min = Vector( -719.42706298828, 1183.4890136719, 249.16082763672 ),
		Max = Vector( -384.65243530273, 2143.2282714844, 448.49328613281 ),
	},

	[ "Private Theater Floor " ] =
	{
		Min = Vector( 386.58871459961, 1195.9959716797, 248.40202331543 ),
		Max = Vector( 718.66912841797, 2139.2778320313, 441.12048339844 ),
	},

	[ "Private Theater Floor  " ] =
	{
		Min = Vector( -389.35641479492, 1953.8305664063, 273.15951538086 ),
		Max = Vector( 381.22338867188, 2133.296875, 427.64999389648 ),
	},

	[ "Upstairs" ] =
	{
		Min = Vector( -576.95013427734, 976.20080566406, 250.82989501953 ),
		Max = Vector( 576.67718505859, 1105.6745605469, 436.03286743164 ),
	},

	[ "Upstairs Left Floor" ] =
	{
		Min = Vector( 352.86343383789, -322.83120727539, 249.18057250977 ),
		Max = Vector( 478.97534179688, 974.97711181641, 689.38140869141 ),
	},

	[ "Upstairs Right Floor" ] =
	{
		Min = Vector( -480.41302490234, -319.20645141602, 252.8938293457 ),
		Max = Vector( -353.58770751953, 959.1953125, 692.04571533203 ),
	},
	
	[ "Lobby " ] =
	{
		Min = Vector( 98.040893554688, 981.08795166016, 7.9526500701904 ),
		Max = Vector( 300.75900268555, 1120.8322753906, 205.17816162109 ),
	},
	
	[ "Lobby   " ] =
	{
		Min = Vector( -309.30969238281, 979.06311035156, 0.79807949066162 ),
		Max = Vector( -99.15788269043, 1121.0633544922, 202.10514831543 ),
	},

	[ "Lobby    " ] =
	{
		Min = Vector( -384.01428222656, 1119.3227539063, -20.016326904297 ),
		Max = Vector( 384.03039550781, 1409.7254638672, 239.98001098633 ),
	},

	[ "Staircase" ] =
	{
		Min = Vector( -382.01361083984, 1120.1896972656, 271.74862670898 ),
		Max = Vector( 383.49563598633, 1408.1882324219, 516.78228759766 ),
	},

	[ "Staircase " ] =
	{	
		Min = Vector( -385.35534667969, 1410.3699951172, -18.614616394043 ),
		Max = Vector( 385.29098510742, 1864.3431396484, 527.95355224609 ),
	},

} )

-- Give players who enter the dungeon theater a crowbar
hook.Add( "PlayerChangeLocation", "GivePlayerCrowbar", function( ply, loc, old )

	if !IsValid(ply) then return end

	local Theater = theater.GetByLocation( loc )
	local bHasCrowbar = ply:HasWeapon( "weapon_crowbar" )

	if Theater and Theater:Name() == "Dungeon Theater" and !bHasCrowbar then
		ply:Give( "weapon_crowbar" )
	elseif bHasCrowbar then
		ply:StripWeapon( "weapon_crowbar" )
	end

end )
