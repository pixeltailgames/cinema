


function string.hash( str )
	
	local bytes = {string.byte( str, 0, string.len( str ) )}
	local hash = 0
	
	//0x07FFFFFF
	//It is a sequrence of 31 "1".
	//If it was a sequence of 32 "1", it would not be able to send over network as a positive number
	//Now it must be 27 "1", because DTVarInt hates 31... Do not ask why...
	for _, v in ipairs( bytes ) do
		hash = math.fmod( v + ((hash*32) - hash ), 0x07FFFFFF )
	end
	
	return hash
	
end

function string.FormatSeconds(sec)

	local hours = math.floor(sec / 3600)
	local minutes = math.floor((sec % 3600) / 60)
	local seconds = sec % 60

	if minutes < 10 then
		minutes = "0" .. tostring(minutes)
	end

	if seconds < 10 then
		seconds = "0" .. tostring(seconds)
	end

	if hours > 0 then
		return string.format("%s:%s:%s", hours, minutes, seconds)
	else
		return string.format("%s:%s", minutes, seconds)
	end

end

function string.reduce( str, font, width )

	surface.SetFont( font )

	local tw, th = surface.GetTextSize(str)
	while tw > width do
		str = string.sub( str, 1, string.len(str) - 1 )
		tw, th = surface.GetTextSize(str)
	end

	return str

end

function string.findFromTable( str, tbl )

	for _, v in pairs( tbl ) do
		if string.find( str, v ) then
			return true
		end
	end

	return false

end