local hospitals = {
{1183.4,-1323.9,14.5},
{2014.0,-1434.0,13.5},
}

local hospitalPickups = {
{1183.2,-1332.2,13.5},
{1175.7,-1339.2,13.9},
{1178.5,-1323.5,14.1},
{2025.2,-1411.5,16.9},
{2041.2,-1411.9,17.1},
{2028.3,-1420.3,16.9},
}

function rGetNearestHospital (x,y,z)
	if ( x ) and ( y ) and ( z ) then
		local center = getDistanceBetweenPoints3D(x,y,z,1183.4,-1323.9,14.5)
		local ghetto = getDistanceBetweenPoints3D(x,y,z,2014.0,-1434.0,13.5)
		if ( center <= ghetto ) then
			return 1183.4,-1323.9,14.5
		else
			return 2014.0,-1434.0,13.5
		end
	end
end

for _,v in ipairs(hospitals) do
	createBlip(v[1],v[2],v[3],22)
end

for _,v in ipairs(hospitalPickups) do
	createPickup(v[1],v[2],v[3],0,100)
end