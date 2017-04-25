local draw = draw
local surface = surface
local math = math
local Color = Color
local ValidPanel = ValidPanel
local color_white = color_white

function draw.TheaterText(text, font, x, y, colour, xalign, yalign)
	draw.SimpleText(text, font, x, y + 4, Color(0,0,0,colour.a), xalign, yalign)
	draw.SimpleText(text, font, x + 1, y + 2, Color(0,0,0,colour.a), xalign, yalign)
	draw.SimpleText(text, font, x - 1, y + 2, Color(0,0,0,colour.a), xalign, yalign)
	draw.SimpleText(text, font, x, y, colour, xalign, yalign)
end

function draw.HTMLTexture( panel, w, h )

	if !panel or !ValidPanel(panel) then return end
	if !w or !h then return end
	
	panel:UpdateHTMLTexture()

	local pw, ph = panel:GetSize()

	-- Convert to scalar
	w = w / pw
	h = h / ph

	-- Fix for non-power-of-two html panel size
	pw = pw * (math.power2(pw) / pw)
	ph = ph * (math.power2(ph) / ph)

	local mat = panel:GetHTMLMaterial()

	if mat then
		surface.SetMaterial( mat )
		surface.DrawTexturedRect( 0, 0, w * pw, h * ph )
	else
		surface.DrawRect( 0, 0, w * pw, h * ph )
	end

end