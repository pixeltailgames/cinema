/*----------------------------------------------------------------------
	2.4 Changelog
	- Removed arm for melee holdtype, it just did not look good in many cases, mainly because they don't animate while attacking
	- Made legs move forward as you look up, looks as if you are bending over to look down or something. It's definitly an improvement.
		* Added option to revert to use the old mode. ( cl_legs_leanmode 0 will revert to the old way )
	- Moved the legs forward a small amount
	- Corrected vehicle pose parameter value ( This just adjusts where the arms are at on the steering wheel )
	- Fixed ducking in air making the legs z position move up. This is determined by the size of the players ducked hull and there is no way to get it
	- Added two global functions for third party modification
		* ShouldDrawLegs() -- Will return if the legs should be rendered for that frame
		* GetLocalPlayersLegs() -- Will return the leg entity if visible, if not visible it returns local player
	- Fixed legs drawing while spectating another entity ( Example: Catdaemon's shuttle )
	- Fixed certain models showing as errors
*/----------------------------------------------------------------------

/*----------------------------------------------------------------------
	Modified for Elevator: Source
*/----------------------------------------------------------------------

local Legs = {}
Legs.LegEnt = nil

function ShouldDrawLegs()
	return 	Legs.EnabledVar and Legs.EnabledVar:GetBool() and
			IsValid( Legs.LegEnt ) and
			( LocalPlayer():Alive() or ( LocalPlayer().IsGhosted and LocalPlayer():IsGhosted() ) ) and
			-- !Legs:CheckDrawVehicle() and
			GetViewEntity() == LocalPlayer() and
			!LocalPlayer():ShouldDrawLocalPlayer() and
			!LocalPlayer():GetObserverTarget() and
			!LocalPlayer().ShouldDisableLegs
end

--[[You can't really get another players legs, so we return the player back.
This would just simplify render hooks if you wanted to change the appearance
of a players model and make the legs mimic that change.
Seeing how you are probably going to be using this for a players model, we return
the legs if they are visible. If they aren't visible, then your playermodel might be
so we return back the localplayer. Confusing, but makes things really simple.

Example of usage below.

local MatWireFrame = Material( "models/wireframe" )
hook.Add( "RenderScreenspaceEffects", "RenderWireFrame", function() -- Will render all players with a wireframe overlay.
	for k,v in ipairs( player.GetAll() ) do
		SetMaterialOverride( MatWireFrame )
			GetPlayerLegs( ply ):DrawModel() -- If the player is the local player, it returns their legs if visible so we can make our legs have the same effect applied to it all with one simple line
		SetMaterialOverride( nil )
	end
end )]]
function GetPlayerLegs( ply )
	return ply and ply != LocalPlayer() and ply or ( ShouldDrawLegs() and Legs.LegEnt or LocalPlayer() )
end

Legs.EnabledVar = CreateConVar( "cl_legs", "1", { FCVAR_ARCHIVE, }, "Enable/Disable the rendering of the legs" )
//Legs.VehicleDrawVar = CreateConVar( "cl_legs_vehicle", "0", { FCVAR_ARCHIVE, }, "Enable/Disable the rendering of the legs in a vehicle" )
//Legs.LeanMode = CreateConVar( "cl_legs_leanmode", "0", { FCVAR_ARCHIVE, }, "Enable/Disable the adjusting of the legs forward/backwards position determined by eye pitch" )

function Legs:SetUp() -- Creates our legs

	self.LegEnt = ClientsideModel( LocalPlayer():GetTranslatedModel(), RENDER_GROUP_OPAQUE_ENTITY )
	self.LegEnt:SetNoDraw( true ) -- We render the model differently
	self.LegEnt.LastTick = 0

	// Set player properties
	LocalPlayer():SetProperties( self.LegEnt )

end

-- Temporary values
Legs.PlaybackRate = 1
Legs.Sequence = nil
Legs.Velocity = 0
Legs.OldWeapon = nil
Legs.HoldType = nil

