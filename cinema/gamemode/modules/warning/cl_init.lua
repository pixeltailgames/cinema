local color_box_bg = Color(0,0,0,200)
local WarningFont = "WarningFont"
surface.CreateFont( WarningFont, { font = "Open Sans Condensed Light", size = 28, weight = 200 } )

local pairs = pairs
local ScrW = ScrW
local draw = draw
local hook = hook
local surface = surface
local table = table

module( "warning" )

local HookName = "DrawWarningMessage"
local Messages = {}

function Set( ... )
	Clear()
	Add(...)
end

function Add( ... )
	table.Add( Messages, {...} )
	hook.Add( "HUDPaint", HookName, Draw )
end

function Clear()
	hook.Remove( "HUDPaint", HookName )
	table.Empty( Messages )
end

local p = 10
local w, h, hoffset
function Draw()

	surface.SetFont( WarningFont )

	for k, msg in pairs( Messages ) do

		w, h = surface.GetTextSize( msg )

		hoffset = ((h * k) - h) * 2

		draw.RoundedBox( 4, (ScrW() / 2) - w / 2 - p, h - p + hoffset, w + p * 2, h + p * 2, color_box_bg )
		draw.SimpleText( msg, WarningFont, ScrW() / 2 - w / 2, hoffset + h, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )

	end

end