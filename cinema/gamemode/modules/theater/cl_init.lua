-- Increment Volume
control.Add( KEY_EQUAL, function( enabled )

	if enabled then
		
		local increment = 5
		local volume = math.Round( theater.GetVolume() / increment ) * increment

		RunConsoleCommand( "cinema_volume", volume + increment )

	end

end )

-- Decrement Volume
control.Add( KEY_MINUS, function( enabled )

	if enabled then
		
		local increment = 5
		local volume = math.Round( theater.GetVolume() / increment ) * increment

		RunConsoleCommand( "cinema_volume", volume - increment )

	end

end )

module( "theater", package.seeall )

LastVideo = nil -- Most recent video loaded
Fullscreen = false

NumVoteSkips = 0
ReqVoteSkips = 0

Panels = {}
Queue = {}

function RegisterPanel( Theater )

	Fullscreen = false

	-- There should only be one panel playing
	RemovePanels()

	local tw, th = Theater:GetSize()
	local scale = tw / th

	local h = GetConVar("cinema_resolution") and GetConVar("cinema_resolution"):GetInt() or 720


	local panel = vgui.Create( "TheaterHTML", vgui.GetWorldPanel(), "TheaterScreen" )
	panel:SetSize( h * scale, h )

	timer.Simple(0.5, function()
		if ValidPanel(panel) then
			local js = string.format( "theater.setVolume(%s);", GetVolume() )
			panel:QueueJavascript(js)

			if GetConVar("cinema_hd"):GetBool() then
				panel:QueueJavascript( "theater.enableHD();" )
			end
		end
	end)

	Panels[ Theater:GetLocation() ] = panel

	RefreshPanel()

	return panel

end

function ActivePanel()
	if !LocalPlayer().GetLocation then return end
	return Panels[ LocalPlayer():GetLocation() ]
end

function RefreshPanel( reload )

	local panel = ActivePanel()

	if ValidPanel(panel) then
		panel:SetPaintedManually(true)
		panel:SetScrollbars(false)
		panel:SetAllowLua(true)
		panel:SetKeyBoardInputEnabled(false)
		panel:SetMouseInputEnabled(false)
	end

	if reload then

		RemovePanels()
		LoadVideo( LastVideo )

	end
	
	ResizePanel()

end

function ResizePanel()
	
	local panel = ActivePanel()
	if !ValidPanel(panel) then return end
	
	local w, h = panel:GetSize()
	local scale = w/h

	local h2 = GetConVar("cinema_resolution"):GetInt()
	h2 = h2 and h2 or 720

	-- Adjust width based on new and old heights
	w = w * (h2/h)
	h = h2

	panel:SetSize(w, h)

end

function RemovePanels()

	-- Remove active panel
	local panel = ActivePanel()
	if ValidPanel(panel) then
		panel:Remove()
	end

	-- Remove any remaining panels that might exist
	for _, p in pairs( vgui.GetWorldPanel():GetChildren() ) do
		if ValidPanel(p) and p.ClassName == "TheaterHTML" then
			p:Remove()
		end
	end

	-- Remove any remaining panels that might exist
	for _, p in pairs( GetHUDPanel():GetChildren() ) do
		if ValidPanel(p) and p.ClassName == "TheaterHTML" then
			p:Remove()
		end
	end

	-- Remove admin panel between theater transitions
	if ValidPanel( GuiAdmin ) then
		GuiAdmin:Remove()
	end

	-- Remove theater drawing info
	LastTheater = nil

end
net.Receive( "PlayerLeaveTheater", RemovePanels )
hook.Add( "PreGamemodeLoaded", "RemoveAllPanels", theater.RemovePanels )

function CurrentVideo()
	return LastVideo
end

function ToggleFullscreen()
	
	local panel = ActivePanel()
	if !ValidPanel(panel) then return end

	-- Toggle fullscreen
	if Fullscreen then
		RefreshPanel()
	else
		panel:SetSize(ScrW(), ScrH())
		panel:ParentToHUD() -- Render before the HUD
	end

	Fullscreen = !Fullscreen
	LocalPlayer():Freeze(Fullscreen)

end

function GetQueue()
	if LocalPlayer():InTheater() then
		return Queue
	else
		return {}
	end
end

function GetVolume()
	return GetConVar("cinema_volume"):GetInt()
end

function SetVolume( fVolume )

	fVolume = tonumber(fVolume)
	if !fVolume then return end

	for _, p in pairs(Panels) do
		if ValidPanel(p) then
			p:QueueJavascript(string.format('theater.setVolume(%s)', GetVolume()))
		end
	end

	LastInfoDraw = CurTime()

end

