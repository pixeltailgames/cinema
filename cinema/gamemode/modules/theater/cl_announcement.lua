module( "theater", package.seeall )

function AddAnnouncement( tbl )
	if type(tbl) != 'table' then return end
	chat.AddText( unpack(tbl) )
end

net.Receive( "TheaterAnnouncement", function()
	AddAnnouncement( net.ReadTable() )
end )