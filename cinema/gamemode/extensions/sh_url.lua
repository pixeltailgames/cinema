-----------------------------------------------------------------------------
-- URI parsing, composition and relative URL resolution
-- LuaSocket toolkit.
-- Author: Diego Nehab
-- RCS ID: $Id: url.lua,v 1.38 2006/04/03 04:45:42 diego Exp $
-----------------------------------------------------------------------------

-----------------------------------------------------------------------------
-- Declare module
-----------------------------------------------------------------------------
local string = string
local base = _G
local table = table
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local type = type
module("url")

-----------------------------------------------------------------------------
-- Module version
-----------------------------------------------------------------------------
_VERSION = "URL 1.0.1"

-----------------------------------------------------------------------------
-- HTML Entity Translation Table
-- http://lua-users.org/lists/lua-l/2005-10/msg00328.html
-----------------------------------------------------------------------------
local entities = {
	[' '] = '&nbsp;',
	['¡'] = '&iexcl;',
	['¢'] = '&cent;',
	['£'] = '&pound;',
	['¤'] = '&curren;',
	['¥'] = '&yen;',
	['¦'] = '&brvbar;',
	['§'] = '&sect;',
	['¨'] = '&uml;',
	['©'] = '&copy;',
	['ª'] = '&ordf;',
	['«'] = '&laquo;',
	['¬'] = '&not;',
	['­'] = '&shy;',
	['®'] = '&reg;',
	['¯'] = '&macr;',
	['°'] = '&deg;',
	['±'] = '&plusmn;',
	['²'] = '&sup2;',
	['³'] = '&sup3;',
	['´'] = '&acute;',
	['µ'] = '&micro;',
	['¶'] = '&para;',
	['·'] = '&middot;',
	['¸'] = '&cedil;',
	['¹'] = '&sup1;',
	['º'] = '&ordm;',
	['»'] = '&raquo;',
	['¼'] = '&frac14;',
	['½'] = '&frac12;',
	['¾'] = '&frac34;',
	['¿'] = '&iquest;',
	['À'] = '&Agrave;',
	['Á'] = '&Aacute;',
	['Â'] = '&Acirc;',
	['Ã'] = '&Atilde;',
	['Ä'] = '&Auml;',
	['Å'] = '&Aring;',
	['Æ'] = '&AElig;',
	['Ç'] = '&Ccedil;',
	['È'] = '&Egrave;',
	['É'] = '&Eacute;',
	['Ê'] = '&Ecirc;',
	['Ë'] = '&Euml;',
	['Ì'] = '&Igrave;',
	['Í'] = '&Iacute;',
	['Î'] = '&Icirc;',
	['Ï'] = '&Iuml;',
	['Ð'] = '&ETH;',
	['Ñ'] = '&Ntilde;',
	['Ò'] = '&Ograve;',
	['Ó'] = '&Oacute;',
	['Ô'] = '&Ocirc;',
	['Õ'] = '&Otilde;',
	['Ö'] = '&Ouml;',
	['×'] = '&times;',
	['Ø'] = '&Oslash;',
	['Ù'] = '&Ugrave;',
	['Ú'] = '&Uacute;',
	['Û'] = '&Ucirc;',
	['Ü'] = '&Uuml;',
	['Ý'] = '&Yacute;',
	['Þ'] = '&THORN;',
	['ß'] = '&szlig;',
	['à'] = '&agrave;',
	['á'] = '&aacute;',
	['â'] = '&acirc;',
	['ã'] = '&atilde;',
	['ä'] = '&auml;',
	['å'] = '&aring;',
	['æ'] = '&aelig;',
	['ç'] = '&ccedil;',
	['è'] = '&egrave;',
	['é'] = '&eacute;',
	['ê'] = '&ecirc;',
	['ë'] = '&euml;',
	['ì'] = '&igrave;',
	['í'] = '&iacute;',
	['î'] = '&icirc;',
	['ï'] = '&iuml;',
	['ð'] = '&eth;',
	['ñ'] = '&ntilde;',
	['ò'] = '&ograve;',
	['ó'] = '&oacute;',
	['ô'] = '&ocirc;',
	['õ'] = '&otilde;',
	['ö'] = '&ouml;',
	['÷'] = '&divide;',
	['ø'] = '&oslash;',
	['ù'] = '&ugrave;',
	['ú'] = '&uacute;',
	['û'] = '&ucirc;',
	['ü'] = '&uuml;',
	['ý'] = '&yacute;',
	['þ'] = '&thorn;',
	['ÿ'] = '&yuml;',
	['"'] = '&quot;',
	["'"] = '&#39;',
	['<'] = '&lt;',
	['>'] = '&gt;',
	['&'] = '&amp;' 
}

function htmlentities(s)
	for k, v in pairs(entities) do
		s = string.gsub(s, k, v)
	end
	return s
end

function htmlentities_decode(s)
	for k, v in pairs(entities) do
		s = string.gsub(s, v, k)
	end
	return s
