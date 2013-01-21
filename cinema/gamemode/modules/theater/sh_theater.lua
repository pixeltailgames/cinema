module( "theater", package.seeall )

THEATER = {}

function THEATER:Init( locId, info )

	local o = {}
	
	setmetatable( o, self )
	self.__index = self
	
	o.Id = locId -- Location ID
	o._Name = info.Name or "Theater"
	o._Flags = info.Flags or THEATER_NONE
	o._Pos = info.Pos or Vector(0,0,0)
	o._Ang = info.Ang or Angle(0,0,0)

	o._Width = info.Width or 128
	o._Height = info.Height or math.Round(o._Width * (9/16))

	if SERVER then

		-- Keep for resetting the theater
		o._OriginalName = o._Name

		-- Convert from hammer units (x10 for render scale)
		o._Width = o._Width * 10
		o._Height = o._Height * 10

		o.Players = {}
		o.Playlist = {}

		o._Video = nil

		if info.ThumbEnt then
			o:SetupThumbnailEntity( info.ThumbEnt )
		elseif info.ThumbInfo then
			o._ThumbInfo = info.ThumbInfo
			o:SetupThumbnailEntity()
		end

		o._Queue = {}
		o._QueueCount = 0

		o._SkipVotes = {}

		o._Finished = true

		if o:IsPrivate() then
			o._QueueLocked = false
			o._Owner = nil
		end

		o:PlayDefault()

	else

		info.Title = info.Title or "No video playing"
		o._Video = VIDEO:Init( info )

	end

	return o

end

function THEATER:Name()
	return self._Name
end

function THEATER:GetLocation()
	return self.Id
end

function THEATER:GetFlags()
	return tonumber(self._Flags) or -1
end

function THEATER:GetPos()
	return self._Pos
end

function THEATER:GetAngles()
	return self._Ang
end

function THEATER:GetSize()
	return self._Width, self._Height
end

/*
	Attributes
*/
function THEATER:IsPrivate()
	return bit.band(self._Flags, THEATER_PRIVATE) == THEATER_PRIVATE
end

function THEATER:IsPrivileged()
	return bit.band(self._Flags, THEATER_PRIVILEGED) == THEATER_PRIVILEGED
end

function THEATER:IsReplicated()
	return bit.band(self._Flags, THEATER_REPLICATED) == THEATER_REPLICATED
end

/*
	Video
*/
function THEATER:SetVideo( Video )

	if !Video then return end

	self._Video = Video

	if SERVER then

		self._Video._VideoStart = (CurTime() - Video:StartTime()) + 1

		if IsValid( self._ThumbEnt ) then
			self._ThumbEnt:SetTitle( Video:Title() )
			self._ThumbEnt:SetThumbnail( Video:Thumbnail() )
		end

		self:SendVideo()

	end

end

function THEATER:IsPlaying()
	if self:VideoType() == "" then
		return false
	elseif IsVideoTimed( self:VideoType() ) then
		return self:VideoDuration() > 0 and
			self:VideoCurrentTime() <= self:VideoDuration() + 1
	else
		return true -- Video not timed
	end
end

function THEATER:VideoType()
	return self._Video and self._Video:Type() or ""
end

function THEATER:VideoData()
	return self._Video and self._Video:Data() or ""
end

function THEATER:VideoCurrentTime( clean )
	if clean then
		return math.Clamp(math.Round(CurTime() - self:VideoStartTime()), 0, self:VideoDuration())
	else
		return CurTime() - self:VideoStartTime()
	end
end

function THEATER:VideoDuration()
	return self._Video and self._Video:Duration() or 0
end

function THEATER:VideoTime()

	if !self:IsPlaying() or !IsVideoTimed(self:VideoType()) then
		return ""
	end

	return string.FormatSeconds(self:VideoCurrentTime(true)) .. " / " .. string.FormatSeconds(self:VideoDuration())

end

function THEATER:VideoTitle()
	return self._Video and self._Video:Title() or "No video playing"
end

function THEATER:VideoStartTime()
	return self._Video and self._Video:StartTime() or 0
end

/*
	Private Theater
*/
function THEATER:GetOwner()
	return self._Owner
end

function THEATER:Think()

	if self.NextThink and self.NextThink > CurTime() then
		return
	end

	if SERVER then

		if !self:IsPlaying() and !self._Finished then
			self:OnFinishedPlaying()
		end

	else

		if LocalPlayer():GetLocation() != self:GetLocation() then return end

		-- Synchronize clientside video playback
		if self:IsPlaying() and IsVideoTimed( self:VideoType() ) and
			( !self.NextSync || self.NextSync < RealTime() ) then

			local time = self:VideoCurrentTime()
			local panel = ActivePanel()
			if time > 5 and ValidPanel(panel) then

				local str = string.format( "theater.sync(%s)", time )
				panel:QueueJavascript( str )

				self.NextSync = RealTime() + 5

			end

		end

	end

	self.NextThink = CurTime() + 1

