function RequestVideoURL( url )

	if ValidPanel( RequestPanel ) then
		RequestPanel:OnClose()
		RequestPanel:Remove()
	end

	RunConsoleCommand( "cinema_video_request", url )

end

local PANEL = {}
PANEL.HistoryWidth = 300

local CloseTexture = Material( "theater/close.png" )

function PANEL:Init()

	RequestPanel = self

	self:SetFocusTopLevel( true )

	local w = math.Clamp( ScrW() - 100, 800, 1152 + self.HistoryWidth )
	local h = ScrH()
	if h > 800 then
		h = h * 3/4
	elseif h > 600 then
		h = h * 7/8
	end
	self:SetSize( w, h )

	self.CloseButton = vgui.Create( "DButton", self )
	self.CloseButton:SetZPos( 5 )
	self.CloseButton:NoClipping( true )
	self.CloseButton:SetText( "" )
	self.CloseButton.DoClick = function ( button )
		self:OnClose()
		self:Remove()
	end
	self.CloseButton.Paint = function( panel, w, h )
		DisableClipping( true )
		surface.SetDrawColor( 48, 55, 71 )
		surface.DrawRect( 2, 2, w - 4, h - 4 )

		surface.SetDrawColor( 26, 30, 38 )
		surface.SetMaterial( CloseTexture )
		surface.DrawTexturedRect( 0, 0, w, h )

		DisableClipping( false )
	end

	self.BrowserContainer = vgui.Create( "DPanel", self )

	self.Browser = vgui.Create( "TheaterHTML", self.BrowserContainer )

	Msg("AWESOMIUM: Initialized instance for video request window\n")

	self.Browser:SetAllowLua(true)
	self.Browser:OpenURL( "http://cinema.pixeltailgames.com/search.html" )

	self.Controls = vgui.Create( "TheaterHTMLControls", self.BrowserContainer )
	self.Controls:SetHTML( self.Browser )
	self.Controls.BorderSize = 0

	self.History = vgui.Create( "RequestHistory", self )
	self.History:SetPaintBackgroundEnabled(false)

end

function PANEL:OnClose()
	if ValidPanel(self.Browser) then
		Msg("AWESOMIUM: Destroyed instance for video request window\n")
		self.Browser:Remove()
	end
end

function PANEL:CheckClose()

	local x, y = self:CursorPos()

	-- Remove panel if mouse is clicked outside of itself
	if not (gui.IsGameUIVisible() or gui.IsConsoleVisible()) and
		( x < 0 or x > self:GetWide() or y < 0 or y > self:GetTall() ) then
		self:OnClose()
		self:Remove()
	end

end

function PANEL:PerformLayout()

	local w, h = self:GetSize()

	self.CloseButton:SetSize( 32, 32 )
	self.CloseButton:SetPos( w - 34, 2 )

	self.BrowserContainer:Dock( FILL )

	self.Browser:Dock( FILL )

	self.History:Dock( RIGHT )
	-- self.History:DockMargin( 8, 0, 0, 0 )
	self.History:SetWide( self.HistoryWidth )

	self.Controls:Dock( TOP )

end

vgui.Register( "VideoRequestFrame", PANEL, "EditablePanel" )


local HISTORY = {}
HISTORY.TitleHeight = 64
HISTORY.VidHeight = 32 // 48

function HISTORY:Init()

	self:SetSize( 256, 512 )
	self:SetPos( 8, ScrH() / 2 - ( self:GetTall() / 2 ) )

	self.Title = Label( T'Request_History', self )
	self.Title:SetFont( "ScoreboardTitle" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Videos = {}

	self.VideoList = vgui.Create( "TheaterList", self )
	self.VideoList:DockMargin(0, self.TitleHeight + 2, 0, 0)

	self.Options = vgui.Create( "DPanelList", self )
	self.Options:SetDrawBackground(false)
	self.Options:SetPadding( 4 )
	self.Options:SetSpacing( 4 )

	local ClearButton = vgui.Create( "TheaterButton" )
	ClearButton:SetText( T'Request_Clear' )
	ClearButton.DoClick = function()
		theater.ClearRequestHistory()
		self.VideoList:Clear(true)
	end
	self.Options:AddItem(ClearButton)

	for _, request in pairs( theater.GetRequestHistory() ) do
		self:AddVideo( request )
	end

	self.VideoList:SortVideos( function( a, b ) 
		return a.lastRequest > b.lastRequest
	end )

end

function HISTORY:AddVideo( vid )

	if self.Videos[ vid.id ] then
		self.Videos[ vid.id ]:SetVideo( vid )
	else
		local panel = vgui.Create( "RequestVideo", self )
		panel:SetVideo( vid )
		panel:SetVisible( true )
		self.Videos[ vid.id ] = panel
		self.VideoList:AddItem( panel )
	end
	
end

function HISTORY:RemoveVideo( vid )

	if ValidPanel( self.Videos[ vid.id ] ) then
		self.VideoList:RemoveItem( self.Videos[ vid.Id ] )
		self.Videos[ vid.id ]:Remove()
		self.Videos[ vid.id ] = nil
	end

end

local Background = Material( "theater/banner.png" )

function HISTORY:Paint( w, h )

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

function HISTORY:PerformLayout()

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight )
	self.Title:CenterHorizontal()

	if self.Title:GetWide() > self:GetWide() and self.Title:GetFont() != "ScoreboardTitleSmall" then
		self.Title:SetFont( "ScoreboardTitleSmall" )
	end

	self.VideoList:Dock( FILL )

	self.Options:Dock( BOTTOM )
	self.Options:SizeToContents()

