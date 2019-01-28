local PANEL = {}

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self.BaseClass.PerformLayout(self)

	if ( self.Label ) then
		local x, y = self.Label:GetPos()
		y = (self.Button:GetTall() / 2) - (self.Label:GetTall() / 2)
		self.Label:SetPos(x, y)
	end

end


--[[---------------------------------------------------------
	SizeToContents
-----------------------------------------------------------]]
function PANEL:SizeToContents()

	self:InvalidateLayout( true )
	self:SetWide( self.Label.x + self.Label:GetWide() )
	self:SetTall( self.Label.y + self.Label:GetTall() )

end

derma.DefineControl( "TheaterCheckBoxLabel", "", PANEL, "DCheckBoxLabel" )
