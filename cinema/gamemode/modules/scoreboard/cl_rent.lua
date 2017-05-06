module( "theater", package.seeall )

local LocalPlayer = LocalPlayer
local vgui = vgui
local Label = Label
local Color = Color
local RunConsoleCommand = RunConsoleCommand
local tostring = tostring
local RealTime = RealTime
local Material = Material
local surface = surface

local PANEL = {}
PANEL.TitleHeight = 40

function PANEL:Init()

	local Theater = LocalPlayer():GetTheater()

	self:SetZPos( 1 )
	self:SetSize( 500, 125 )
	self:SetPos( 50, 50 )
	self:Center()
	self:SetFocusTopLevel( true )

	local title = T'Theater_AddRent'

	self.CloseButton = vgui.Create( "TheaterButton", self )
	self.CloseButton:SetPos( 475, 0 )
	self.CloseButton:SetSize( 25, 25 )
	self.CloseButton:SetText( "X" )
	self.CloseButton.DoClick = function() 
		self:Remove()
		GAMEMODE:HideMouse()
	end

	self.Title = Label( title, self )
	self.Title:SetFont( "ScoreboardTitle" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.NextUpdate = 0.0

	-- Slider for Rent Time
	self.TimeSlider = vgui.Create( "TheaterNumSlider", self )
	self.TimeSlider:SetText( T'Theater_RentTime' )
	self.TimeSlider:SetPos( 20, 50 )
	self.TimeSlider:SetWide( 460 )
	self.TimeSlider:SetMinMax( 10, 120 )
	--self.TimeSlider:SetValue( 10 )
	self.TimeSlider:SetDecimals( 0 )

	-- Label for Cost
	self.CostLabel = vgui.Create( "DLabel", self )
	self.CostLabel:SetText( "Unknown" )
	self.CostLabel:SetPos( 25, 90 )
	self.CostLabel:SetFont("LabelFont")

	-- Button for Adding Rent
	self.RentButton = vgui.Create( "TheaterButton", self )
	self.RentButton:SetPos( (self:GetWide() / 2) - (self.RentButton:GetWide() ), 90 )
	self.RentButton:SetSize( 120,25 )
	self.RentButton:SetText( T'Theater_AddRent' )
	self.RentButton.DoClick = function()
		local RentSeconds = self.TimeSlider:GetValue()*60
		if RentSeconds > 0 then
			RunConsoleCommand("cinema_rent", RentSeconds)
		end
		self:Remove()
		GAMEMODE:HideMouse()
	end

end

function PANEL:Update()

	if !LocalPlayer():GetTheater() then
		self:Remove()
		GAMEMODE:HideMouse()
		return
	end

	self.CostLabel:SetText( T('Theater_RentCost', GetConVar("cinema_rentables_cost"):GetInt()*self.TimeSlider:GetValue()) )
	self.CostLabel:SizeToContents()

end

function PANEL:Think()

	if RealTime() > self.NextUpdate then
		self:Update()
		self:InvalidateLayout()
		self.NextUpdate = RealTime() + 0.0
	end

end

local Background = Material( "theater/banner.png" )

function PANEL:Paint( w, h )

	// Background
	surface.SetDrawColor( 26, 30, 38, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self:GetTall() )

	// Title
	surface.SetDrawColor( 141, 38, 33, 255 )
	surface.DrawRect( 0, 0, self:GetWide(), self.Title:GetTall() )

	// Title Background
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Background )
	surface.DrawTexturedRect( 0, -1, self:GetWide(), self.Title:GetTall() + 1 )

end

function PANEL:PerformLayout()

	self.Title:SizeToContents()
	self.Title:SetTall( self.TitleHeight )
	self.Title:CenterHorizontal()

end

vgui.Register( "ScoreboardRent", PANEL, "EditablePanel" )