end

if SERVER then

	function THEATER:Reset()

		self._Name = self._OriginalName

		self:ClearQueue()
		self:ClearSkipVotes()
		self:SetupThumbnailEntity()

		if self:IsPrivate() then
			self._QueueLocked = false
			self._Owner = nil
		end

		self:PlayDefault()

	end

	/*
		Thumbnail Entity
	*/
	function THEATER:SetupThumbnailEntity( ent )
		
		if !IsValid( self._ThumbEnt ) then

			if IsValid( ent ) then
				self._ThumbEnt = ent
			elseif self._ThumbInfo then
				self._ThumbEnt = ents.Create( "theater_thumbnail" )
				self._ThumbEnt:SetPos( self._ThumbInfo.Pos )
				self._ThumbEnt:SetAngles( self._ThumbInfo.Ang )
				self._ThumbEnt:Spawn()
			else
				return
			end

		end

		self:SyncThumbnail()

	end

	function THEATER:SyncThumbnail()

		if !IsValid( self._ThumbEnt ) then return end

		self._ThumbEnt:SetTheaterName( self:Name() )
		self._ThumbEnt:SetTitle( self:VideoTitle() )

	end

	/*
		Video Playback
	*/
	function THEATER:OnFinishedPlaying()
		self._Finished = true
		self:NextVideo()
	end

	function THEATER:PlayDefault()

		local info = {
			Type 		= "",
			Data 		= "",
			StartTime 	= 0,
			Duration 	= 0,
			Title 		= "No video playing"
		}

		self:SetVideo( VIDEO:Init(info) )
		self:SendVideo()

	end

	function THEATER:NextVideo()

		self:ClearSkipVotes()
		
		if !self:IsQueueEmpty() then

			local key
			local Video

			-- Get queued video with the most votes
			for k, vid in pairs(self._Queue) do
				if !Video or vid:GetNumVotes() > Video:GetNumVotes() then
					Video = vid
					key = k
				end
			end
			table.remove(self._Queue, key)

			self:SetVideo( Video )

			if Video:GetOwnerName() != "" then
				self:AnnounceToPlayers( {
					ColDefault,
					"Current video requested by ",
					ColHighlight,
					Video:GetOwnerName(),
					" (" .. Video:GetOwnerSteamID() .. ")",
					ColDefault,
					"."
				} )
			end

			self._Finished = false

		else

			self:PlayDefault()

		end

	end

	function THEATER:RequestVideo( ply, url, force )

		-- Prevent request spam
		if IsValid(ply) and ply.LastVideoRequest and ply.LastVideoRequest + 0.3 > CurTime() then
			return
		end

		if self:IsPrivate() then

			-- Set new theater owner
			if !IsValid( self:GetOwner() ) then
				self:RequestOwner( ply )
			end

			-- Prevent requests from non-theater-owner if queue is locked
			if self:IsQueueLocked() and ply != self:GetOwner() then
				return self:AnnounceToPlayer( ply, "The owner of the theater has locked the queue." )
			end

		end

		local info = ExtractURLData( url, self )

		-- Invalid request data
		if !info then
			return self:AnnounceToPlayer( ply, "Invalid video request." )
		end

		-- Check for duplicate requests
		for _, vid in pairs(self:GetQueue()) do

			if vid:Type() == info.Type and
				vid:Data() == info.Data then

				-- Place vote for player
				vid:AddVote(ply, true)

				self:AnnounceToPlayer( ply, "The requested video is already in the queue." )

				return
			end

		end

		local service = GetServiceByClass( info.Type )
		if service then
			local msg = {
				ColDefault,
				"Processing ",
				ColHighlight,
				service:GetName(),
				ColDefault,
				" request..."
			}
			self:AnnounceToPlayer( ply, msg )
		end

		-- Create video object and check if the page is valid
		local vid = VIDEO:Init(info, ply)
		vid:RequestInfo( function( success ) 

			-- Failed to grab video info, etc.
			if !success then
				self:AnnounceToPlayer( ply, "There was a problem processing the requested video." )
				return
			elseif type(success) == 'string' then -- failure message
				self:AnnounceToPlayer( ply, success )
				return
			end

			-- Developers can decide whether or not the video should be queued
			if !hook.Run( "PreVideoQueued", vid, self ) then return end

			-- Successful request, queue video
			self:QueueVideo( vid )

			-- Send video info to player who requested the video
			-- Used to store request history
			net.Start("PlayerVideoQueued")
				net.WriteString( url )
				net.WriteString( vid:Title() )
				net.WriteInt( vid:Duration(), 32 )
			net.Send(ply)

			self:CheckVoteSkip()

			-- Start video in the case no other video is playing
			self._Finished = false

			-- Used for logging video requests
			hook.Run( "PostVideoQueued", vid, self )

		end )

		if IsValid(ply) then
			ply.LastVideoRequest = CurTime()
		end
		
	end

	function THEATER:Seek( seconds )

		if !IsVideoTimed(self:VideoType()) then return end

		-- Clamp video seek time between 0 and video duration
		seconds = math.Clamp(seconds, 0, self:VideoDuration())

		-- Convert seek seconds to time after video start
		if self._Video then
			self._Video._VideoStart = CurTime() - seconds
		end

		net.Start("TheaterSeek")
			net.WriteFloat( self:VideoStartTime() )
		net.Send(self.Players)

	end

	function THEATER:SendVideo( ply )

		-- Remove player if they aren't valid
		if ply and !IsValid(ply) then
			self:RemovePlayer(ply)
			return
		end

		-- Delay for networking latency
		timer.Simple( 0.1, function() 

			if !self then return end

			net.Start("TheaterVideo")

				net.WriteString( self:VideoType() )
				net.WriteString( self:VideoData() )
				net.WriteString( self:VideoTitle() )

				-- Timed video information
				if IsVideoTimed(self:VideoType()) then
					net.WriteFloat( self:VideoStartTime() )
					net.WriteInt( self:VideoDuration(), 32 )
				end

				-- Private theater owner
				if self:IsPrivate() then
					net.WriteEntity( self:GetOwner() )
				end

			net.Send(ply or self.Players) -- sent to specific player if specified

		end )
		
	end

	/*
		Queue
	*/
	function THEATER:GetQueue()
		return self._Queue
	end

	function THEATER:ClearQueue()
		if !self._Queue then return end
		table.Empty(self._Queue)
		self._QueueCount = 0
	end

	function THEATER:IsQueueEmpty()
		return table.Count(self._Queue) == 0
	end

	function THEATER:QueueVideo( video )
		video.id = self._QueueCount
		video.theaterId = self.Id
		table.insert(self._Queue, video)
		self._QueueCount = self._QueueCount + 1
	end

	function THEATER:VoteQueuedVideo( ply, id, positive )

		if !IsValid(ply) or !id then return end

		for _, vid in pairs(self._Queue) do
			if vid.id == id then
				vid:AddVote(ply, positive)
				break
			end
		end

	end

	function THEATER:RemoveQueuedVideo( ply, id )

		id = tonumber(id)
		if !IsValid(ply) or !id then return end

		for k, vid in pairs(self._Queue) do
			if vid.id == id then

				-- Remove video if player is video owner, theater owner, or an admin
				if (vid:GetOwner() == ply) or
					(self:GetOwner() == ply) or -- private theater
					ply:IsAdmin() then
					
					table.remove(self._Queue, k)

				end

				break

			end
		end

	end

	/*
		Vote Skip
	*/
	function THEATER:SkipVideo()
		self:NextVideo()
	end

	function THEATER:NumVoteSkips()
		return table.Count(self._SkipVotes)
	end

	function THEATER:NumRequiredVoteSkips()

		local ratio = math.Clamp( GetConVar("cinema_skip_ratio"):GetFloat() or 2/3, 0, 1 )

		local numply = self:NumPlayers()
		if numply == 1 then
			return 1
		elseif numply > 0 and numply < 3 then
			return 2 -- prevent players from walking in private theaters and skipping
		else
			return math.Round( self:NumPlayers() * ratio )
		end

	end

	function THEATER:ClearSkipVotes()
		if !self._SkipVotes then return end
		table.Empty(self._SkipVotes)
	end

	function THEATER:ValidateSkipVotes()
		for k, ply in pairs(self._SkipVotes) do
			if !IsValid(ply) then
				table.remove(k)
			end
		end	
	end

	function THEATER:HasPlayerVotedToSkip( ply )
		return table.HasValue(self._SkipVotes, ply)
	end

	function THEATER:VoteSkip( ply )

		-- Can't vote skip if the queue is locked
		if self:IsQueueLocked() then return end

		-- Can't vote skip if a video isn't playing
		if !self:IsPlaying() then return end

		-- Validate vote skips before checking them
		self:ValidateSkipVotes()

		-- Ensure the player hasn't already voted
		if self:HasPlayerVotedToSkip(ply) then return end

		-- Insert player into list of vote skips
		table.insert(self._SkipVotes, ply)

		-- Notify theater players of vote skip
		net.Start( "TheaterVoteSkips" )
			net.WriteString( ply:Nick() )
			net.WriteInt( self:NumVoteSkips(), 7 ) -- 128 max players
			net.WriteInt( self:NumRequiredVoteSkips(), 7 )
		net.Send( self.Players )

		-- Check if the current video can be skipped
		self:CheckVoteSkip()

	end

	function THEATER:CheckVoteSkip()

		-- Can't skip if the queue is locked
		if self:IsQueueLocked() then return end

		-- Skip the current video if the voteskip requirement is met
		if self:NumVoteSkips() >= self:NumRequiredVoteSkips() then
			self:SkipVideo()
			local msg = {
				theater.ColDefault,
				"The current video has been voteskipped."
			}
			
			self:AnnounceToPlayers( msg )
		end

	end


	/*
		Players
	*/
	function THEATER:NumPlayers()
		return table.Count(self.Players)
	end

	function THEATER:HasPlayer( ply )
		return table.HasValue(self.Players, ply)
	end

	function THEATER:AddPlayer( ply )

		-- Don't bother if the player is already in the list
		if self:HasPlayer( ply ) then return end

		-- Add the player to the list
		table.insert(self.Players, ply)

		-- Send theater info
		RequestTheaterInfo(ply, true)

		-- Send current video
		self:SendVideo(ply)

		-- Disable the player's flashlight
		if ply:FlashlightIsOn() then
			ply:Flashlight(false)
		end

	end

	function THEATER:RemovePlayer( ply )

		-- Don't bother if the player isn't in the list
		if !self:HasPlayer( ply ) then return end

		-- Remove player from list
		table.RemoveByValue(self.Players, ply)

		-- Notify player of leaving the theater
		net.Start("PlayerLeaveTheater")
		net.Send(ply)

		-- Owner leaving private theater
		if self:IsPrivate() and ply == self:GetOwner() then
			self:ResetOwner()
			self:AnnounceToPlayer( ply, "You have lost theater ownership due to leaving the theater." )
		end

		-- Players remain in the theater
		if self:NumPlayers() > 0 then

			self:CheckVoteSkip()

		-- No player remain in the theater
		else
			-- Reset private theaters (and public if allowed)
			if self:IsPrivate() or GetConVar("cinema_allow_reset"):GetBool() then
				self:Reset()
			end
		end

	end

	function THEATER:AnnounceToPlayers( tbl )
		self:AnnounceToPlayer( self.Players, tbl )
	end

	function THEATER:AnnounceToPlayer( ply, tbl )

		-- Single message without coloring
		if type(tbl) == 'string' then
			tbl = { ColDefault, tbl }
		end

		-- Send announcement to all players or a single player
		if type(ply) == 'table' or IsValid(ply) then
			net.Start( "TheaterAnnouncement" )
				net.WriteTable( tbl )
			net.Send(ply)
		end

	end

	/*
		Private Theater
	*/
	function THEATER:ResetOwner()
		self._Owner = nil
		self._QueueLocked = false
	end

	function THEATER:RequestOwner( ply )

		if !IsValid( ply ) then return end
		if IsValid( self:GetOwner() ) then return end

		self._Owner = ply
		self:AnnounceToPlayer( ply, "You're now the owner of the private theater." )

		RequestTheaterInfo(ply)

	end

	function THEATER:IsQueueLocked()
		return self._QueueLocked
	end

	function THEATER:ToggleQueueLock( ply )

		if !IsValid(ply) then return end

		-- Toggle theater queue lock
		self._QueueLocked = !self._QueueLocked

		-- Notify theater players of change
		local text = nil
		if self:IsQueueLocked() then
			text = " has locked the theater queue."
		else
			text = " has unlocked the theater queue."
		end

		self:AnnounceToPlayers( {
			ColHighlight,
			ply:Nick(),
			ColDefault,
			text
		} )

	end

	function THEATER:SetName( name, ply )

		if !IsValid(ply) then return end

		-- Theater must be private and player must be the owner
		if !self:IsPrivate() or ply != self:GetOwner() then return end

		-- Clamp new name to 32 chars
		self._Name = string.sub(name,0,32)
		self:SyncThumbnail()

	end

end
