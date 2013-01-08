surface.CreateFont( "ScoreboardVidTitle", { font = "Open Sans Condensed", size = 20, weight = 200 } )
surface.CreateFont( "ScoreboardVidDuration", { font = "Open Sans", size = 14, weight = 200 } )
surface.CreateFont( "ScoreboardVidVotes", { font = "Open Sans Condensed", size = 18, weight = 200 } )

local ADMIN = {}
ADMIN.TitleHeight = 64
ADMIN.VidHeight = 32 // 48

function ADMIN:Init()

	local Theater = LocalPlayer():GetTheater()

	self:SetZPos( 1 )
	self:SetSize( 256, 512 )
	self:SetPos( ScrW() - (256 + 8), ScrH() / 2 - ( self:GetTall() / 2 ) )

	local title = "ADMIN"
	if Theater and Theater:IsPrivate() and Theater:GetOwner() == LocalPlayer() then
		title = "OWNER"
	end

	self.Title = Label( title, self )
	self.Title:SetFont( "ScoreboardTitle" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.NextUpdate = 0.0

	self.Options = vgui.Create( "DPanelList", self )
	self.Options:DockMargin(0, self.TitleHeight + 2, 0, 0)
	self.Options:SetDrawBackground(false)
	self.Options:SetPadding( 4 )
	self.Options:SetSpacing( 4 )

	-- Skip the current video
	local VoteSkipButton = vgui.Create( "TheaterButton" )
	VoteSkipButton:SetText( "Skip" )
	VoteSkipButton.DoClick = function(self)
		RunConsoleCommand( "cinema_forceskip" )
	end
	self.Options:AddItem(VoteSkipButton)

	-- Seek
	local SeekButton = vgui.Create( "TheaterButton" )
	SeekButton:SetText( "Seek" )
	SeekButton.DoClick = function(self)

		Derma_StringRequest( "Enter the desired seek time in seconds", 
			"Time in seconds", 
			"0", 
			function( strTextOut ) RunConsoleCommand( "cinema_seek", strTextOut ) end,
			function( strTextOut ) end,
			"Seek", 
			"Cancel" )

	end
	self.Options:AddItem(SeekButton)

	-- Admin-only options
	if LocalPlayer():IsAdmin() then
		
		-- Reset the theater
		local ResetButton = vgui.Create( "TheaterButton" )
		ResetButton:SetText( "Reset" )
		ResetButton.DoClick = function(self)
			RunConsoleCommand( "cinema_reset" )
		end
		self.Options:AddItem(ResetButton)

	end

	-- Private theater options
	if Theater and Theater:IsPrivate() then

		local NameButton = vgui.Create( "TheaterButton" )
		NameButton:SetText( "Change Name" )
		NameButton.DoClick = function(self)
			Derma_StringRequest( "Set the name of the theater", 
				"Name of the theater", 
				Theater:Name(), 
				function( strTextOut ) RunConsoleCommand( "cinema_name", strTextOut ) end,
				function( strTextOut ) end,
				"Set Name", 
				"Cancel" )
		end
		self.Options:AddItem(NameButton)

		local LockButton = vgui.Create( "TheaterButton" )
		LockButton:SetText( "Toggle Queue Lock" )
		LockButton.DoClick = function(self)
			RunConsoleCommand( "cinema_lock" )
		end
		self.Options:AddItem(LockButton)

	end

end

function ADMIN:Update()

	local Theater = LocalPlayer():GetTheater() // get player's theater from their location
	if !Theater then return end

	-- Change title text
	if Theater:IsPrivate() and Theater:GetOwner() == LocalPlayer() then
		self.Title:SetText( "OWNER" )
	elseif LocalPlayer():IsAdmin() then
		self.Title:SetText( "ADMIN" )
	end

end

function ADMIN:Think()

	if CurTime() > self.NextUpdate then
		self:Update()
		self:InvalidateLayout()
		self.NextUpdate = CurTime() + 3.0
	end

end

local Background = Material( "theater/banner.png" )

function ADMIN:Paint( w, h )

	// Background
	surface.SetDrawColor( 26, 30, 38, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )

	// Title
	surface.SetDrawColor( 141, 38, 33, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self.Title:GetTall() )

	// Title Background
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Background )
	surface.DrawTexturedRect( 0, -1, 512, self.Title:GetTall() + 1 )

end

function ADMIN:PerformLayout()

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight )
	self.Title:CenterHorizontal()

	self.Options:Dock( FILL )
	self.Options:SizeToContents()

end

vgui.Register( "ScoreboardAdmin", ADMIN )