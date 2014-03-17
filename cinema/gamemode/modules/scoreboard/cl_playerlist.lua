surface.CreateFont( "ScoreboardTitle", { font = "Ultra", size = 50, weight = 400 } )
surface.CreateFont( "ScoreboardTitleSmall", { font = "Ultra", size = 28, weight = 400 } )
surface.CreateFont( "ScoreboardTitleSmaller", { font = "Ultra", size = 18, weight = 400 } )
surface.CreateFont( "ScoreboardServerName", { font = "Open Sans Condensed Light", size = 28, weight = 200 } )
surface.CreateFont( "ScoreboardMapName", { font = "Open Sans Condensed Light", size = 22, weight = 200 } )
surface.CreateFont( "ScoreboardName", { font = "Open Sans", size = 20, weight = 800 } )
surface.CreateFont( "ScoreboardLocation", { font = "Open Sans Condensed", size = 16, weight = 200 } )
surface.CreateFont( "ScoreboardPing", { font = "Open Sans Condensed", size = 18, weight = 200 } )

local PLAYERLIST = {}
PLAYERLIST.TitleHeight = 64
PLAYERLIST.ServerHeight = 30
PLAYERLIST.PlyHeight = 48

function PLAYERLIST:Init()

	self.Title = Label( T'Cinema', self )
	self.Title:SetFont( "ScoreboardTitle" )
	self.Title:SetColor( Color( 255, 255, 255 ) )

	self.ServerName = vgui.Create( "ScoreboardServerName", self )

	self.PlayerList = vgui.Create( "TheaterList", self )

	self.Players = {}
	self.NextUpdate = 0.0

end

function PLAYERLIST:AddPlayer( ply )
	
	local panel = vgui.Create( "ScoreboardPlayer" )
	panel:SetParent( self )
	panel:SetPlayer( ply )
	panel:SetVisible( true )
	
	self.Players[ ply ] = panel
	self.PlayerList:AddItem( panel )
	
end

function PLAYERLIST:RemovePlayer( ply )

	if ValidPanel( self.Players[ ply ] ) then
		self.PlayerList:RemoveItem( self.Players[ ply ] )
		self.Players[ ply ]:Remove()
		self.Players[ ply ] = nil
	end

end

local Background = Material( "theater/banner.png" )

function PLAYERLIST:Paint( w, h )

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

function PLAYERLIST:Think()

	if RealTime() > self.NextUpdate then

		for ply in pairs( self.Players ) do 
			if !IsValid( ply ) then
				self:RemovePlayer( ply )
			end
		end
		
		for _, ply in pairs( player.GetAll() ) do 
			if self.Players[ ply ] == nil then
				self:AddPlayer( ply )
			end
		end

		self.ServerName:Update()
		self:InvalidateLayout()

		self.NextUpdate = RealTime() + 3.0

	end

end

function PLAYERLIST:PerformLayout()

	table.sort( self.PlayerList.Items, function( a, b ) 

		if !a or !a.Player or !IsValid(a.Player) then return false end
		if !b or !b.Player or !IsValid(b.Player) then return true end
		
		return string.lower( a.Player:Nick() ) < string.lower( b.Player:Nick() )

	end )

	local curY = PLAYERLIST.TitleHeight + PLAYERLIST.ServerHeight

	for _, panel in pairs( self.PlayerList.Items ) do

		panel:InvalidateLayout( true )
		panel:UpdatePlayer()
		panel:SetWide( self:GetWide() )

		curY = curY + self.PlyHeight + 2

	end

	self.Title:SizeToContents()
	self.Title:SetTall( PLAYERLIST.TitleHeight )
	self.Title:CenterHorizontal()

	self.ServerName:SizeToContents()
	self.ServerName:AlignTop( PLAYERLIST.TitleHeight )
	self.ServerName:SetWide( self:GetWide() )
	self.ServerName:SetTall( PLAYERLIST.ServerHeight )
	self.ServerName:CenterHorizontal()

	self.PlayerList:Dock( FILL )
	self.PlayerList:DockMargin( 0, self.TitleHeight + self.ServerHeight, 0, 0 )
	self.PlayerList:SizeToContents()

	self:SetTall( math.min( curY, ScrH() * 0.8 ) )

end

vgui.Register( "ScoreboardPlayerList", PLAYERLIST )



local PLAYER = {}
PLAYER.Padding = 8

function PLAYER:Init()

	self:SetTall( PLAYERLIST.PlyHeight )

	self.Name = Label( "Unknown", self )
	self.Name:SetFont( "ScoreboardName" )
	self.Name:SetColor( Color( 255, 255, 255 ) )

	self.Location = Label( "Unknown", self )
	self.Location:SetFont( "ScoreboardLocation" )
	self.Location:SetColor( Color( 255, 255, 255, 80 ) )
	self.Location:SetPos( 0, 8 )

	self.AvatarButton = vgui.Create("DButton", self)
	self.AvatarButton:SetSize( 32, 32 )
	
	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:SetSize( 32, 32 )
	self.Avatar:SetZPos( 1 )
	self.Avatar:SetVisible( false )
	self.Avatar:SetMouseInputEnabled( false )

	self.Ping = vgui.Create( "ScoreboardPlayerPing", self )

end

