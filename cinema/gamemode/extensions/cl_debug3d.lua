
module( "Debug3D", package.seeall )


// the material to use when drawing edges in space
DebugMat = Material( "effects/tool_tracer" )

// draws an outlined box in 3d space with the specified color
function DrawBox( vecStart, vecEnd, color )

	local min = vecStart
	local max = vecEnd
	
	if ( min:Length() > max:Length() ) then
		local temp = min
		min = max
		max = temp
	end
	
	// borrowed from gmt's invload_box
	render.SetMaterial( DebugMat )
	local texcoord = math.Rand( 0, 1 )
	local function DrawBeam( startpos, endpos )
		render.DrawBeam( startpos, endpos, 8, 0, texcoord, color or Color( 255, 255, 255, 255 ) )
	end
	
	//Bottom face
	DrawBeam( Vector( min.x, min.y, min.z ), Vector( max.x, min.y, min.z ) )
	DrawBeam( Vector( min.x, min.y, min.z ), Vector( min.x, max.y, min.z ) )
	DrawBeam( Vector( max.x, max.y, min.z ), Vector( min.x, max.y, min.z ) )
	DrawBeam( Vector( max.x, max.y, min.z ), Vector( max.x, min.y, min.z ) )
	
	//Top face
	DrawBeam( Vector( min.x, min.y, max.z ), Vector( max.x, min.y, max.z ) )
	DrawBeam( Vector( min.x, min.y, max.z ), Vector( min.x, max.y, max.z ) )
	DrawBeam( Vector( max.x, max.y, max.z ), Vector( min.x, max.y, max.z ) )
	DrawBeam( Vector( max.x, max.y, max.z ), Vector( max.x, min.y, max.z ) )
	
	//All 4 sides
	DrawBeam( Vector( min.x, min.y, max.z ), Vector( min.x, min.y, min.z ) )
	DrawBeam( Vector( min.x, max.y, max.z ), Vector( min.x, max.y, min.z ) )
	DrawBeam( Vector( max.x, max.y, max.z ), Vector( max.x, max.y, min.z ) )
	DrawBeam( Vector( max.x, min.y, max.z ), Vector( max.x, min.y, min.z ) )
	
end

// draws 3d2d'd text in 3d space
// the text will be centered at the position
function DrawText( vecPos, strText, strFont, color, scale )

	if ( !strFont ) then
		strFont = "Default"
	end
	
	if ( !color ) then
		color = Color( 255, 255, 255, 255 )
	end
	
	if ( !scale ) then
		scale = 1
	end
	
	local ang = LocalPlayer():EyeAngles()
	
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	
	surface.SetFont( strFont )
	
	local width, height = surface.GetTextSize( strText )
	height = height * scale
	
	cam.Start3D2D( vecPos + Vector( 0, 0, height / 2 ), Angle( 0, ang.y, 90 ), scale )
		draw.DrawText( strText, strFont, 0, 0, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	cam.End3D2D()

end
