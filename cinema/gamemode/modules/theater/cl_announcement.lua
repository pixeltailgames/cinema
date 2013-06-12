module( "theater", package.seeall )

function AddAnnouncement( tbl )
	if type(tbl) != 'table' then return end

	local key = table.remove(tbl, 1)
	local values = translations.FormatChat( key, unpack(tbl) )
	chat.AddText( ColDefault, unpack(values) )
end

net.Receive( "TheaterAnnouncement", function()
	AddAnnouncement( net.ReadTable() )
end )