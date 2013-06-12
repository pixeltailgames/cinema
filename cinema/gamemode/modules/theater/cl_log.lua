module( "theater", package.seeall )

function Query( command )

	-- Ensure the log table exists
	if !sql.TableExists("cinema_requests") then
		
		Msg("Creating 'cinema_requests' table...\n")

		-- Initialize the database table
		sql.Query([[CREATE TABLE cinema_requests (
			id INTEGER PRIMARY KEY,
			title VARCHAR(32),
			url VARCHAR(2048),
			duration NUMERIC NOT NULL DEFAULT 0,
			count NUMERIC NOT NULL DEFAULT 0,
			lastRequest NUMERIC NOT NULL DEFAULT 0
		)]])

	end

	if command then
		-- Msg("QUERYING: " .. command .. "\n")
		return sql.Query( command )
	end

end

function ClearRequestHistory()
	return Query( "DROP TABLE cinema_requests" )
end

function RemoveRequestById( id )
	if !id then return end
	return Query( "DELETE FROM cinema_requests WHERE id=" .. id )
end

function GetRequestHistory()

	local results = Query( "SELECT * FROM cinema_requests" ) or {}

	if #results > 0 then
		results.duration = tonumber(results.duration)
		results.count = tonumber(results.count)
		results.lastRequest = tonumber(results.lastRequest)
	end

	return results

end

function LogRequest()

	local url = net.ReadString()
	local title = net.ReadString()
	local duration = net.ReadInt(32)

	-- Notify player of video added to queue
	AddAnnouncement( {
		'Theater_VideoAddedToQueue',
		title
	} )

	-- Escape strings
	title = sql.SQLStr(title)
	url = sql.SQLStr(url)

	local str = "SELECT count FROM cinema_requests WHERE " ..
		string.format("url=%s", url)

	local results = Query(str)

	-- Video exists in history
	if type(results) == "table" then

		local count = tonumber(results[1].count) + 1

		-- Increment count
		str = "UPDATE cinema_requests SET " ..
			string.format("lastRequest='%s', ", os.time()) ..
			string.format("count='%s' WHERE ", count) ..
			string.format("url=%s", url)

	else

		-- Insert new entry into the table
		str = "INSERT INTO cinema_requests " ..
			"(title,url,duration,count,lastRequest) " ..
			string.format("VALUES (%s, ", title) ..
			string.format("%s, ", url) ..
			string.format("'%s', ", duration) ..
			string.format("'%s', ", 1) ..
			string.format("'%s')", os.time())

	end

	return Query(str)

end
net.Receive( "PlayerVideoQueued", theater.LogRequest )