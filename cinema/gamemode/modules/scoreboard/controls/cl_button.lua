--[[   _                                
	( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DButton
	
	Default Button

--]]

local PANEL = {}

local b = 20 // Brightness change of hover or depress

PANEL.BackgroundColor = Color( 38, 41, 49 )
PANEL.HoverColor = Color( 38 + b, 41 + b, 49 + b )
PANEL.DepressedColor = Color( 38 - b, 41 - b, 49 - b )
PANEL.DisabledColor = Color( 26, 30, 38 )
PANEL.TextColor = Color( 255, 255, 255 )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self.BaseClass.Init(self)

	self:SetTall( 28 )
	self:SetFont( "LabelFont" )

end


function PANEL:Paint( w, h )

	if ( !self.m_bBackground ) then return end

	if ( self.Depressed || self:IsSelected() || self:GetToggle() ) then
		surface.SetDrawColor( self.DepressedColor )
		surface.DrawRect( 0, 0, w, h )
		return
	end

	if ( self:GetDisabled() ) then
		surface.SetDrawColor( self.DisabledColor )
		surface.DrawRect( 0, 0, w, h )
		return
	end

	if ( self:IsMouseOver() ) then
		surface.SetDrawColor( self.HoverColor )
		surface.DrawRect( 0, 0, w, h )
		return
	end

	surface.SetDrawColor( self.BackgroundColor )
	surface.DrawRect( 0, 0, w, h )

end

function PANEL:UpdateColours( skin )
    return self:SetTextStyleColor( self.TextColor )
end

function PANEL:IsMouseOver()

	local x,y = self:CursorPos()
	return x >= 0 and y >= 0 and x <= self:GetWide() and y <= self:GetTall()

end

derma.DefineControl( "TheaterButton", "", PANEL, "DButton" )