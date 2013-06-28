--[[   _                                
    ( )                               
   _| |   __   _ __   ___ ___     _ _ 
 /'_` | /'__`\( '__)/' _ ` _ `\ /'_` )
( (_| |(  ___/| |   | ( ) ( ) |( (_| |
`\__,_)`\____)(_)   (_) (_) (_)`\__,_) 

	DComboBox

--]]

PANEL = {}

Derma_Hook( PANEL, "Paint", "Paint", "ComboBox" )

Derma_Install_Convar_Functions( PANEL )

--[[---------------------------------------------------------

-----------------------------------------------------------]]
function PANEL:Init()

	self.DropButton = vgui.Create( "DPanel", self )
	self.DropButton.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ComboDownArrow", panel, w, h ) end
	self.DropButton:SetMouseInputEnabled( false )
	self.DropButton.ComboBox = self
		
	self:SetTall( 22 )
	self:Clear()
	
	self:SetContentAlignment( 4 )
	self:SetTextInset( 8, 0 )
	self:SetIsMenu( true )

end

--[[---------------------------------------------------------
   Name: Clear
-----------------------------------------------------------]]
function PANEL:Clear()

	self:SetText( "" )
	self.Choices = {}
	self.Data = {}

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end
	
end

--[[---------------------------------------------------------
   Name: GetOptionText
-----------------------------------------------------------]]
function PANEL:GetOptionText( id )

	return self.Choices[ id ]

end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout()

	self.DropButton:SetSize( 15, 15 )
	self.DropButton:AlignRight( 4 )
	self.DropButton:CenterVertical()

end

--[[---------------------------------------------------------
   Name: ChooseOption
-----------------------------------------------------------]]
function PANEL:ChooseOption( value, index )

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self:SetText( value.Name )
	self:OnSelect( index, value, self.Data[index] )
	
end

--[[---------------------------------------------------------
   Name: ChooseOptionID
-----------------------------------------------------------]]
function PANEL:ChooseOptionID( index )

	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	local value = self:GetOptionText( index )
	self:SetText( value )

	self:OnSelect( index, value, self.Data[index] )
	
end



--[[---------------------------------------------------------
   Name: OnSelect
-----------------------------------------------------------]]
function PANEL:OnSelect( index, value, data )

	RunConsoleCommand( "gmod_language", data )

	if ValidPanel( Gui ) then 
		Gui:Remove()
		Gui = nil
		timer.Simple( 0.1, function()
			GAMEMODE:ScoreboardShow()
		end )
	end

	if ValidPanel( GuiQueue ) then
		GuiQueue:Remove()
		GuiQueue = nil
	end

	if ValidPanel( GuiAdmin ) then
		GuiAdmin:Remove()
		GuiAdmin = nil
	end

end

--[[---------------------------------------------------------
   Name: AddChoice
-----------------------------------------------------------]]
function PANEL:AddLanguage( lang, select )

	local i = table.insert( self.Choices, lang )
	
	if ( lang.Id ) then
		self.Data[ i ] = lang.Id
	end

	if ( select ) then

		self:ChooseOption( lang, i )

	end
	
	return i

end

function PANEL:IsMenuOpen()

	return IsValid( self.Menu ) && self.Menu:IsVisible()

end

--[[---------------------------------------------------------
   Name: OpenMenu
-----------------------------------------------------------]]
function PANEL:OpenMenu( pControlOpener )

	if ( pControlOpener ) then
		if ( pControlOpener == self.TextEntry ) then
			return
		end
	end

	-- Don't do anything if there aren't any options..
	if ( #self.Choices == 0 ) then return end
	
	-- If the menu still exists and hasn't been deleted
	-- then just close it and don't open a new one.
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self.Menu = DermaMenu()
	self.Menu.AddOption = function( self, strName, strId, strAuthor, funcFunction )

		local pnl = vgui.Create( "DLanguageOption", self )
		pnl:SetMenu( self )
		pnl:SetLanguage( strName, strId, strAuthor )

		if ( funcFunction ) then pnl.DoClick = funcFunction end

		self:AddPanel( pnl )

		return pnl

	end

		for k, v in pairs( self.Choices ) do
			self.Menu:AddOption( v.Name, v.Id, v.Author,
				function() self:ChooseOption( v, k ) end )
		end
		
		local x, y = self:LocalToScreen( 0, self:GetTall() )
		
		self.Menu:SetMinimumWidth( self:GetWide() )
		self.Menu:Open( x, y, false, self )		
		

end

function PANEL:CloseMenu()
	
	if ( IsValid( self.Menu ) ) then
		self.Menu:Remove()
	end	
	
end

function PANEL:Think()

	self:ConVarNumberThink()

end

function PANEL:SetValue( strValue )

	self:SetText( strValue )

end

function PANEL:DoClick()

	if ( self:IsMenuOpen() ) then
		return self:CloseMenu()
	end
	
	self:OpenMenu()

end

--[[---------------------------------------------------------
   Name: GenerateExample
-----------------------------------------------------------]]
function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
		ctrl:AddChoice( "Some Choice" )
		ctrl:AddChoice( "Another Choice" )
		ctrl:SetWide( 150 )
	
	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "DLanguageSelect", "", PANEL, "DButton" )