surface.CreateFont( "VideoInfoLarge", {
	font      = "Open Sans Condensed",
	size      = 148,
	weight    = 700,
	antialias = true
})

surface.CreateFont( "VideoInfoMedium", {
	font      = "Open Sans Condensed",
	size      = 72,
	weight    = 700,
	antialias = true
})

surface.CreateFont( "VideoInfoSmall", {
	font      = "Open Sans Condensed",
	size      = 32,
	weight    = 700,
	antialias = true
})

local gradientDown = surface.GetTextureID("VGUI/gradient_down")
local refreshTexture = surface.GetTextureID("gui/html/refresh")

module( "theater", package.seeall )

LastInfoDraw = 0
InfoDrawDelay = 3

LastTheater = nil
Pos = Vector(0,0,0)
Ang = Angle(0,0,0)
InfoScale = 1
w = 0
h = 0

local LoadingStr = T'Loading'

function DrawActiveTheater( bDrawingDepth, bDrawingSkybox )

	if input.IsKeyDown(KEY_Q) then
		LastInfoDraw = CurTime()
	end

	if theater.Fullscreen then return end -- Don't render twice

	if !LastTheater then

		local Theater = LocalPlayer().GetTheater and LocalPlayer():GetTheater() or nil
		if !Theater then
			LastTheater = nil
			return
		end

		local ang = Theater:GetAngles()
		Ang = Angle( ang.p, ang.y, ang.r ) -- don't modify actual theater angle
		Ang:RotateAroundAxis( Ang:Forward(), 90 )

		Pos = Theater:GetPos() + Ang:Right() * 0.01

		w, h = Theater:GetSize()
		InfoScale = w / 10300 -- 10300 seems to produce a good scale

		LastTheater = Theater

	end

	cam.Start3D2D( Pos, Ang, 0.1 )

		-- Draw 'Loading...' incase page takes too long to load
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, w, h )
		draw.SimpleText( LoadingStr, "VideoInfoLarge", w / 2, h / 2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		draw.HTMLTexture( theater.ActivePanel(), w, h )

	cam.End3D2D()

	if LastInfoDraw + InfoDrawDelay > CurTime() then
		cam.Start3D2D( Pos, Ang, InfoScale )	
				pcall( theater.DrawVideoInfo, w, h, InfoScale )
		cam.End3D2D()
	end

end
hook.Add( "PostDrawOpaqueRenderables", "DrawTheaterScreen", DrawActiveTheater )

local LastTitle = ""
local WasFullscreen = false
local Title = ""
local panel
function DrawVideoInfo( w, h, scale )

	panel = ActivePanel()
	if !ValidPanel(panel) then return end

	local Video = CurrentVideo()
	if !Video then return end

	scale = scale and (1 / scale) * 0.1 or 1 -- scale for screen size fix

	w = w and w * scale or panel:GetWide()
	h = h and h * scale or panel:GetTall()

	-- TODO: Animate things
	-- local fade = math.Clamp((lastInfoView - CurTime()) / 2, 0, 1) * 255

	/* Top Info Background */
	surface.SetDrawColor(0,0,0,255)
	surface.SetTexture(gradientDown)
	surface.DrawTexturedRect(0, 0, w, h)

	-- Attempt to fix white line rendering artifact
	surface.DrawRect(0, -2, w, 4)

	-- Title
	if LastTitle != T( Video:Title() ) or WasFullscreen != theater.Fullscreen then
		LastTitle = T( Video:Title() )
		WasFullscreen = theater.Fullscreen
		Title = string.reduce( LastTitle, "VideoInfoMedium", w )
	end
	draw.TheaterText( Title, "VideoInfoMedium", 10, 10, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	-- Volume
	draw.TheaterText( T('Volume'):upper(), "VideoInfoSmall", w - 72, 120, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.TheaterText( GetVolume() .. "%", "VideoInfoMedium", w - 72, 136, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	-- Vote Skips
	if NumVoteSkips > 0 then
		draw.TheaterText( T('Voteskips'):upper(), "VideoInfoSmall", w - 72, 230, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.TheaterText( NumVoteSkips .. "/" .. ReqVoteSkips, "VideoInfoMedium", w - 72, 246, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	end

	-- Timed video info
	if theater.IsVideoTimed(Video:Type()) then
		local current = (CurTime() - Video:StartTime())
		local percent = math.Clamp( (current / Video:Duration() ) * 100, 0, 100 )

		-- Bar
		local bh = h * 1/32
		draw.RoundedBox( 0, 0, h - bh, w, bh, Color(0,0,0,200) )
		draw.RoundedBox( 0, 0, h - bh, w * (percent/100), bh, Color( 255, 255, 255, 255 ) )

		-- Current Time
		local strSeconds = string.FormatSeconds(math.Clamp(math.Round(current), 0, Video:Duration()))
		draw.TheaterText( strSeconds, "VideoInfoMedium", 16, h - bh, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )

		-- Duration
		local strDuration = string.FormatSeconds(Video:Duration())
		draw.TheaterText( strDuration, "VideoInfoMedium", w - 16, h - bh, Color(255,255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	end

	-- Loading indicater
	if panel:IsLoading() then
		surface.SetDrawColor(255,255,255,255)
		surface.SetTexture(refreshTexture)
		surface.DrawTexturedRectRotated( 32, 128, 64, 64, RealTime() * -256 )
	end

end

function DrawFullscreen()

	if Fullscreen then

		draw.HTMLTexture( ActivePanel(), ScrW(), ScrH() )

		if LastInfoDraw + InfoDrawDelay > CurTime() then
			DrawVideoInfo( ScrW(), ScrH(), 0.1 )
		end

	end

end
hook.Add( "HUDPaint", "DrawFullscreenInfo", DrawFullscreen )
