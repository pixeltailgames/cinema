module( "theater", package.seeall )

function Query( command )
	
	local updated = sql.Query( "SELECT vtype FROM cinema_requests" )
	
	if !updated then -- The Query will return a false bool if the column doesn't exist
		print("Altering 'cinema_requests' table for updated structure...")
		Query( "ALTER TABLE cinema_requests ADD vtype VARCHAR(32)" )
		Query( "ALTER TABLE cinema_requests ADD vdata VARCHAR(2048)" )
	end
	
	-- Ensure the log table exists
	if !sql.TableExists("cinema_requests") then
		
		Msg("Creating 'cinema_requests' table...\n")

		-- Initialize the database table
		sql.Query([[CREATE TABLE cinema_requests (
			id INTEGER PRIMARY KEY,
			title VARCHAR(32),
			url VARCHAR(2048),
			vtype VARCHAR(32),
			vdata VARCHAR(2048),
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

local function CheckDuplicates(url, title, duration, vtype, vdata)
	local str = "SELECT id,count FROM cinema_requests WHERE " .. -- Run it again, in case a New Entry was just added
		string.format("vtype=%s AND ", vtype) ..
		string.format("vdata=%s", vdata)

	local results = Query(str)
	local count = 0
	
	if results and #results > 1 then -- Check for multiple entries for same video type and data
		print("Duplicate entries in 'cinema_requests' for vtype=" ..vtype.. " and vdata=" ..vdata.. ", fixing...")
		for vidkey, vid in pairs(results) do
			count = count + vid.count
			if vidkey > 1 then -- Don't delete the first entry!
				RemoveRequestById( vid.id )
			end
		end
		
		-- Update request count, duplicate detected
		str = "UPDATE cinema_requests SET " ..
			string.format("lastRequest='%s', ", os.time()) ..
			string.format("url=%s, ", url) ..
			string.format("count='%s' WHERE ", count) ..
			string.format("vtype=%s AND ", vtype) ..
			string.format("vdata=%s", vdata)
			
		Query(str)
	end
end

local function CheckOldSystem(url, title, duration, vtype, vdata)
	local str = "SELECT count FROM cinema_requests WHERE " ..
		string.format("url=%s", url)
		
	local oldsyscheck = Query(str)
		
	if type(oldsyscheck) == "table" then
		local count = tonumber(oldsyscheck[1].count) + 1
		
		-- Update request count and make video entry compatible with new history system
		str = "UPDATE cinema_requests SET " ..
			string.format("lastRequest='%s', ", os.time()) ..
			string.format("vtype=%s, ", vtype) ..
			string.format("vdata=%s, ", vdata) ..
			string.format("count='%s' WHERE ", count) ..
			string.format("url=%s", url)

	else
		-- Insert new entry into the table
		str = "INSERT INTO cinema_requests " ..
			"(title,url,duration,vtype,vdata,count,lastRequest) " ..
			string.format("VALUES (%s, ", title) ..
			string.format("%s, ", url) ..
			string.format("'%s', ", duration) ..
			string.format("%s, ", vtype) ..
			string.format("%s, ", vdata) ..
			string.format("'%s', ", 1) ..
			string.format("'%s')", os.time())
	end
	
	Query(str)
	
	CheckDuplicates(url, title, duration, vtype, vdata)
	
	return nil
end

function LogRequest()

	local url = net.ReadString()
	local title = net.ReadString()
	local duration = net.ReadInt(32)
	local vtype = net.ReadString()
	local vdata = net.ReadString()

	-- Notify player of video added to queue
 -	AddAnnouncement( {
 -		'Theater_VideoAddedToQueue',
 -		title
 -	} )

	-- Escape strings
	url = sql.SQLStr(url)
	title = sql.SQLStr(title)
	vtype = sql.SQLStr(vtype)
	vdata = sql.SQLStr(vdata)

	local str = "SELECT count,url FROM cinema_requests WHERE " ..
		string.format("vtype=%s AND ", vtype) ..
		string.format("vdata=%s", vdata)

	local results = Query(str)
	
	if type(results) == "table" then
		local count = tonumber(results[1].count) + 1
		
		if results[1].url != url then
			str = CheckOldSystem(url, title, duration, vtype, vdata)
		else
			-- Update request count, url does not suggest duplicates
			str = "UPDATE cinema_requests SET " ..
				string.format("lastRequest='%s', ", os.time()) ..
				string.format("url=%s, ", url) ..
				string.format("count='%s' WHERE ", count) ..
				string.format("vtype=%s AND ", vtype) ..
				string.format("vdata=%s", vdata)
		
		end
	else -- Check if video exists in old history system
		str = CheckOldSystem(url, title, duration, vtype, vdata)
	end

	return Query(str)

end
net.Receive( "PlayerVideoQueued", theater.LogRequest )
