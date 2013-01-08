
surface.CreateFont( "ScoreboardHelp", { font = "Open Sans Condensed Light", size = 20, weight = 100 } )

SETTINGS = {}
SETTINGS.TitleHeight = 88

function SETTINGS:Init()

	self.Title = Label( "SETTINGS", self )
	self.Title:SetFont( "ScoreboardTitleSmall" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Help = Label( "CLICK TO ACTIVATE YOUR MOUSE", self )
	self.Help:SetFont( "ScoreboardHelp" )
	self.Help:SetColor( Color( 255, 255, 255, 150 ) )

	self.Settings = {}

	self:Create()

end

function SETTINGS:NewSetting( control, text, convar )

	local Control = vgui.Create( control, self )
	Control:SetConVar( convar )
	Control:SetText( text )
	Control:SetWidth( 300 )

	if !table.HasValue( self.Settings, Control ) then
		table.insert( self.Settings, Control )
	end
	
	return Control
	
end

local Background = Material( "theater/settingsbright.png" )

function SETTINGS:Paint( w, h )

	//Render the background
	surface.SetDrawColor( 62, 16, 15, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )

	// Background image
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Background )
	surface.DrawTexturedRect( 0, self:GetTall() - 680, 256, 680 )

end

function SETTINGS:Think()

	self.Help:SetVisible( !Gui.MouseEnabled )

end

function SETTINGS:PerformLayout()

	local curY = self.TitleHeight + 40

	for _, panel in pairs( self.Settings ) do

		panel:InvalidateLayout()
		curY = curY + panel:GetTall()

	end

	self:SetTall( curY )

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight - 14 )
	self.Title:CenterHorizontal()

	self.Help:SizeToContents()
	self.Help:CenterHorizontal()
	self.Help:AlignBottom( 10 )

end

function SETTINGS:Create()

	-- Volume slider
	local Volume = self:NewSetting( "TheaterNumSlider", "Volume", "cinema_volume" )
	Volume:SetTooltip( "Use the +/- keys to increase/decrease volume." )
	Volume:SetMinMax( 0, 100 )
	Volume:SetDecimals( 0 )
	Volume:SetWide( 256 - 32 )
	Volume:SetTall( 50 )
	Volume:AlignLeft( 16 )
	Volume:AlignTop( self.TitleHeight - 20 )

	-- HD Playback checkbox
	local HD = self:NewSetting( "TheaterCheckBoxLabel", "HD Video Playback", "cinema_hd" )
	HD:SetTooltip( "Enable HD video playback for HD enabled videos." )
	HD:AlignLeft( 16 )
	HD:AlignTop( self.TitleHeight + 34 )
	HD.Label:SetFont( "LabelFont" )
	HD.Label:SetColor( color_white )
	HD.Label:SetTall(50)

	-- Hide Players
	local HidePlayers = self:NewSetting( "TheaterCheckBoxLabel", "Hide Players In Theater", "cinema_hideplayers" )
	HidePlayers:SetTooltip( "Reduce player visibility inside of theaters." )
	HidePlayers:AlignLeft( 16 )
	HidePlayers:AlignTop( self.TitleHeight + 64 )
	HidePlayers.Label:SetFont( "LabelFont" )
	HidePlayers.Label:SetColor( color_white )
	HidePlayers.Label:SetTall(50)

end

vgui.Register( "ScoreboardSettings", SETTINGS )