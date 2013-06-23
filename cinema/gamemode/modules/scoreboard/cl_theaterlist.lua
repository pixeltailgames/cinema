surface.CreateFont( "ScoreboardTheaterName", { font = "Open Sans Condensed Light", size = 30, weight = 100 } )
surface.CreateFont( "ScoreboardTheaterTime", { font = "Open Sans Condensed Bold", size = 16, weight = 600 } )
surface.CreateFont( "ScoreboardTheaterVideo", { font = "Open Sans Condensed", size = 16, weight = 200 } )

local THEATERLIST = {}
THEATERLIST.TitleHeight = 56
THEATERLIST.TheaterHeight = 56

function THEATERLIST:Init()

	self.Title = Label( T'TheaterList_NowShowing', self )
	self.Title:SetFont( "ScoreboardTitleSmall" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Theaters = {}
	self.NextUpdate = 0.0

end

local Background = Material( "theater/nowshowing256.png" )

function THEATERLIST:Paint( w, h )

	//Render the background
	surface.SetDrawColor( 123, 32, 29, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )

	// Title Background
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Background )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), 680 )

end

function THEATERLIST:AddTheater( th )
	
	if self.Theaters[ th ] then return end

	local panel = vgui.Create( "ScoreboardTheater", self )
	panel:SetTheater( th )
	panel:SetVisible( true )
	
	self.Theaters[ th ] = panel
	
end

function THEATERLIST:RemoveTheater( th )

	if ValidPanel( self.Theaters[ th ] ) then
		self.Theaters[ th ]:Remove()
		self.Theaters[ th ] = nil
	end

end

function THEATERLIST:Update()
	theater.PollServer()
end

function THEATERLIST:UpdateList()

	local ids = {}
	
	for _, th in pairs( theater.GetTheaters() ) do 
		self:AddTheater( th:GetLocation() )
		table.insert(ids, th:GetLocation() )
	end

	for k, panel in pairs( self.Theaters ) do
		if !table.HasValue(ids, k) then
			self:RemoveTheater( k )
		end
	end

end

function THEATERLIST:Think()

	if RealTime() > self.NextUpdate then
		self:Update()
		self:InvalidateLayout()

		for _, panel in pairs( self.Theaters ) do
			panel:Update()
			panel:InvalidateLayout()
		end

		self.NextUpdate = RealTime() + 1.0
	end

end

function THEATERLIST:PerformLayout()

	local TheatersSorted = {}
		
	for _, panel in pairs( self.Theaters ) do
		local th = {}
		th.Panel = panel
		table.insert( TheatersSorted, th )
	end

	local nameSort = function( a, b )
		if !a.Panel or !a.Panel.TheaterId then return false end
		if !b.Panel or !b.Panel.TheaterId then return true end
		return string.lower( theater.GetNameByLocation(a.Panel.TheaterId) ) < string.lower( theater.GetNameByLocation(b.Panel.TheaterId) )
	end
	table.sort( TheatersSorted, nameSort )

	local curY = self.TitleHeight

	for _, th in pairs( TheatersSorted ) do

		th.Panel:InvalidateLayout( true )
		th.Panel:SetPos( 0, curY )
		th.Panel:SetWide( self:GetWide() )

		curY = curY + self.TheaterHeight + 2

	end

	self:SetTall( curY )

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight )
	self.Title:CenterHorizontal()

	if self.Title:GetWide() > self:GetWide() and self.Title:GetFont() != "ScoreboardTitleSmaller" then
		self.Title:SetFont( "ScoreboardTitleSmaller" )
	end

end

vgui.Register( "ScoreboardTheaterList", THEATERLIST )



THEATER = {}
THEATER.Padding = 16

function THEATER:Init()

	self.TheaterId = -1

	self:SetTall( THEATERLIST.TheaterHeight )

	self.Title = Label( "THEATER 1", self )
	self.Title:SetFont( "ScoreboardTheaterName" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Time = Label( "0:00 / 0:00", self )
	self.Time:SetFont( "ScoreboardTheaterTime" )
	self.Time:SetColor( Color( 255, 255, 255, 30 ) )

	self.Video = Label( "cute cats xD", self )
	self.Video:SetFont( "ScoreboardTheaterVideo" )
	self.Video:SetColor( Color( 255, 255, 255 ) )

end

function THEATER:Paint( w, h )

end

function THEATER:Update()

	local Theater = theater.GetByLocation(self.TheaterId)
	if !Theater then return end

	self.Title:SetText( string.upper( Theater:Name() ) )
	self.Time:SetText( Theater:VideoTime() )
	self.Video:SetText( T( Theater:VideoTitle() ) )

end

function THEATER:SetTheater( th )
	self.TheaterId = th
	self:Update()
end

function THEATER:Think() end

function THEATER:PerformLayout()

	self.Title:SizeToContents()
	local w = math.Clamp(self.Title:GetWide(), 0, 140)
	self.Title:SetSize(w, self.Title:GetTall())

	self.Title:AlignLeft( self.Padding )

	self.Time:SizeToContents()
	self.Time:AlignRight( self.Padding )
	self.Time:AlignTop( self.Padding / 2 )

	self.Video:SizeToContents()
	local w = math.Clamp(self.Video:GetWide(), 0, 225)
	self.Video:SetSize(w, self.Video:GetTall())

	self.Video:AlignLeft( self.Padding )
	self.Video:AlignTop( self.Title:GetTall() - 5 )

end

vgui.Register( "ScoreboardTheater", THEATER )