module( "theater", package.seeall )

Services = {}

function RegisterService( class, object, base )

	if !class or !object then return end
	if !base then base = "base" end

	Services[ class ] = object
	Services[ class ].ClassName = class

	if !Services[ base ] then
		ErrorNoHalt( "theater.RegisterService: Base class '" .. tostring(base) .. "' not found!" )
	else
		if class == "base" then return end
		setmetatable( Services[ class ], { __index = Services[ base ] } )
	end

end

function GetServiceByClass( class )

	return Services [ class ]

end

-- Load the base service before anything else
/*if SERVER then
	AddCSLuaFile('./services/sh_base.lua')
end
include('./services/sh_base.lua')*/

Loader.Load( "modules/theater/services" )
Loader.Load( "modules/theater/services" )