function PollServer()

	-- Prevent spamming requests
	if LocalPlayer().LastTheaterRequest and LocalPlayer().LastTheaterRequest + 1 > CurTime() then
		return
	end

	net.Start("TheaterInfo")
	net.SendToServer()

	LocalPlayer().LastTheaterRequest = CurTime()

end

function ReceiveVideo()

	LastTheater = nil -- see cl_draw.lua

	local info = {}
	info.Type = net.ReadString()
	info.Data = net.ReadString()
	info.Title = net.ReadString()

	if IsVideoTimed(info.Type) then
		info.StartTime = net.ReadFloat()
		info.Duration = net.ReadInt(32)
	end

	local Video = VIDEO:Init(info)
	LoadVideo( Video )

	-- Private theater owner
	local Theater = LocalPlayer():GetTheater()
	if Theater then

		Theater:SetVideo( Video )

		if Theater:IsPrivate() then
			local owner = net.ReadEntity()
			if IsValid( owner ) then
				Theater._Owner = owner
			end
		end
		
	end
	
	NumVoteSkips = 0
	LastInfoDraw = CurTime()

end
net.Receive( "TheaterVideo", ReceiveVideo )

function ReceiveSeek()

	local seconds = net.ReadFloat()

	local panel = ActivePanel()
	local Video = CurrentVideo()
	local Theater = LocalPlayer():GetTheater()

	if !ValidPanel(panel) or !Video or !Theater then return end

	Video._VideoStart = seconds
	Theater._VideoStart = seconds
	panel:QueueJavascript( string.format( 'theater.seek(%s)', CurTime() - seconds ) )

end

net.Receive( "TheaterSeek", ReceiveSeek )

function ReceiveTheaters()

	table.Empty( Theaters )

	local tbl = net.ReadTable()

	local Theater = nil
	for _, v in pairs( tbl ) do

		-- Merge shared theater data
		local loc = Location.GetLocationByIndex( v.Location )
		if loc and loc.Theater then
			v = table.Merge( loc.Theater, v )
		end

		Theater = THEATER:Init(v.Location, v)

		if Theater:IsPrivate() and v.Owner then
			Theater._Owner = v.Owner
		end

		Theaters[v.Location] = Theater

	end

	if ValidPanel( Gui ) and ValidPanel( Gui.TheaterList ) then
		Gui.TheaterList:UpdateList()
	end

end
net.Receive( "TheaterInfo", ReceiveTheaters )

function ReceiveQueue()

	table.Empty( Queue )

	local queue = net.ReadTable()
	for _, v in pairs(queue) do
		table.insert(Queue, v)
	end

	if ValidPanel( GuiQueue ) then
		GuiQueue:UpdateList()
	end

end
net.Receive( "TheaterQueue", ReceiveQueue )

function ReceiveVoteSkips()

	local name = net.ReadString()
	local skips = net.ReadInt(7)
	local required = net.ReadInt(7)

	local str = string.format( "%s has voted to skip (%s/%s)", name, skips, required )
	AddAnnouncement( str )

	NumVoteSkips = skips
	ReqVoteSkips = required

end
net.Receive( "TheaterVoteSkips", ReceiveVoteSkips )

function LoadVideo( Video )

	if !Video then return end

	local theaterUrl = GetConVarString( "cinema_url" )

	local panel = ActivePanel()
	if !ValidPanel( panel ) then

		-- Initialize HTML panel
		local Theater = LocalPlayer():GetTheater()
		if !Theater then return end
		
		-- Initialize panel and load the webpage
		panel = RegisterPanel( Theater )

		if Video:Type() != "url" then
			panel:OpenURL( theaterUrl )
		end

	end

	if Video:Type() == "url" then
		panel:OpenURL( Video:Data() )
	elseif panel.URL != theaterUrl then
		panel:OpenURL( theaterUrl )
	end

	local startTime = CurTime() - Video:StartTime()

	-- Set the volume before playing anything
	local str = string.format( "theater.setVolume(%s)", GetVolume() )
	panel:QueueJavascript( str )

	-- Let the webpage handle loading a video
	str = string.format( "theater.loadVideo( '%s', '%s', %s );", Video:Type(), Video:Data(), startTime )
	panel:QueueJavascript( str )

	-- Keep previous video for refreshing the theater
	LastVideo = Video

	Msg("Loaded Video\n")
	Msg("\tType:\t"..tostring(Video:Type()).."\n")
	Msg("\tData:\t"..tostring(Video:Data()).."\n")
	Msg("\tTime:\t"..tostring(startTime).."\n")
	Msg("\tDur:\t"..tostring(Video:Duration()).."\n")

end