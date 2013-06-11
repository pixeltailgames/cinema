Location.Add( "theater_nexmultiplex_1m",
{
	/*
		Main Lobby
	*/
	[ "Lobby" ] =
	{
		Min = Vector( -713.77624511719, -390.92556762695, -5.9866619110107 ),
		Max = Vector( 969.14471435547, 1154.6978759766, 598.09539794922 ),
	},

	[ "Parking Lot" ] =
	{
		Min = Vector( -770.06140136719, -1499.7299804688, -36.96875 ),
		Max = Vector( 943.96875, -404.81100463867, 571.09442138672 ),
	},

	/*
		Public Theaters
	*/
	[ "Theater Hallway" ] =
	{
		Min = Vector( 960.60504150391, 453.3369140625, -7.6199698448181 ),
		Max = Vector( 2115.1953125, 1089.2204589844, 167.94856262207 ),
	},

	[ "Theater #1" ] =
	{
		Min = Vector( 1315.03125, 1104.03125, -4.96875 ),
		Max = Vector( 2510.8200683594, 2398.498046875, 589.53558349609 ),
		Theater = {
			Name = "Theater 1",
			Flags = THEATER_REPLICATED,
			Pos = Vector(1454,2382,576),
			Ang = Angle(0,0,0),
			Width = 1030,
			Height = 513,
			ThumbInfo = {
				Pos = Vector(1288, 994.5, 70),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	[ "Theater #2" ] =
	{
		Min = Vector( 1315.9333496094, -880.59344482422, -7.9681177139282 ),
		Max = Vector( 2518.859375, 508.27401733398, 610.63684082031 ),
		Theater = {
			Name = "Theater 2",
			Flags = THEATER_REPLICATED,
			Pos = Vector(2480,-815,576),
			Ang = Angle(0,180,0),
			Width = 1030,
			Height = 513,
			ThumbInfo = {
				Pos = Vector(1288, 541.5, 70),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Hidden Theater" ] =
	{
		Min = Vector( 2529.7536621094, 1368.3074951172, 233.62231445313 ),
		Max = Vector( 2796.0266113281, 1554.6059570313, 363.56753540039 ),
		Theater = {
			Name = "Server Room",
			Pos = Vector(2696,1388,320),
			Ang = Angle(0,180,0),
			Width = 66,
			Height = 33.2
		}
	},

	/*
		Private Theaters
	*/
	[ "Private Theater Hallway" ] =
	{
		Min = Vector( -2149.923828125, 511.40008544922, -24.675968170166 ),
		Max = Vector( -704.55938720703, 1027.1750488281, 188.14825439453 ),
	},

	[ "Private Theater #1" ] =
	{
		Min = Vector( -1342.1008300781, -26.625434875488, -6.1940565109253 ),
		Max = Vector( -938.23370361328, 510.13543701172, 199.19172668457 ),
		Theater = {
			Name = "Private Theater 1",
			Flags = THEATER_PRIVATE,
			Pos = Vector(-960,-10,188),
			Ang = Angle(0,180,0),
			Width = 352.1,
			Height = 176,
			ThumbInfo = {
				Pos = Vector(-1120, 517.6, 70),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Private Theater #2" ] =
	{
		Min = Vector( -1898.6419677734, -35.299835205078, -6.7253732681274 ),
		Max = Vector( -1503.0150146484, 511.3669128418, 191.63739013672 ),
		Theater = {
			Name = "Private Theater 2",
			Flags = THEATER_PRIVATE,
			Pos = Vector(-1524,-10,188),
			Ang = Angle(0,180,0),
			Width = 352.1,
			Height = 176,
			ThumbInfo = {
				Pos = Vector(-1680, 517.6, 70),
				Ang = Angle(0, 90, 0)
			}
		}
	},

	[ "Private Theater #3" ] =
	{
		Min = Vector( -1892.9193115234, 1026.2399902344, -16.446285247803 ),
		Max = Vector( -1502.0886230469, 1568.1118164063, 194.49468994141 ),
		Theater = {
			Name = "Private Theater 3",
			Flags = THEATER_PRIVATE,
			Pos = Vector(-1876,1546,188),
			Ang = Angle(0,0,0),
			Width = 352.1,
			Height = 176,
			ThumbInfo = {
				Pos = Vector(-1680, 1018.5, 70),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	[ "Private Theater #4" ] =
	{
		Min = Vector( -1330.7666015625, 1025.7158203125, -20.488964080811 ),
		Max = Vector( -937.87774658203, 1564.5681152344, 201.37200927734 ),
		Theater = {
			Name = "Private Theater 4",
			Flags = THEATER_PRIVATE,
			Pos = Vector(-1312,1546,188),
			Ang = Angle(0,0,0),
			Width = 352.1,
			Height = 176,
			ThumbInfo = {
				Pos = Vector(-1120, 1018.5, 70),
				Ang = Angle(0, -90, 0)
			}
		}
	},

	/*
		Pool Theater
	*/
	[ "Pool" ] =
	{
		Min = Vector( -153.40953063965, 1790.8237304688, -70.618278503418 ),
		Max = Vector( 545.57879638672, 2252.5661621094, 164.99580383301 ),
		Theater = {
			Name = "Pool Theater",
			Pos = Vector(530,2163.1,144),
			Ang = Angle(0,-90,0),
			Width = 253,
			Height = 124.4
		}
	},


	/*
		Bathrooms
	*/
	[ "Fecal Depository" ] =
	{
		Min = Vector( 1017.2495727539, 64.891738891602, -4.4785866737366 ),
		Max = Vector( 1347.2325439453, 504.8903503418, 111.97386932373 ),
	},

	[ "Fecal Depository " ] =
	{
		Min = Vector( 1038.734375, 1024.6845703125, -13.828351974487 ),
		Max = Vector( 1351.2644042969, 1469.17578125, 114.08692169189 ),
	},

	/*
		VIP Areas
	*/
	[ "VIP Lounge" ] =
	{
		Min = Vector( 1430.3830566406, 309.80764770508, 372.66598510742 ),
		Max = Vector( 2350.7016601563, 1218.6944580078, 533.43963623047 ),
		Theater = {
			Name = "VIP Theater",
			Flags = THEATER_PRIVILEGED,
			Pos = Vector(1451,608,560),
			Ang = Angle(0,90,0),
			Width = 320,
			Height = 160
		}
	},

	[ "VIP Entrance" ] =
	{
		Min = Vector( 2117.3698730469, 211.97885131836, -21.230167388916 ),
		Max = Vector( 2440.1611328125, 1333.1423339844, 374.72283935547 ),
	},

} )

-- Give players who enter the Parking Lot a crowbar
hook.Add( "PlayerChangeLocation", "GivePlayerCrowbar", function( ply, loc, old )

	if !IsValid(ply) then return end

	local bHasCrowbar = ply:HasWeapon( "weapon_crowbar" )
	
	if ply:GetLocationName() == "Parking Lot" and !bHasCrowbar then
		ply:Give( "weapon_crowbar" )
	elseif bHasCrowbar then
		ply:StripWeapon( "weapon_crowbar" )
	end

end )