-- Can change to whatever you want, I think these two look best
Legs.BoneHoldTypes = { ["none"] = {
							"ValveBiped.Bip01_Head1",
							"ValveBiped.Bip01_Neck1"
						},
						["default"] = { -- The default bones to be hidden if there is no hold type bones
							"ValveBiped.Bip01_Head1",
							"ValveBiped.Bip01_Neck1"
						},
						["vehicle"] = { -- Bones that are deflated while in a vehicle
							"ValveBiped.Bip01_Head1",
							"ValveBiped.Bip01_Neck1"
						},
						["crouched"] = { -- Bones that are deflated while crouched
							"ValveBiped.Bip01_L_Hand",
							"ValveBiped.Bip01_L_Forearm",
							"ValveBiped.Bip01_L_Upperarm",
							"ValveBiped.Bip01_L_Clavicle",
							"ValveBiped.Bip01_R_Hand",
							"ValveBiped.Bip01_R_Forearm",
							"ValveBiped.Bip01_R_Upperarm",
							"ValveBiped.Bip01_R_Clavicle",
							"ValveBiped.Bip01_L_Finger4", "ValveBiped.Bip01_L_Finger41", "ValveBiped.Bip01_L_Finger42",
							"ValveBiped.Bip01_L_Finger3", "ValveBiped.Bip01_L_Finger31", "ValveBiped.Bip01_L_Finger32",
							"ValveBiped.Bip01_L_Finger2", "ValveBiped.Bip01_L_Finger21", "ValveBiped.Bip01_L_Finger22",
							"ValveBiped.Bip01_L_Finger1", "ValveBiped.Bip01_L_Finger11", "ValveBiped.Bip01_L_Finger12",
							"ValveBiped.Bip01_L_Finger0", "ValveBiped.Bip01_L_Finger01", "ValveBiped.Bip01_L_Finger02",
							"ValveBiped.Bip01_R_Finger4", "ValveBiped.Bip01_R_Finger41", "ValveBiped.Bip01_R_Finger42",
							"ValveBiped.Bip01_R_Finger3", "ValveBiped.Bip01_R_Finger31", "ValveBiped.Bip01_R_Finger32",
							"ValveBiped.Bip01_R_Finger2", "ValveBiped.Bip01_R_Finger21", "ValveBiped.Bip01_R_Finger22",
							"ValveBiped.Bip01_R_Finger1", "ValveBiped.Bip01_R_Finger11", "ValveBiped.Bip01_R_Finger12",
							"ValveBiped.Bip01_R_Finger0", "ValveBiped.Bip01_R_Finger01", "ValveBiped.Bip01_R_Finger02"
						}
					}
				
Legs.BonesToRemove = {}
Legs.BoneMatrix = nil

function Legs:WeaponChanged( weap ) --Different bones will be visible for different hold types
	if IsValid( self.LegEnt ) then
		if IsValid( weap ) then
			self.HoldType = weap:GetHoldType()
		else
			self.HoldType = "none"
		end

		-- Reset all bones
		for boneId = 0, self.LegEnt:GetBoneCount() do
			self.LegEnt:ManipulateBoneScale(boneId, Vector(1,1,1))
			self.LegEnt:ManipulateBonePosition(boneId, Vector(0,0,0))
		end

		-- Remove bones from being seen
		Legs.BonesToRemove = {
			"ValveBiped.Bip01_Head1"
		}
		if !LocalPlayer():InVehicle() then
			Legs.BonesToRemove = Legs.BoneHoldTypes[ Legs.HoldType ] or Legs.BoneHoldTypes[ "default" ]

			if LocalPlayer():KeyDown( IN_DUCK ) then
				Legs.BonesToRemove = Legs.BoneHoldTypes[ "crouched" ]
			end

		else
			Legs.BonesToRemove = Legs.BoneHoldTypes[ "vehicle" ]
		end

		for _, v in pairs( Legs.BonesToRemove ) do -- Loop through desired bones
			local boneId = self.LegEnt:LookupBone(v)
			if boneId then
				self.LegEnt:ManipulateBoneScale(boneId, vector_origin)
				self.LegEnt:ManipulateBonePosition(boneId, Vector(-10,-10,0))
			end
		end
	end
end

Legs.BreathScale = 0.5
Legs.NextBreath = 0

