util.AddNetworkString( "PlayerEnterTheater" )
util.AddNetworkString( "PlayerLeaveTheater" )
util.AddNetworkString( "PlayerVideoQueued" )
util.AddNetworkString( "TheaterVideo" )
util.AddNetworkString( "TheaterInfo" )
util.AddNetworkString( "TheaterQueue" )
util.AddNetworkString( "TheaterSeek" )
util.AddNetworkString( "TheaterVoteSkips" )
util.AddNetworkString( "TheaterAnnouncement" )

module( "theater", package.seeall )

function Initialize()

	game.CleanUpMap()

	-- Make sure we can depends on the Location module
	if !Location then
		return Error("Location module not found! Theaters can't be initialized.\n")
	end

	-- Get the map locations
	local locations = Location.GetLocations()
	if !locations then return end

	for name, loc in pairs(locations) do
		GetByLocation( loc.Index, true )
	end

end
hook.Add( "InitPostEntity", "InitTheaters", Initialize )
hook.Add( "OnReloaded", "ReInitTheaters", Initialize )

function PlayerJoin( ply, locId )

	local Theater = GetByLocation(locId, true)
	if !Theater then return end
	
	Theater:AddPlayer(ply)

end

function PlayerLeave( ply, locId )

	if !locId then
		locId = ply:GetLocation()
	end

	local Theater = GetByLocation(locId)
	if !Theater then return end

	Theater:RemovePlayer(ply)

end
hook.Add( "PlayerDisconnected", "TheaterDisconnected", PlayerLeave )

function RequestTheaterInfo( ply, force )

	if !IsValid(ply) then return end

	-- Prevent spamming requests
	if !force and ply.LastTheaterRequest and ply.LastTheaterRequest + 1 > CurTime() then
		return
	end

	-- Grab theater information
	local info = {}
	local th = nil
	for _, Theater in pairs( GetTheaters() ) do
		
		-- Theater is set to not broadcast
		if !Theater:IsReplicated() and Theater != ply:GetTheater() then
			continue
		end

		th = {
			Location = Theater:GetLocation(),
			Name = Theater:Name(),
			Pos = Theater:GetPos(),
			Ang = Theater:GetAngles(),
			Flags = Theater:GetFlags(),
			Type = Theater:VideoType(),
			Data = Theater:VideoData(),
			Title = Theater:VideoTitle(),
			Duration = Theater:VideoDuration(),
			StartTime = Theater:VideoStartTime()
		}

		th.Width, th.Height = Theater:GetSize()

		if Theater:IsPrivate() then
			th.Owner = Theater:GetOwner()
		end

		table.insert(info, th)

	end

	if #info > 0 then
		net.Start("TheaterInfo")
			net.WriteTable(info)
		net.Send(ply)
	end

	-- If the player is currently in a theater, also
	-- send the queue information
	local queue = {}
	local Theater = ply:GetTheater()
	if Theater then
		for _, vid in pairs( Theater:GetQueue() ) do
			-- Queued video information
			local item = {
				Id = vid.id,
				Title = vid:Title(),
				Duration = vid:Duration(),
				Votes = vid:GetNumVotes()
			}

			-- Send the player's vote value if they have voted
			local vote = vid:GetVoteByPlayer(ply)
			if vote then
				item.Value = vote.value
			end

			-- Send whether they're the owner of the video
			if vid:GetOwner() == ply then
				item.Owner = true
			end

			table.insert(queue, item)
		end
	end

	if Theater then
		net.Start("TheaterQueue")
			net.WriteTable(queue)
		net.Send(ply)
	end

	ply.LastTheaterRequest = CurTime()

end
net.Receive("TheaterInfo", function(len, ply)
	theater.RequestTheaterInfo(ply)
end)

function GetVideoInfo( data, Type, onSuccess, onFailure )
	
	if !data or !Type then return end

	local service = Services[ Type ]
	if service then
		service:GetVideoInfo( data, onSuccess, onFailure )
	else
		return pcall(onFailure, 404)
	end

end