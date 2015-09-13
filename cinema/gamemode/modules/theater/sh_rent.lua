module( "theater", package.seeall )

function RentTimeToString(Length)
	local Length = tonumber(Length)
	if !Length or Length == "" or Length < 0 then
		return "--:--:--"
	end
	local nSeconds = Length
	nHours = string.format("%02.f", math.floor(nSeconds/3600))
	nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)))
	nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60))
	return nHours..":"..nMins..":"..nSecs
end

CreateConVar("cinema_rentables", 0, {FCVAR_ARCHIVE, FCVAR_DONTRECORD, FCVAR_REPLICATED}, "Enables the Optional Rentable System (PointShop or PointShop 2 required!)")
CreateConVar("cinema_rentables_cost", 12, {FCVAR_ARCHIVE, FCVAR_DONTRECORD, FCVAR_REPLICATED}, "Sets the Point Cost of a Private Theater per Minute. (def. 12)")

local PLAYER = FindMetaTable("Player")
if PS or Pointshop2 then -- PointShop (2) is available for usage!
	if PS and Pointshop2 then -- Both are installed?!
		if SERVER then
			hook.Add("InitPostEntity", "CheckRentableSystemStatus", function()
				if GetConVar("cinema_rentables"):GetBool() then RunConsoleCommand("cinema_rentables", 0) end
				ErrorNoHalt("Two versions of PointShop are installed! Please remove one!")
			end)
			cvars.AddChangeCallback("cinema_rentables", function(cmd, old, new)
				if tonumber(new) >= 1 then
					RunConsoleCommand("cinema_rentables", 0)
					ErrorNoHalt("You can't use the Rentable Theater System with 2 versions of PointShop installed!")
				end
			end)
		end
		return
	elseif PS then
		function PLAYER:GetPoints()
			return self:PS_GetPoints()
		end
	elseif Pointshop2 then
		function PLAYER:GetPoints()
			return self.PS2_Wallet.points
		end
	end
else
	if SERVER then
		hook.Add("InitPostEntity", "CheckRentableSystemStatus", function()
			if GetConVar("cinema_rentables"):GetBool() then RunConsoleCommand("cinema_rentables", 0) end
		end)
		cvars.AddChangeCallback("cinema_rentables", function(cmd, old, new)
			if tonumber(new) >= 1 then
				RunConsoleCommand("cinema_rentables", 0)
				ErrorNoHalt("You can't use the Rentable Theater System without PointShop or PointShop 2 installed!")
			end
		end)
	end
	return
end

if SERVER then
	if PS then
		function PLAYER:TakePoints(amount)
			return self:PS_TakePoints(math.Round(amount))
		end
	elseif Pointshop2 then
		function PLAYER:TakePoints(amount)
			return Pointshop2Controller:updatePlayerWallet( self.kPlayerId, "points", self.PS2_Wallet.points - math.Round(amount) ) -- You have got to be joking...
		end
	end

	cvars.AddChangeCallback("cinema_rentables", function(cmd, old, new) -- Workaround for Missing/Incorrect Rent Info upon ConVar change
		for _, th in pairs(theater.GetTheaters()) do
			th:SyncThumbnail()
		end
	end)

	local RentCost = GetConVar("cinema_rentables_cost"):GetInt() -- Cost in Points per Minute of Rent (default for PS is 10 points for every 60 seconds spent on the server)
	concommand.Add("cinema_rent",function(ply,cmd,args)
		if !GetConVar("cinema_rentables"):GetBool() then
			Room:AnnounceToPlayer( ply, 'Theater_RentablesNotEnabled' )
			return
		end

		local Room = ply:GetTheater()
		local RentSeconds = tonumber(args[1]) or 0
		local RentMinutes = RentSeconds/60

		if RentMinutes < 10 then
			Room:AnnounceToPlayer( ply, 'Theater_RentLessThan10Minutes' )
			return
		end

		if Room and Room:IsPrivate() and !Room:IsPrivileged() then
			if !Room:GetOwner() then
				if ply:GetPoints() >= RentMinutes*RentCost then
					if ply.RentedTheater then
						Room:AnnounceToPlayer( ply, 'Theater_RentMoreThanOne' )
						return
					end
					
					Room:SetRentInfo(CurTime(), RentSeconds, ply)
					Room:AnnounceToPlayer( ply, {'Theater_RentedFor', RentTimeToString(RentSeconds)} )
					ply:TakePoints(RentMinutes*RentCost)
				else
					Room:AnnounceToPlayer( ply, 'Theater_RentNotEnoughPoints' )
				end
			else
				if Room:GetOwner() == ply then
					local TotalTime = (Room:GetRentStart() + Room:GetRentTime()) - CurTime() -- Figure out how much time would be left after adding specified
					RentSeconds = math.Clamp(TotalTime + RentSeconds, 0, 7200) -- Max 2 Hours of Rent at any time
					RentSeconds = RentSeconds - TotalTime
					RentMinutes = RentSeconds/60
					if RentMinutes > 0 and ply:GetPoints() >= RentMinutes*RentCost then
						if RentMinutes*RentCost < 1 then
							return
						end
						
						Room:SetRentInfo(Room:GetRentStart(), Room:GetRentTime() + RentSeconds, ply)
						ply:TakePoints(RentMinutes*RentCost)
						TotalTime = (Room:GetRentStart() + Room:GetRentTime()) - CurTime()
						Room:AnnounceToPlayer( ply, { 'Theater_AddedRentTime', RentTimeToString(RentSeconds)} )
					end
				else
					Room:AnnounceToPlayer( ply, 'Theater_InvalidRentOwner' )
				end
			end
		end
	end)

	hook.Add("PlayerInitialSpawn", "FixCinemaRentableOwnership", function(ply)
		if !GetConVar("cinema_rentables"):GetBool() then return end
		
		while IsValid(ply) do -- Wait until the player entity is ready
			for _, Room in pairs(theater.GetTheaters()) do
				if (Room._OwnerSteamID == ply:SteamID()) then
					Room:RequestOwner(ply)
					Room:AnnounceToPlayer( ply, {'Theater_ReacquiredOwnership', Room:Name(), RentTimeToString((Room:GetRentStart() + Room:GetRentTime()) - CurTime())} )
				end
			end
			break
		end
	end)
end