end

vgui.Register( "RequestHistory", HISTORY )


local VIDEO = {}
VIDEO.Padding = 8

function VIDEO:Init()

	self:SetTall( HISTORY.VidHeight )

	self.Title = Label( "Unknown", self )
	self.Title:SetFont( "ScoreboardVidTitle" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Duration = Label( "0:00", self )
	self.Duration:SetFont( "ScoreboardVidDuration" )
	self.Duration:SetColor( Color( 255, 255, 255 ) )

	self.Requests = Label( "1 request(s)", self )
	self.Requests:SetFont( "ScoreboardVidDuration" )
	self.Requests:SetColor( Color( 255, 255, 255 ) )

	self.RequestVideo = vgui.Create( "DImageButton", self )
	self.RequestVideo:SetSize( 16, 16 )
	self.RequestVideo:SetImage( "theater/play.png" )
	self.RequestVideo:SetTooltip( T'Request_Video' )
	self.RequestVideo.DoClick = function()
		RequestVideoURL( self.Video.url )
	end
	self.RequestVideo.Think = function()
		if IsMouseOver( self.RequestVideo ) then
			self.RequestVideo:SetAlpha( 255 )
		else
			self.RequestVideo:SetAlpha( 25 )
		end
	end

	self.DeleteVideo = vgui.Create( "DImageButton", self )
	self.DeleteVideo:SetSize( 16, 16 )
	self.DeleteVideo:SetImage( "theater/trashbin.png" )
	self.DeleteVideo:SetTooltip( T'Request_DeleteTooltip' )
	self.DeleteVideo.DoClick = function()
		theater.RemoveRequestById( self.Video.id )

		-- Lovely DPanelList
		pcall( function(v)
			self:GetParent():GetParent():GetParent():RemoveVideo( v )
		end, self.Video )
		
	end
	self.DeleteVideo.Think = function()
		if IsMouseOver( self.DeleteVideo ) then
			self.DeleteVideo:SetAlpha( 255 )
		else
			self.DeleteVideo:SetAlpha( 25 )
		end
	end

end

function VIDEO:SetVideo( vid )

	self.Video = vid
	
	self:SetTooltip( self.Video.title )
	self.Title:SetText( self.Video.title )

	if tonumber(self.Video.duration) > 0 then
		self.Duration:SetText( string.FormatSeconds(self.Video.duration) )
	else
		self.Duration:SetText( "" )
	end

	self.Requests:SetText( T('Request_PlayCount', self.Video.count) )

end

function VIDEO:PerformLayout()

	self.Title:SizeToContents()
	local w = math.Clamp(self.Title:GetWide(), 0, 224)
	self.Title:SetSize(w, self.Title:GetTall())

	self.Title:AlignTop( -2 )
	self.Title:AlignLeft( self.Padding )

	self.Duration:SizeToContents()
	self.Duration:AlignTop( self.Title:GetTall() - 4 )
	self.Duration:AlignLeft( self.Padding )

	self.Requests:SizeToContents()
	self.Requests:SetContentAlignment( 6 )
	self.Requests:AlignTop( self.Title:GetTall() - 4 )
	self.Requests:AlignRight( 64 )

	self.RequestVideo:Center()
	self.RequestVideo:AlignRight( 36 )

	self.DeleteVideo:Center()
	self.DeleteVideo:AlignRight( 10 )
	
end

function VIDEO:Paint( w, h )

	surface.SetDrawColor( 38, 41, 49, 255 )
	surface.DrawRect( 0, 0, self:GetSize() )

end

vgui.Register( "RequestVideo", VIDEO )
