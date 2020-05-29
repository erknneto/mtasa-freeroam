local atmPlaces = {
{2942,1454.0,-1755.1,13.5,0,0,180},
{2942,1464.6,-1749.5,15.4,0,0,180},
{2942,1497.2,-1749.3,15.4,0,0,180},
{2942,1507.3,-1755.1,13.5,0,0,180},
{2942,2008.5,-1449.0,13.5,0,0,180},
{2942,1232.3,-1415.0,13.3,0,0,180},
{2942,1207.4,-1414.7,13.3,0,0,180},
{2942,1329.1,-1289.9,13.5,0,0,180},
{2942,2115.3,-1117.4,25.2,0,0,180},
}

for _,v in ipairs(atmPlaces) do
	atm = createObject(v[1],v[2],v[3],v[4]-0.305,v[5],v[6],v[7])
	atmMarker = createMarker(v[2],v[3]+0.875,v[4]+0.600,"arrow",1,255,0,0,125)
	setElementData(atm,"atm",true)
	setElementData(atmMarker,"atm",true)
end

function atmEnter (player)
	if ( getElementType(player) == "player" ) then
		if not ( isPedInVehicle(player) ) then
			if ( getElementData(player,"rConnected") ) then
				if ( getElementData(source,"atm") ) then
					triggerClientEvent(player,"rBankOpen",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),atmEnter)

function atmLeave (player)
	if ( getElementType(player) == "player" ) then
		if not ( isPedInVehicle(player) ) then
			if ( getElementData(player,"rConnected") ) then
				if ( getElementData(source,"atm") ) then
					triggerClientEvent(player,"rBankClose",player)
				end
			end
		end
	end		
end
addEventHandler("onMarkerLeave",getRootElement(),atmLeave)