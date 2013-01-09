module( "Location", package.seeall )

Debug = false
Maps = {}

// register a set of locations for a map
function Add( strName, tblMap )

	// build indexes
	local idx = 1
	for k, v in pairs( tblMap ) do
		v.Index = idx
		idx = idx + 1
	end
	
	local mapTbl =
	{
		Name = strName,
		Locations = tblMap,
	}
	
	if ( Debug ) then
		MsgN( "Adding locations for: ", strName, " # locations: ", idx - 1 )
	end
	
	table.insert( Maps, mapTbl )
end

// returns a table of locations for the specified map, or the current map if nil
function GetLocations( strMap )

	if ( !strMap ) then
		strMap = game.GetMap()
	end
	
	strMap = string.lower( strMap )

	for _, v in pairs( Maps ) do
		if ( v.Name == strMap ) then return v.Locations end
	end
	
end

// returns the location string of the index
function GetLocationNameByIndex( iIndex )

	local locations = GetLocations()
	
	if locations then
	
		for k, v in pairs( locations ) do
			if v.Index == iIndex then
				return k
			end
		end
		
	end
	
	return "Unknown"
	
end

// find a location by index
// indexes get networked
function GetLocationByIndex( iIndex, strMap )
	local locations = GetLocations( strMap )
	if !locations then return end
	for k, v in pairs( locations ) do
		if ( v.Index == iIndex ) then return v end
	end
end

// find a location by name
function GetLocationByName( strName, strMap )
	local locations = GetLocations( strMap )
	if !locations then return end
	for k, v in pairs( locations ) do
		if ( k == strName ) then return v end
	end
end

local function GetTeleportBy( func, nameOrIndex, strMap )

	local tblLoc = func( nameOrIndex, strMap )
	
	if ( !tblLoc ) then
	
		if ( SERVER ) then
			Sql.Log( "location", "Tried to get teleport for invalid location \"" .. nameOrIndex .. "\" on map \"" .. strMap .. "\"!" )
		end
		
		return
	end
	
	if ( !tblLoc.Teleports ) then
	
		if ( SERVER ) then
			Sql.Log( "location", "Tried to get a teleport for a location \"" .. nameOrIndex .. "\" on map \"" .. strMap .. "\" without any registered teleports!" )
		end
		
		// we'll give them the center of the location for now
		return ( tblLoc.Max + tblLoc.Min ) / 2
		
	end
	
	return table.Random( tblLoc.Teleports )
	
end

function GetTeleportByName( strName, strMap )
	return GetTeleportBy( GetLocationByName, strName, strMap )
end

function GetTeleportByIndex( iIndex, strMap )
	return GetTeleportBy( GetLocationByIndex, iIndex, strMap )
end

// returns the index of the player's current location, or 0 if unknown
function Find( ply )
	
	local tblLoc = GetLocations()
	
	if ( !tblLoc ) then return 0 end
	
	for k, v in pairs( tblLoc ) do
		if ( ply:GetPos():InBox( v.Min, v.Max ) ) then
			return v.Index
		end
	end
	
	return 0
	
end

function GetPlayersInLocation( iIndex )

	local players = {}

	for _, ply in pairs( player.GetAll() ) do
		if ply:GetLocation() == iIndex then
			table.insert( players, ply )
		end
	end

	return players

end