end

-----------------------------------------------------------------------------
-- Encodes a string into its escaped hexadecimal representation
-- Input
--   s: binary string to be encoded
-- Returns
--   escaped representation of string binary
-----------------------------------------------------------------------------
function escape(s)
	return string.gsub(s, "([^A-Za-z0-9_])", function(c)
		return string.format("%%%02x", string.byte(c))
	end)
end

-----------------------------------------------------------------------------
-- Protects a path segment, to prevent it from interfering with the
-- url parsing.
-- Input
--   s: binary string to be encoded
-- Returns
--   escaped representation of string binary
-----------------------------------------------------------------------------
local function make_set(t)
	local s = {}
	for i,v in ipairs(t) do
		s[t[i]] = 1
	end
	return s
end

-- these are allowed withing a path segment, along with alphanum
-- other characters must be escaped
local segment_set = make_set {
	"-", "_", ".", "!", "~", "*", "'", "(",
	")", ":", "@", "&", "=", "+", "$", ",",
}

local function protect_segment(s)
	return string.gsub(s, "([^A-Za-z0-9_])", function (c)
		if segment_set[c] then return c
		else return string.format("%%%02x", string.byte(c)) end
	end)
end

-----------------------------------------------------------------------------
-- Encodes a string into its escaped hexadecimal representation
-- Input
--   s: binary string to be encoded
-- Returns
--   escaped representation of string binary
-----------------------------------------------------------------------------
function unescape(s)
	return string.gsub(s, "%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end)
end

-----------------------------------------------------------------------------
-- Builds a path from a base path and a relative path
-- Input
--   base_path
--   relative_path
-- Returns
--   corresponding absolute path
-----------------------------------------------------------------------------
local function absolute_path(base_path, relative_path)
	if string.sub(relative_path, 1, 1) == "/" then return relative_path end
	local path = string.gsub(base_path, "[^/]*$", "")
	path = path .. relative_path
	path = string.gsub(path, "([^/]*%./)", function (s)
		if s ~= "./" then return s else return "" end
	end)
	path = string.gsub(path, "/%.$", "/")
	local reduced
	while reduced ~= path do
		reduced = path
		path = string.gsub(reduced, "([^/]*/%.%./)", function (s)
			if s ~= "../../" then return "" else return s end
		end)
	end
	path = string.gsub(reduced, "([^/]*/%.%.)$", function (s)
		if s ~= "../.." then return "" else return s end
	end)
	return path
end

-----------------------------------------------------------------------------
-- Parses a url and returns a table with all its parts according to RFC 2396
-- The following grammar describes the names given to the URL parts
-- <url> ::= <scheme>://<authority>/<path>;<params>?<query>#<fragment>
-- <authority> ::= <userinfo>@<host>:<port>
-- <userinfo> ::= <user>[:<password>]
-- <path> :: = {<segment>/}<segment>
-- Input
--   url: uniform resource locator of request
--   default: table with default values for each field
-- Returns
--   table with the following fields, where RFC naming conventions have
--   been preserved:
--     scheme, authority, userinfo, user, password, host, port,
--     path, params, query, fragment
-- Obs:
--   the leading '/' in {/<path>} is considered part of <path>
-----------------------------------------------------------------------------
function parse(url, default)
	-- initialize default parameters
	local parsed = {}
	for i,v in pairs(default or parsed) do parsed[i] = v end
	-- empty url is parsed to nil
	if not url or url == "" then return nil, "invalid url" end
	-- remove whitespace
	-- url = string.gsub(url, "%s", "")
	-- get fragment
	url = string.gsub(url, "#(.*)$", function(f)
		parsed.fragment = f
		return ""
	end)
	-- get scheme
	url = string.gsub(url, "^([%w][%w%+%-%.]*)%://",
		function(s) parsed.scheme = s; return "" end)
	-- get authority
	url = string.gsub(url, "^([^/%?]*)", function(n)
		parsed.authority = n
		return ""
	end)
	-- get query stringing
	url = string.gsub(url, "%?(.*)", function(q)
		parsed.query = q
		return ""
	end)
	-- get params
	url = string.gsub(url, "%;(.*)", function(p)
		parsed.params = p
		return ""
	end)
	-- path is whatever was left
	if url ~= "" then parsed.path = url else parsed.path = "/" end
	local authority = parsed.authority
	if not authority then return parsed end
	authority = string.gsub(authority,"^([^@]*)@",
		function(u) parsed.userinfo = u; return "" end)
	authority = string.gsub(authority, ":([^:]*)$",
		function(p) parsed.port = p; return "" end)
	if authority ~= "" then parsed.host = authority end
	local userinfo = parsed.userinfo
	if not userinfo then return parsed end
	userinfo = string.gsub(userinfo, ":([^:]*)$",
		function(p) parsed.password = p; return "" end)
	parsed.user = userinfo
	return parsed
end

-----------------------------------------------------------------------------
-- Parses the url and also seperates the query terms into a table
-----------------------------------------------------------------------------
function parse2(url, default)
	local parsed = parse(url, default)

	if parsed.query then
		local prmstr = parsed.query
		local prmarr = string.Explode("&", prmstr)
		local params = {}

		for i = 1, #prmarr do
			local tmparr = string.Explode("=", prmarr[i])
			params[tmparr[1]] = tmparr[2]
		end

		parsed.query = params
	end

	if parsed.fragment then
		local prmstr = parsed.fragment
		local prmarr = string.Explode("&", prmstr)
		local params = {}

		for i = 1, #prmarr do
			local tmparr = string.Explode("=", prmarr[i])
			params[tmparr[1]] = tmparr[2]
		end

		parsed.fragment = params
	end

	return parsed
end

-----------------------------------------------------------------------------
-- Rebuilds a parsed URL from its components.
-- Components are protected if any reserved or unallowed characters are found
-- Input
--   parsed: parsed URL, as returned by parse
-- Returns
--   a stringing with the corresponding URL
-----------------------------------------------------------------------------
function build(parsed)
	local ppath = parse_path(parsed.path or "")
	local url = build_path(ppath)
	local url = (parsed.path or ""):gsub("[^/]+", unescape)
	local url = url:gsub("[^/]*", protect_segment)
	if parsed.params then url = url .. ";" .. parsed.params end
	if parsed.query then url = url .. "?" .. parsed.query end
	local authority = parsed.authority
	if parsed.host then
		authority = parsed.host
		if parsed.port then authority = authority .. ":" .. parsed.port end
		local userinfo = parsed.userinfo
		if parsed.user then
			userinfo = parsed.user
			if parsed.password then
				userinfo = userinfo .. ":" .. parsed.password
			end
		end
		if userinfo then authority = userinfo .. "@" .. authority end
	end
	if authority then url = "//" .. authority .. url end
	if parsed.scheme then url = parsed.scheme .. ":" .. url end
	if parsed.fragment then url = url .. "#" .. parsed.fragment end
	-- url = string.gsub(url, "%s", "")
	return url
end

-----------------------------------------------------------------------------
-- Builds a absolute URL from a base and a relative URL according to RFC 2396
-- Input
--   base_url
--   relative_url
-- Returns
--   corresponding absolute url
-----------------------------------------------------------------------------
function absolute(base_url, relative_url)
	if type(base_url) == "table" then
		base_parsed = base_url
		base_url = build(base_parsed)
	else
		base_parsed = parse(base_url)
	end
	local relative_parsed = parse(relative_url)
	if not base_parsed then return relative_url
	elseif not relative_parsed then return base_url
	elseif relative_parsed.scheme then return relative_url
	else
		relative_parsed.scheme = base_parsed.scheme
		if not relative_parsed.authority or relative_parsed.authority == "" then
			relative_parsed.authority = base_parsed.authority
			if not relative_parsed.path then
				relative_parsed.path = base_parsed.path
				if not relative_parsed.params then
					relative_parsed.params = base_parsed.params
					if not relative_parsed.query then
						relative_parsed.query = base_parsed.query
					end
				end
			else    
				relative_parsed.path = absolute_path(base_parsed.path or "",
					relative_parsed.path)
			end
		end
		return build(relative_parsed)
	end
end

-----------------------------------------------------------------------------
-- Breaks a path into its segments, unescaping the segments
-- Input
--   path
-- Returns
--   segment: a table with one entry per segment
-----------------------------------------------------------------------------
function parse_path(path)
	local parsed = {}
	path = path or ""
	--path = string.gsub(path, "%s", "")
	string.gsub(path, "([^/]*)", function (s) table.insert(parsed, s) end)
	for i = 1, table.getn(parsed) do
		parsed[i] = unescape(parsed[i])
	end
	if string.sub(path, 1, 1) == "/" then parsed.is_absolute = 1 end
	if string.sub(path, -1, -1) == "/" then parsed.is_directory = 1 end
	return parsed
end

-----------------------------------------------------------------------------
-- Builds a path component from its segments, escaping protected characters.
-- Input
--   parsed: path segments
--   unsafe: if true, segments are not protected before path is built
-- Returns
--   path: corresponding path stringing
-----------------------------------------------------------------------------
function build_path(parsed, unsafe)
	local path = ""
  local escape = unsafe and function(x) return x end or protect_segment
	local n = table.getn(parsed)
  for i = 1, n-1 do
	if parsed[i]~= "" or parsed[i+1] == "" then
	  path = path .. escape(parsed[i])
	  if i < n - 1 or parsed[i+1] ~= "" then path = path .. "/" end
	end
  end
  if n > 0 then
	path = path .. escape(parsed[n])
	if parsed.is_directory then path = path .. "/" end
  end
	if parsed.is_absolute then path = "/" .. path end
	return path
end