function PLAYER:UpdatePlayer()

	if !IsValid(self.Player) then

		local parent = self:GetParent()
		if ValidPanel(parent) and parent.RemovePlayer then
			parent:RemovePlayer(self.Player)
		end

		return

	end

	self.Name:SetText( self.Player:Name() )
	self.Location:SetText( string.upper( self.Player:GetLocationName() or "Unknown" ) )
	self.Ping:Update()

end

function PLAYER:SetPlayer( ply )

	self.Player = ply
	
	self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

	self.Avatar:SetPlayer( ply, 64 )
	self.Avatar:SetVisible( true )

	self.Ping:SetPlayer( ply )

	self:UpdatePlayer()

end

function PLAYER:PerformLayout()

	self.Name:SizeToContents()
	self.Name:AlignTop( self.Padding - 2 )
	self.Name:AlignLeft( self.Avatar:GetWide() + 16 )

	self.Location:SizeToContents()
	self.Location:AlignTop( self.Name:GetTall() + 5 )
	self.Location:AlignLeft( self.Avatar:GetWide() + 16 )
	
	self.AvatarButton:AlignTop( self.Padding )
	self.AvatarButton:AlignLeft( self.Padding )
	self.AvatarButton:CenterVertical()
	
	self.Avatar:SizeToContents()
	self.Avatar:AlignTop( self.Padding )
	self.Avatar:AlignLeft( self.Padding )
	self.Avatar:CenterVertical()

	self.Ping:InvalidateLayout()
	self.Ping:SizeToContents()
	self.Ping:AlignRight( self.Padding )
	self.Ping:CenterVertical()
	
end

local PixeltailIcon = Material( "theater/pixeltailicon.png" )
local AdminIcon = Material( "theater/adminicon.png" )

function PLAYER:Paint( w, h )

	surface.SetDrawColor( 38, 41, 49, 255 )
	surface.DrawRect( 0, 0, self:GetSize() )

	surface.SetDrawColor( 255, 255, 255, 255 )

	if self.Player.IsPixelTail && self.Player:IsPixelTail() then

		surface.SetMaterial( PixeltailIcon )
		surface.DrawTexturedRect( self.Name.x + self.Name:GetWide() + 5, self.Name.y + 3, 40, 16 )
	
	elseif self.Player:IsAdmin() then
		
		surface.SetMaterial( AdminIcon )
		surface.DrawTexturedRect( self.Name.x + self.Name:GetWide() + 5, self.Name.y + 3, 40, 16 )

	end
	
end

vgui.Register( "ScoreboardPlayer", PLAYER )



local PLAYERPING = {}
PLAYERPING.Padding = 8

function PLAYERPING:Init()

	self.Ping = Label( "99", self )
	self.Ping:SetFont( "ScoreboardPing" )
	self.Ping:SetColor( Color( 255, 255, 255 ) )
	
	self.Heights = { 3, 6, 9 }
	self.PingAmounts = { 300, 200, 100 }
	self.BaseSpacing = 5

end

function PLAYERPING:Update()

	local ping = self.Player:Ping()

	self.Ping:SetText( ping )
	self.PingVal = ping

end

function PLAYERPING:SetPlayer( ply )

	self.Player = ply
	self:Update()

end

function PLAYERPING:PerformLayout()

	self.Ping:SizeToContents()
	self.Ping:AlignRight()
	self.Ping:CenterVertical()

end

function PLAYERPING:Paint( w, h )

	local height = self.Ping:GetTall()
	local xpos = 40 - 10
	local x = xpos

	// BG
	surface.SetDrawColor( 255, 255, 255, 10 )

	for _, h in pairs( self.Heights ) do
		surface.DrawRect( x, height - h, 3, h )
		x = x + 4
	end

	// Lit/Main
	x = xpos
	surface.SetDrawColor( 255, 255, 255, 255 )

	for i=1, #self.Heights do

		local h = self.Heights[i]

		if self.PingVal < self.PingAmounts[i] then
			surface.DrawRect( x, height - h, 3, h )
		end

		x = x + 4

	end


	surface.SetTextColor( 255, 255, 255, 10 )
	surface.SetFont( "ScoreboardPing" )

	local zeros = "000"
	if self.PingVal >= 1 then zeros = "00" end
	if self.PingVal >= 10 then zeros = "0" end
	if self.PingVal >= 100 then zeros = "" end

	local w, h = surface.GetTextSize( zeros )
	surface.SetTextPos( self.Ping.x - w - 1, self.Ping.y )

	//Msg( zeros, "\n" )

	surface.DrawText( zeros )

end

vgui.Register( "ScoreboardPlayerPing", PLAYERPING )



local SERVERNAME = {}
SERVERNAME.Padding = 8

function SERVERNAME:Init()

	self.Name = Label( "Unknown", self )
	self.Name:SetFont( "ScoreboardServerName" )
	self.Name:SetColor( Color( 255, 255, 255 ) )

	self.MapName = Label( "Unknown", self )
	self.MapName:SetFont( "ScoreboardMapName" )
	self.MapName:SetColor( Color( 255, 255, 255 ) )

end

function SERVERNAME:Update()

	self.Name:SetText( GetHostName() )
	self.MapName:SetText( game.GetMap() )

end

function SERVERNAME:PerformLayout()

	self.Name:SizeToContents()
	self.Name:AlignLeft( self.Padding )
	self.Name:AlignTop( 1 )

	self.MapName:SizeToContents()
	self.MapName:AlignRight( self.Padding )
	self.MapName:AlignTop( 4 )
	
end

vgui.Register( "ScoreboardServerName", SERVERNAME )
