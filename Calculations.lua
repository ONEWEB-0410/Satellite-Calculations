
local G = script.Parent.Configuration.Constants.G
local Rcentral = script.Parent.Configuration.Constants.Rearth
local M = script.Parent.Configuration.Constants.M

function cubeRoot(x)
	return (x ^ (1 / 3))
end

local Orbit = {}
Orbit._index = Orbit

function Orbit.findSatelliteVelocity(height:number)
	local R = Rcentral + height
	local velocity = math.sqrt(G*M/R)
	return velocity
end

function Orbit.findSatelliteAcceleration(height:number)
	local R = Rcentral + height
	local v = Orbit.findSatelliteVelocity(height)
	local a = v^2/R
	return a
end

function Orbit.findSatellitePeriod(height : height)
	local R = Rcentral + height
	local T = math.sqrt(4* math.pi^2 * R^3 / G*M)
	return T
end

function Orbit.findSatelliteHeight(period : number)
	local T = period
	local Rcube = T^2 * G * M / 4 * math.pi^2
	local R = cubeRoot(Rcube)
	local h = R - Rcentral
	return h
end

return Orbit