function Legs:Think( maxseqgroundspeed )
	if IsValid( self.LegEnt ) then
		if LocalPlayer():GetActiveWeapon() != self.OldWeapon then -- Player switched weapons, change the bones for new weapon
			self.OldWeapon = LocalPlayer():GetActiveWeapon()
			self:WeaponChanged( self.OldWeapon )
		end
		
		if self.LegEnt:GetModel() != LocalPlayer():GetTranslatedModel() then --Player changed model without spawning?
			self.LegEnt:SetModel( LocalPlayer():GetTranslatedModel() )
			--print( LocalPlayer():GetModel(), self:FixModelName( LocalPlayer():GetModel() ) )
		end
		
		-- START of Crouch Workaround
		-- Reset all bones
		for boneId = 0, self.LegEnt:GetBoneCount() do
			self.LegEnt:ManipulateBoneScale(boneId, Vector(1,1,1))
			self.LegEnt:ManipulateBonePosition(boneId, Vector(0,0,0))
		end
		
		-- Remove bones from being seen
		Legs.BonesToRemove = {
			"ValveBiped.Bip01_Head1"
		}
		if !LocalPlayer():InVehicle() then
			Legs.BonesToRemove = Legs.BoneHoldTypes[ Legs.HoldType ] or Legs.BoneHoldTypes[ "default" ]

			if LocalPlayer():KeyDown( IN_DUCK ) then
				Legs.BonesToRemove = Legs.BoneHoldTypes[ "crouched" ]
			end

		else
			Legs.BonesToRemove = Legs.BoneHoldTypes[ "vehicle" ]
		end

		for _, v in pairs( Legs.BonesToRemove ) do -- Loop through desired bones
			local boneId = self.LegEnt:LookupBone(v)
			if boneId then
				self.LegEnt:ManipulateBoneScale(boneId, vector_origin)
				self.LegEnt:ManipulateBonePosition(boneId, Vector(-10,-10,0))
			end
		end
		-- END of Crouch Workaround
		
		self.LegEnt:SetMaterial( LocalPlayer():GetMaterial() )
		self.LegEnt:SetSkin( LocalPlayer():GetSkin() )
		for _, group in pairs(LocalPlayer():GetBodyGroups()) do
			self.LegEnt:SetBodygroup(group["id"], LocalPlayer():GetBodygroup(group["id"]))
		end

		self.Velocity = LocalPlayer():GetVelocity():Length2D()
		
		self.PlaybackRate = 1

		if self.Velocity > 0.5 then -- Taken from the SDK, gets the proper play back rate
			if maxseqgroundspeed < 0.001 then
				self.PlaybackRate = 0.01
			else
				self.PlaybackRate = self.Velocity / maxseqgroundspeed
				self.PlaybackRate = math.Clamp( self.PlaybackRate, 0.01, 10 )
			end
		end
		
		self.LegEnt:SetPlaybackRate( self.PlaybackRate ) -- Change the rate of playback. This is for when you walk faster/slower
		
		self.Sequence = LocalPlayer():GetSequence()
		
		if ( self.LegEnt.Anim != self.Sequence ) then -- If the player changes sequences, change the legs too
			self.LegEnt.Anim = self.Sequence
			self.LegEnt:ResetSequence( self.Sequence )
		end
		
		self.LegEnt:FrameAdvance( CurTime() - self.LegEnt.LastTick ) -- Advance the amount of frames we need
		self.LegEnt.LastTick = CurTime()
		
		Legs.BreathScale = sharpeye and sharpeye.GetStamina and math.Clamp( math.floor( sharpeye.GetStamina() * 5 * 10 ) / 10, 0.5, 5 ) or 0.5 -- More compatability for sharpeye. This changes the models breathing paramaters to go off of sharpeyes stamina system
		
		if Legs.NextBreath <= CurTime() then -- Only update every cycle, should stop MOST of the jittering
			Legs.NextBreath = CurTime() + 1.95 / Legs.BreathScale
			self.LegEnt:SetPoseParameter( "breathing", Legs.BreathScale )
		end
		
		self.LegEnt:SetPoseParameter( "move_x", ( LocalPlayer():GetPoseParameter( "move_x" ) * 2 ) - 1 ) -- Translate the walk x direction
		self.LegEnt:SetPoseParameter( "move_y", ( LocalPlayer():GetPoseParameter( "move_y" ) * 2 ) - 1 ) -- Translate the walk y direction
		self.LegEnt:SetPoseParameter( "move_yaw", ( LocalPlayer():GetPoseParameter( "move_yaw" ) * 360 ) - 180 ) -- Translate the walk direction
		self.LegEnt:SetPoseParameter( "body_yaw", ( LocalPlayer():GetPoseParameter( "body_yaw" ) * 180 ) - 90 ) -- Translate the body yaw
		self.LegEnt:SetPoseParameter( "spine_yaw",( LocalPlayer():GetPoseParameter( "spine_yaw" ) * 180 ) - 90 ) -- Translate the spine yaw
		
		if ( LocalPlayer():InVehicle() ) then
			self.LegEnt:SetColor( color_transparent )
			self.LegEnt:SetRenderMode( RENDERMODE_TRANSALPHA )
			self.LegEnt:SetPoseParameter( "vehicle_steer", ( LocalPlayer():GetVehicle():GetPoseParameter( "vehicle_steer" ) * 2 ) - 1 ) -- Translate the vehicle steering
		end
	end
