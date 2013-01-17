/*

	This editor is horribly broken and old, be warned.

	View:
	Left-click to rotate
	Right-click to zoom

	Tree:
	Right-click folders to spawn a player for finding offsets.
	Sliders on the rightside can be used for setting offsets.

	Run 'cinema_chaireditor' to open

	If you do end up using this for finding offsets, or for 
	fixing it, consider submitting a pull request to the Cinema
	gamemode with the additions.

	https://github.com/pixeltailgames/cinema

*/

-- Only change this if you're a developer!
if true then return end

ChairModels = {
	["Couch 01a"] = "models/props_interiors/furniture_couch01a.mdl",
	["Couch 02a"] = "models/props_interiors/furniture_couch02a.mdl",
	["Patio Table"] = "models/gmod_tower/patio_table.mdl",
	["Chair Stool01a"] = "models/props_c17/chair_stool01a.mdl",
	["Comfy Chair"] = "models/gmod_tower/comfychair.mdl",
	["Coaster"] = "models/XQM/coastertrain2seat.mdl",
	["Curved Couch"] = "models/sunabouzu/theater_curve_couch.mdl",
	["Theater Sofa"] = "models/sunabouzu/theater_sofa01.mdl",
}


DEBUG = false
LoadingItem = {}
CanUpdate = false
CopyData = {}

MainPanel = nil
HatsNodes = nil
ModelNodes = nil
ModelPanel = nil
ValuesList = {}

NODE_CHAIR = 1
NODE_SEAT = 2

function Open()

	Close()

	MainPanel = vgui.Create("DFrame")
	MainPanel:SetSize( 1280, 800 )
	MainPanel:SetTitle("Set chair offset")
	MainPanel:SetDeleteOnClose( true )
	//MainPanel.Close = Close

	//=======================================
	// == Panel list of models
	//=======================================
	ModelNodes = vgui.Create( "DTree", MainPanel )
	ModelNodes:Dock( LEFT )
	ModelNodes:SetWide( 160 )
	ModelNodes.DoClick = function( self, node )
		if node.Type == NODE_CHAIR then
			ModelPanel:SetModel(node.ModelPath)
		elseif node.Type == NODE_SEAT then
			ModelPanel:SetSeat(node)
		end
	end
	
	ModelNodes.DoRightClick = function( self, node )
		if node.Type == NODE_CHAIR then
			ModelNodes:AddSeat(node)
		elseif node.Type == NODE_SEAT then
			node.Seat = nil
			node:Remove()
		end
	end
	
	local FirstNode = nil	
	for k, v in pairs( ChairModels ) do
		local node = ModelNodes:AddNode( k )
		node.Type = NODE_CHAIR
		node.ModelName = k
		node.ModelPath = v
		
		if !FirstNode then
			FirstNode = node
		end
	end
	ModelNodes:SetSelectedItem( FirstNode )
	
	function ModelNodes:AddSeat(node)
		local node = node:AddNode( "Seat" )
		node.Type = NODE_SEAT
		node.ModelName = "Seat"
		node.Icon:SetImage( "gui/silkicons/emoticon_smile" )
		
		ModelPanel:AddSeat(node)
	end
	
	//=======================================
	// == MODEL PANEL
	//=======================================
	
	ModelPanel = vgui.Create("DChairEditor", MainPanel )
	ModelPanel:Dock( FILL )
	
	//=======================================
	// == SLIDERS
	//=======================================
	
	local TextValues = {"XPos", "YPos", "ZPos", "PAng", "YAng", "RAng", "Scale" }
	
	SliderPanel = vgui.Create( "DPanel", MainPanel )
	SliderPanel:Dock( RIGHT )
	SliderPanel:SetWide( 140 )
	
	for i=1, 7 do
	
		local panel = vgui.Create("DNumSlider", SliderPanel )
		panel:SetWide( 130 )
		panel:SetPos( 5, 50 * i )
		panel:SetText( TextValues[ i ] )
		//panel.OnValueChanged = RequestUpdate
		
		if i <= 3 then
			panel:SetMinMax( -100, 100 )
			panel:SetDecimals( 1 )
		elseif i == 7 then
			panel:SetMinMax( 0, 8 )
			panel:SetDecimals( 2 )
		else
			panel:SetMinMax( -180, 180 )
			panel:SetDecimals( 0 )
		end
		
		ValuesList[i] = panel
		
	end
	
	//=======================================
	// == COPY PASTE
	//=======================================
	
	local Copy = vgui.Create("DButton", MainPanel )
	Copy:SetText("COPY")
	Copy:SetSize( 100, 50 )
	Copy:SetPos( 200, 600 - 60 )
	Copy.DoClick = function()
		-- CopyData = table.Copy( GetTranslation() )
	end
	
	local Paste = vgui.Create("DButton", MainPanel )
	Paste:SetText("PASTE")
	Paste:SetSize( 100, 50 )
	Paste:SetPos( 310, 600 - 60 )
	Paste.DoClick = function()
	end
	
	//=======================================
	// == SORT ITEMS BY NAME
	//=======================================
	
	/*local Items = ModelNodes.Items
	table.sort( Items, function( a, b )
		return a.ModelName < b.ModelName	
	end )*/
	
	MainPanel:MakePopup()
	
