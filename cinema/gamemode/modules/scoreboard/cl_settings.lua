
surface.CreateFont( "ScoreboardHelp", { font = "Open Sans Condensed Light", size = 20, weight = 100 } )
surface.CreateFont( "ScoreboardHelpSmall", { font = "Open Sans Condensed Light", size = 18, weight = 100 } )

SETTINGS = {}
SETTINGS.TitleHeight = 88

function SETTINGS:Init()

	self.Title = Label( T'Settings_Title', self )
	self.Title:SetFont( "ScoreboardTitleSmall" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.Help = Label( T'Settings_ClickActivate', self )
	self.Help:SetFont( "ScoreboardHelp" )
	self.Help:SetColor( Color( 255, 255, 255, 150 ) )

	self.Settings = {}

	self:Create()

end

function SETTINGS:NewSetting( control, text, convar )

	local Control = vgui.Create( control, self )
	Control:SetText( text or "" )
	Control:SetWidth( 300 )

	if convar then
		Control:SetConVar( convar )
	end

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

	if ValidPanel( Gui ) then
		self.Help:SetVisible( !Gui.MouseEnabled )
	end

end

function SETTINGS:PerformLayout()

	local curY = self.TitleHeight + 40

	for _, panel in pairs( self.Settings ) do

		panel:InvalidateLayout()
		curY = curY + 28

		-- Resize label if needed for localization
		if ValidPanel( panel.Label ) and panel.Label:GetFont() != "ScoreboardHelpSmall" then
			
			local px, py = panel:GetPos()

			local x, y = panel.Label:GetPos()
			local w, h = panel.Label:GetSize()

			if ( px + x + w ) > self:GetWide() then
				panel.Label:SetFont( "ScoreboardHelpSmall" )
				panel.Label:SizeToContents()
			end

		end

	end

	self:SetTall( curY )

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight - 14 )
	self.Title:CenterHorizontal()

	self.Help:SizeToContents()
	self.Help:CenterHorizontal()
	self.Help:AlignBottom( 10 )

	if self.Help:GetWide() > self:GetWide() and self.Help:GetFont() != "ScoreboardHelpSmall" then
		self.Help:SetFont( "ScoreboardHelpSmall" )
	end

end

function SETTINGS:Create()

	-- Volume slider
	local Volume = self:NewSetting( "TheaterNumSlider", T'Volume', "cinema_volume" )
	Volume:SetTooltip( T'Settings_VolumeTooltip' )
	Volume:SetMinMax( 0, 100 )
	Volume:SetDecimals( 0 )
	Volume:SetWide( 256 - 32 )
	Volume:SetTall( 50 )
	Volume:AlignLeft( 16 )
	Volume:AlignTop( self.TitleHeight - 20 )

	-- HD Playback checkbox
	local HD = self:NewSetting( "TheaterCheckBoxLabel", T'Settings_HDLabel', "cinema_hd" )
	HD:SetTooltip( T'Settings_HDTooltip' )
	HD:AlignLeft( 16 )
	HD:AlignTop( self.TitleHeight + 34 )
	HD.Label:SetFont( "LabelFont" )
	HD.Label:SetColor( color_white )
	HD.Label:SetTall(50)

	-- Hide Players
	local HidePlayers = self:NewSetting( "TheaterCheckBoxLabel", T'Settings_HidePlayersLabel', "cinema_hideplayers" )
	HidePlayers:SetTooltip( T'Settings_HidePlayersTooltip' )
	HidePlayers:AlignLeft( 16 )
	HidePlayers:AlignTop( self.TitleHeight + 64 )
	HidePlayers.Label:SetFont( "LabelFont" )
	HidePlayers.Label:SetColor( color_white )
	HidePlayers.Label:SetTall(50)

	-- Hide Players
	local MuteAltTab = self:NewSetting( "TheaterCheckBoxLabel", T'Settings_MuteFocusLabel', "cinema_mute_nofocus" )
	MuteAltTab:SetTooltip( T'Settings_MuteFocusTooltip' )
	MuteAltTab:AlignLeft( 16 )
	MuteAltTab:AlignTop( self.TitleHeight + 94 )
	MuteAltTab.Label:SetFont( "LabelFont" )
	MuteAltTab.Label:SetColor( color_white )
	MuteAltTab.Label:SetTall(50)

	-- Languages
	local LanguageSelect = self:NewSetting( "DLanguageSelect" )
	LanguageSelect:SetWidth( 224 )
	LanguageSelect:AlignLeft( 16 )
	LanguageSelect:AlignTop( self.TitleHeight + 124 )

	-- Add language options
	local CurrentLanguage = translations.GetLanguage()
	for idx, lang in pairs( translations.GetLanguages() ) do
		LanguageSelect:AddLanguage( lang, CurrentLanguage == lang.Id )
	end

end

vgui.Register( "ScoreboardSettings", SETTINGS )