end

hook.Add( "UpdateAnimation", "Legs:UpdateAnimation", function( ply, velocity, maxseqgroundspeed )
	if ply == LocalPlayer() then
		if IsValid( Legs.LegEnt ) then
			Legs:Think( maxseqgroundspeed ) -- Called every frame. Pass the ground speed for later use
		else
			Legs:SetUp() -- No legs, create them. Should only be called once
		end
	end
end )

-- More temp. shit
Legs.RenderAngle = nil
Legs.BiaisAngle = nil
Legs.RadAngle = nil
Legs.RenderPos = nil
Legs.RenderColor = {}
Legs.ClipVector = vector_up * -1
Legs.ForwardOffset = -24

function Legs:CheckDrawVehicle() -- Will return true if the player is in a vehicle and NOT in third person, or the player is not in a vehicle
	return LocalPlayer():InVehicle()
end

hook.Add( "RenderScreenspaceEffects", "Legs:Render", function() -- Need to find a better place to render. Legs half-way in water = looks like they are clipped
	cam.Start3D( EyePos(), EyeAngles() )
		if ShouldDrawLegs() then -- Render check
		
			Legs.RenderPos = LocalPlayer():GetPos()
			if LocalPlayer():InVehicle() then -- The player is in a vehicle, so we use the vehicles angles, not the LocalPlayer
				Legs.RenderAngle = LocalPlayer():GetVehicle():GetAngles()
				Legs.RenderAngle:RotateAroundAxis( Legs.RenderAngle:Up(), 90 ) -- Fix it
			else -- This calculates the offset behind the player, adjust the -22 if you want to move it
				Legs.BiaisAngles = sharpeye_focus and sharpeye_focus.GetBiaisViewAngles and sharpeye_focus:GetBiaisViewAngles() or LocalPlayer():EyeAngles() -- Compatability for SharpEye
				Legs.RenderAngle = Angle( 0, Legs.BiaisAngles.y, 0 )
				Legs.RadAngle = math.rad( Legs.BiaisAngles.y )
				Legs.ForwardOffset = -22
				Legs.RenderPos.x = Legs.RenderPos.x + math.cos( Legs.RadAngle ) * Legs.ForwardOffset
				Legs.RenderPos.y = Legs.RenderPos.y + math.sin( Legs.RadAngle ) * Legs.ForwardOffset
				
				if LocalPlayer():GetGroundEntity() == NULL then -- Crappy duck fix
					Legs.RenderPos.z = Legs.RenderPos.z + 8
					if LocalPlayer():KeyDown( IN_DUCK ) then
						Legs.RenderPos.z = Legs.RenderPos.z - 28
					end
				end
			end
			
			Legs.RenderColor = LocalPlayer():GetColor()
			
			local bEnabled = render.EnableClipping( true )
				render.PushCustomClipPlane( Legs.ClipVector, Legs.ClipVector:Dot( EyePos() ) ) -- Clip the model so if we look up we should never see any part of the legs model
					render.SetColorModulation( Legs.RenderColor.r / 255, Legs.RenderColor.g / 255, Legs.RenderColor.b / 255 ) -- Render the color correctly
						render.SetBlend( Legs.RenderColor.a / 255 )
							hook.Call( "PreLegsDraw", GAMEMODE, Legs.LegEnt )
							--cam.IgnoreZ( true ) --Attempted to give them draw priority over the world. Works, but they are drawn above view model ToDo: Fix
								Legs.LegEnt:SetRenderOrigin( Legs.RenderPos )
								Legs.LegEnt:SetRenderAngles( Legs.RenderAngle )
								Legs.LegEnt:SetupBones()
								Legs.LegEnt:DrawModel()
								Legs.LegEnt:SetRenderOrigin()
								Legs.LegEnt:SetRenderAngles()
							--cam.IgnoreZ( false )
							hook.Call( "PostLegsDraw", GAMEMODE, Legs.LegEnt )
						render.SetBlend( 1 )
					render.SetColorModulation( 1, 1, 1 )
				render.PopCustomClipPlane()
			render.EnableClipping( bEnabled )
		end
	cam.End3D()
end )
