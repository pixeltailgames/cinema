module( "theater", package.seeall )

VIDEO = {}

function VIDEO:Init( info, ply )

	local o = {}
	
	setmetatable( o, self )
	self.__index = self
	
	if SERVER then
		o.id = -1 			-- set by theater
		o.theaterId = -1 	-- set by theater

		o._RequestTime = CurTime()
		o._Owner = ply
		o._OwnerName = IsValid(ply) and ply:Nick() or "" -- in case they disconnect
		o._OwnerSteamID = IsValid(ply) and ply:SteamID() or ""

		o._Votes = {}

		o:AddVote(ply, true)
	else
		o._OwnerName = info.OwnerName
		o._OwnerSteamID = info.OwnerSteamID
	end


	o._VideoType = info.Type or ""
	o._VideoData = info.Data or ""
	o._VideoStart = info.StartTime or 0

	o._VideoTitle = string.gsub(info.Title or "(Unknown)", '%%', '%%%%')
	o._VideoDuration = info.Duration or 0
	o._VideoThumbnail = info.Thumbnail or ""

	return o

end

function VIDEO:Type()
	return self._VideoType
end

function VIDEO:Data()
	return self._VideoData
end

function VIDEO:Title()
	return self._VideoTitle
end

function VIDEO:Duration()
	return self._VideoDuration
end

function VIDEO:StartTime()
	return self._VideoStart
end

function VIDEO:Thumbnail()
	return self._VideoThumbnail
end

/*
	Owner
*/
function VIDEO:GetOwner()
	return self._Owner
end

function VIDEO:GetOwnerName()
	if IsValid(self:GetOwner()) then
		return self:GetOwner():Nick()
	else
		return self._OwnerName
	end
end

function VIDEO:GetOwnerSteamID()
	if IsValid(self:GetOwner()) then
		return self:GetOwner():SteamID()
	else
		return self._OwnerSteamID
	end
end

if SERVER then

	function VIDEO:RequestTime()
		return self._RequestTime
	end
	
	/*
		Votes
	*/
	function VIDEO:GetVotes()
		return self._Votes
	end

	function VIDEO:GetNumVotes()
		self:ValidateVotes()
		local count = 0
		for _, vote in pairs(self._Votes) do
			count = count + vote.value
		end
		return count
	end

	function VIDEO:ValidateVotes()
		for k, v in pairs(self._Votes) do
			if !IsValid(v.owner) then
				table.remove(self._Votes, k)
			else
				-- Make sure the player is still in the theater
				if !v.owner:InTheater() or v.owner:GetLocation() != self.theaterId then
					table.remove(self._Votes, k)
				end
			end
		end
	end

	function VIDEO:RemoveVoteByPlayer(ply)
		for k, v in pairs(self._Votes) do
			if v.owner == ply then
				table.remove(self._Votes, k)
				break
			end
		end
	end

	function VIDEO:GetVoteByPlayer(ply)
		for _, vote in pairs(self._Votes) do
			if vote.owner == ply then
				return vote
			end
		end
	end

	function VIDEO:HasPlayerVoted(ply)
		return self:GetVoteByPlayer(ply) != nil
	end

	function VIDEO:AddVote( ply, positive )

		if !IsValid(ply) then return end

		local vote = self:GetVoteByPlayer(ply)

		if vote then
			
			if (vote.value > 0 and positive) or (vote.value < 0 and !positive) then
				self:RemoveVoteByPlayer(ply)
			else
				vote.value = positive and 1 or -1
			end

		else

			table.insert(self._Votes, {
				owner = ply,
				value = positive and 1 or -1
			})

		end

	end

	/*
		
	*/
	function VIDEO:RequestInfo( callback )

		if !callback then return end

		if self:Type() != "" then

			-- Query info from local database
			local results = GetVideoLog(self:Data(), self:Type())
			if results != nil and istable(results) then

				results = results[1]

				self._VideoTitle = results.title or "(Unknown)"
				self._VideoDuration = tonumber(results.duration) or -1
				self._VideoThumbnail = results.thumbnail or ""

				callback(true)

			else

				local function loadFailure(code)
					if type(code) == 'string' then
						callback(code)
					else
						callback(false)
					end
				end

				-- Query info from API
				local status, err = pcall( GetVideoInfo, self:Data(), self:Type(), function(info)
					self._VideoTitle = url.htmlentities_decode(info.title) or "(Unknown)"
					self._VideoDuration = tonumber(info.duration) or -1
					self._VideoThumbnail = info.thumbnail or ""

					if info.data then
						self._VideoData = info.data
					end

					if info.type then
						self._VideoType = info.type
					end

					-- Problem grabbing duration data
					if IsVideoTimed(self:Type()) and self._VideoDuration <= 0 then
						return callback(false)		
					end

					callback(true)
				end, loadFailure)

				-- Something went wrong while grabbing the video info
				if !status then
					callback(false)
				end

			end

		else
			callback(false)
		end

	end

end
