
local G = script.Parent.Configuration.Constants.G
local Rcentral = script.Parent.Configuration.Constants.Rearth
local M = script.Parent.Configuration.Constants.M

function cubeRoot(x)
	return (x ^ (1 / 3))
end

local Orbit = {}
Orbit._index = Orbit

-- Circular Orbit calculations

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


-- Eliptical Orbit Calculations

function Orbit.ConvertToCartesian( e,  a,  i,  O,  w,  t, t0, M0)
     local mu = G * M
     if(t==t0) then
         t = t0
         Mt = 0
     else
         local dt = 86400 * (t-t0)
         local Mt = M0 + dt * math.sqrt(mu/a^3)
         local maxIter = 30 -- The desired accuracy
         local E = Mt
         local F = E - e * math.sin(E) - Mt -- Just a variable F
         local i = 0
         while ((math.abs(F)>delta) and (i<maxIter)) do

		    E = E - F/(1. -e* math.cos(E))
		    F = E - e * math.sin(E) - m
		    i = i + 1
	     end
         nu = 2 * math.atan2(math.sqrt(1+e) * math.sin(E/2),  math.sqrt (1 - e) * math.cos(E / 2)) 
         rc = a * (1 - e * math.cos(E))

         o = Vector3.new(rc * math.os(nu), rc * math.sin(nu), 0) 
                
         odot = Vector3.new(math.sin (E), math.sqrt(1 - e * e) * math.cos(E), 0)
         odot = (math.sqrt (mu * a) / rc) * odot

         rx = ( o.x * (math.cos(w) * math.cos(O) - math.sin (w) * math.cos(i) * math.sin(O)) -
         o.y * (math.sin(w) * math.cos(O) + math.cos(w) * math.cos(i) * math.sin(O)))
         ry = (o.x * (math.cos(w) * math.sin(O) + math.sin(w) * math.cos(i) * math.cos(O)) +
         o.y * (math.cos(w) * math.cos(i) * math.cos(O) - math.sin(w) * math.sin(O)))
         rz = (o.x * (math.sin(w) * math.sin(i)) + o.y * (math.cos(w) * math.sin(i)))

        rdotx = ( odot.x * (math.cos(w) * math.cos(O) - math.sin(w) * math.cos(i) * math.sin(O)) -
        odot.y * (math.sin(w) * math.cos(O) + math.cos(w) * math.cos(i) * math.sin(O)))
        rdoty = (odot.x * (math.cos(w) * math.sin(O) + math.sin(w) * math.cos(i) * math.cos(O)) +
        odot.y * (math.cos(w) * math.cos(i) * math.cos(O) - math.sin(w) * math.sin(O)))
        rdotz = (odot.x * (math.sin(w) * math.sin(i)) + odot.y * (math.cos(w) * math.sin(i)))

        r = Vector3.new(rx,ry,rz)
        rdot = Vector3.new(rdotx,rdoty,rdotz)
       return r , rdot
     end
end


return Orbit
