local string = string
local ipairs = ipairs

---
-- Method for easily grabbing a value from a table without checking that each
-- fragment exists.
--
-- @param tbl      Table
-- @param key      e.g. "json.key.fragments"
-- @param default  Default value if the key doesn't exist
--
function table.Lookup( tbl, key, default )
	local fragments = string.Split(key, '.')
	local value = tbl

	for _, fragment in ipairs(fragments) do
		value = value[fragment]

		if not value then
			return default
		end
	end

	return value
end