end

function Close()
	
	ValuesList = {}
	MainPanel = nil
	HatsNodes = nil
	ModelNodes = nil
	ModelPanel = nil
	CanUpdate = false

end

function GetCurrentTranslations()
	return {
		ValuesList[1]:GetValue(),
		ValuesList[2]:GetValue(),
		ValuesList[3]:GetValue(),
		ValuesList[4]:GetValue(),
		ValuesList[5]:GetValue(),
		ValuesList[6]:GetValue(),
		ValuesList[7]:GetValue(),
	}
end

/*function RequestUpdate()

	for _, seat in ipairs(ModelPanel.Seats) do
	
		if IsValid(seat) && seat.Id == SeatNodes:GetSelectedItem().Id then
			seat.Offset = {
		end
	
	end

end*/

concommand.Add("cinema_chaireditor", Open )	

local PANEL = {}

AccessorFunc( PANEL, "m_fAnimSpeed", 	"AnimSpeed" )
AccessorFunc( PANEL, "Entity", 			"Entity" )
AccessorFunc( PANEL, "vCamPos", 		"CamPos" )
AccessorFunc( PANEL, "fFOV", 			"FOV" )
AccessorFunc( PANEL, "vLookatPos", 		"LookAt" )
AccessorFunc( PANEL, "colAmbientLight", "AmbientLight" )
AccessorFunc( PANEL, "colColor", 		"Color" )
AccessorFunc( PANEL, "bAnimated", 		"Animated" )


/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()

	self.Entity = nil
	self.Seats = {}
	
	self.LastPaint = 0
	self.DirectionalLight = {}
	
	self:SetCamPos( Vector( 50, 50, 50 ) )
	self:SetLookAt( Vector( 0, 0, 40 ) )
	self:SetFOV( 70 )
	
	self:SetText( "" )
	self:SetAnimSpeed( 0.5 )
	self:SetAnimated( false )
	
	self:SetAmbientLight( Color( 50, 50, 50 ) )
	
	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )
	
	self:SetColor( Color( 255, 255, 255, 255 ) )
	
	self.ViewAngles = Angle(0, 0, 0)
	self.HeadPos = Vector()
	self.ViewDistance = 20
	self.RightDrag = false
end

/*---------------------------------------------------------
   Name: SetDirectionalLight
---------------------------------------------------------*/
function PANEL:SetDirectionalLight( iDirection, color )
	self.DirectionalLight[iDirection] = color
end

function PANEL:ResetCamera()
	
	self:SetCamPos( self.ViewAngles:Forward() * self.ViewDistance )
	
end

/*---------------------------------------------------------
   Name: OnSelect
---------------------------------------------------------*/
function PANEL:SetModel( strModelName )

	Msg("SETTING MODEL: " .. strModelName .. "\n")

	// Note - there's no real need to delete the old 
	// entity, it will get garbage collected, but this is nicer.
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil		
	end
	
	// Note: Not in menu dll
	if ( !ClientsideModel ) then return end
	
	self.Entity = ClientsideModel( strModelName, RENDER_GROUP_OPAQUE_ENTITY )
	if ( !IsValid(self.Entity) ) then return end
	
	//self.Entity:SetNoDraw( true )
end

/*---------------------------------------------------------
   Name: OnSelect
---------------------------------------------------------*/
function PANEL:SetSeat(node)

	// Note: Not in menu dll
	if ( !ClientsideModel ) then return end
	
	for _, seat in ipairs(self.Seats) do
		if seat.Node == node then
			self.SelectedSeat = seat
		end
	end
	
	table.insert( self.Seats, seat )
	
end

/*---------------------------------------------------------
   Name: OnSelect
---------------------------------------------------------*/
function PANEL:AddSeat(node)

	// Note: Not in menu dll
	if ( !ClientsideModel ) then return end
	
	local seat = ClientsideModel( "models/player/kleiner.mdl", RENDER_GROUP_OPAQUE_ENTITY )
	seat:ResetSequence(seat:LookupSequence( "sit" ))
	seat.Offset = seat:GetBonePosition(seat:LookupBone("ValveBiped.Bip01_Pelvis")) + Vector(0,0,4)
	seat.Node = node
	node.Seat = seat
	
	table.insert( self.Seats, seat )
	
end


/*---------------------------------------------------------
   Name: OnMousePressed
---------------------------------------------------------*/
function PANEL:Paint()

	if ( !IsValid( self.Entity ) ) then return end
	//if ( !IsValid( self.Seats ) ) then return end
	
	local x, y = self:LocalToScreen( 0, 0 )

	self:LayoutEntity( self.Entity )
	
	cam.Start3D( self.vCamPos, (self.vLookatPos-self.vCamPos):Angle(), self.fFOV, x, y, self:GetWide(), self:GetTall() )
		cam.IgnoreZ( true )
		
		render.SuppressEngineLighting( true )
		render.SetLightingOrigin( self.Entity:GetPos() )
		render.ResetModelLighting( self.colAmbientLight.r/255, self.colAmbientLight.g/255, self.colAmbientLight.b/255 )
		render.SetColorModulation( self.colColor.r/255, self.colColor.g/255, self.colColor.b/255 )
		render.SetBlend( self.colColor.a/255 )
		
		for i=0, 6 do
			local col = self.DirectionalLight[ i ]
			if ( col ) then
				render.SetModelLighting( i, col.r/255, col.g/255, col.b/255 )
			end
		end
		
		self.Entity:DrawModel()
		
		local Trans = GetCurrentTranslations()
		local pos, ang = Vector(Trans[1],Trans[2],Trans[3]), Angle(Trans[4],Trans[5],Trans[6])
		
		local seat = self.SelectedSeat
		if IsValid(seat) then
			seat.Pos = pos
			seat.Ang = ang
			seat:SetPos( seat.Pos - seat.Offset )
			seat:SetAngles( seat.Ang )
			seat:DrawModel()
		end
		
		for _, ent in ipairs(self.Seats) do
			if IsValid(ent) && ent != seat then
				if ent.Pos then
					ent:SetPos( ent.Pos - ent.Offset )
				else
					ent:SetPos( pos - ent.Offset )
				end
				
				ent:SetAngles( ang )
				ent:SetPos( pos )
				
				ent:DrawModel()
			end
		end
		
		render.SuppressEngineLighting( false )
		cam.IgnoreZ( false )
	cam.End3D()
	
	self.LastPaint = RealTime()
	
end

/*---------------------------------------------------------
   Name: RunAnimation
---------------------------------------------------------*/
function PANEL:RunAnimation()
	for _, seat in ipairs(self.Seats) do
		if IsValid(seat) then
			seat:FrameAdvance( (RealTime()-self.LastPaint) * self.m_fAnimSpeed )
		end
	end
end

/*---------------------------------------------------------
   Name: LayoutEntity
---------------------------------------------------------*/
function PANEL:LayoutEntity( Entity )

	//
	// This function is to be overriden
	//

	//if ( self.bAnimated ) then
	//	self:RunAnimation()
	//end
	
	//Entity:SetAngles( Angle( 0, RealTime()*10,  0) )

end

function PANEL:OnMousePressed( mousecode )
	self.Dragging = { gui.MouseX(), gui.MouseY() }
	self:MouseCapture( true )
	self.RightDrag = mousecode == MOUSE_LEFT
end

function PANEL:OnMouseReleased()
	self.Dragging = nil
	self:MouseCapture( false )
end

function PANEL:Think()

	if self.Dragging then
		if self.RightDrag then
			self.ViewAngles:RotateAroundAxis( self.ViewAngles:Up(), gui.MouseX() - self.Dragging[1] )
			self.ViewAngles:RotateAroundAxis( self.ViewAngles:Right(), self.Dragging[2] - gui.MouseY() )
		else
			self.ViewDistance = self.ViewDistance + (self.Dragging[1] - gui.MouseX()) * 0.1
		end
		
		self.Dragging = { gui.MouseX(), gui.MouseY() }
		
		self:ResetCamera()
	end

end

derma.DefineControl( "DChairEditor", "Chair offset editor", PANEL, "DButton" )