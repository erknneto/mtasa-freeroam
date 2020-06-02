local rTruckerMarkers = {}
local rTruckerBlips = {}
local rTruckerVehicles = {}

local rTruckerTrucks = {
{456},
{414},
{455},
{498},
}

local rTruckerDestinations = {
{1962.69921875,-2182.0654296875,13.546875},
{2754.140625,-2410.3701171875,13.534805297852},
{-63.736328125,-1590.673828125,2.6171875},
{-58.478515625,-1137.376953125,1.078125},
{-492.0986328125,-525.3515625,25.517845153809},
{-1018.6640625,-626.166015625,32.0078125},
{-217.8046875,-273.55859375,1.4296875},
{-106.2421875,-75.4228515625,3.1171875},
{663.6865234375,-466.7451171875,16.3359375},
{2263.8798828125,29.60546875,26.418962478638},
{-1568.6796875,-2742.46484375,48.5390625},
}

function rTruckerStart (player,salary)
	if ( player ) and ( salary ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( getElementData(player,"working") ) then
				local sX,sY,sZ = 2212.7,-2234.9,13.5
				local mNumber = math.random(table.size(rTruckerTrucks))
				local model = rTruckerTrucks[mNumber][1]
				local dNumber = math.random(table.size(rTruckerDestinations))
				local dX,dY,dZ = rTruckerDestinations[dNumber][1],rTruckerDestinations[dNumber][2],rTruckerDestinations[dNumber][3]
				rTruckerMarkers[player] = createMarker(dX,dY,dZ-0.875,"cylinder",5,255,255,0,200,player)
				rTruckerBlips[player] = createBlip(dX,dY,dZ,0,2,255,255,0,255,0,16383.0,player)
				rTruckerVehicles[player] = createVehicle(model,sX,sY,sZ)
				setElementData(player,"temporaryallowed",true)
				warpPedIntoVehicle(player,rTruckerVehicles[player])
				setElementData(rTruckerMarkers[player],"trucker",true)
				setElementData(rTruckerMarkers[player],"target",player)
				setElementData(rTruckerVehicles[player],"trucker",true)
				setElementData(rTruckerVehicles[player],"target",player)
				setElementData(player,"working",true)
				setElementData(player,"salary",salary)
				
				toggleControl(player,"fire",false)
				toggleControl(player,"aim_weapon",false)
				toggleControl(player,"next_weapon",false)
				toggleControl(player,"previous_weapon",false)
				toggleControl(player,"action",false)
				toggleControl(player,"enter_exit",false)
				
				bindKey(player,"l","down",rTruckerStopBind)
				triggerClientEvent(player,"rHallClose",player)
				
				outputChatBox("Você iniciou o trabalho de caminhoneiro!",player,255,255,0)
				outputChatBox("Pressione 'L' para cancelar o trabalho!",player,255,255,0)
			end
		end
	end
end

function rTruckerVehicleOnWater ()
	for _,v in ipairs(getElementsByType("vehicle")) do
		if ( v ) then
			if ( isElementInWater(v) ) then
				if ( getElementData(v,"trucker") ) then
					if ( getElementData(v,"target") ) then
						if ( isElement(getElementData(v,"target")) ) then
							rTruckerStop(getElementData(v,"target"),0,false)
						end
					end
				end
			end
		end
	end
end
setTimer(rTruckerVehicleOnWater,10000,0)

function rTruckerVehicleExplode ()
	if ( getElementData(source,"trucker") ) then
		if ( getElementData(source,"target") ) then
			if ( isElement(getElementData(source,"target")) ) then
				rTruckerStop(getElementData(source,"target"),0,false)
			end
		end
	end
end
addEventHandler("onVehicleExplode",getResourceRootElement(),rTruckerVehicleExplode)

function rTruckerStopWasted ()
	if ( getElementData(source,"working") ) then
		rTruckerStop(source,0,false)
	end
end
addEventHandler("onPlayerWasted",getRootElement(),rTruckerStopWasted)

function rTruckerStopBind (player)
	if ( getElementData(player,"working") ) then
		rTruckerStop(player,0,false)
	end
end

function rTruckerStop (player,salary,isCompleted)
	if ( player ) and ( salary ) then
		if ( rTruckerMarkers[player] ) then
			if ( isElement(rTruckerMarkers[player]) ) then
				destroyElement(rTruckerMarkers[player])
			end
			rTruckerMarkers[player] = nil
		end
		if ( rTruckerBlips[player] ) then
			if ( isElement(rTruckerBlips[player]) ) then
				destroyElement(rTruckerBlips[player])
			end
			rTruckerBlips[player] = nil
		end
		if ( rTruckerVehicles[player] ) then
			if ( isElement(rTruckerVehicles[player]) ) then
				destroyElement(rTruckerVehicles[player])
			end
			rTruckerVehicles[player] = nil
		end
		if ( isCompleted ) then
			if ( salary ) then
				givePlayerMoney(player,salary)
			end
			outputChatBox("Você completou o trabalho de caminhoneiro, volte para a prefeitura para trabalhar mais!",player,0,255,0)
		end
		setElementData(player,"salary",false)
		setElementData(player,"working",false)
		setElementData(player,"temporaryallowed",false)
		if not ( isCompleted ) then
			outputChatBox("O trabalho de caminhoneiro foi cancelado!",player,255,0,0)
		end
		toggleControl(player,"fire",true)
		toggleControl(player,"aim_weapon",true)
		toggleControl(player,"next_weapon",true)
		toggleControl(player,"previous_weapon",true)
		toggleControl(player,"action",true)
		toggleControl(player,"enter_exit",true)
		unbindKey(player,"l","down",rTruckerStopBind)
	end
end

function rTruckerHit (player)
	if ( getElementData(source,"trucker") ) then
		if ( getElementData(source,"target") ) then
			if ( getElementType(player) == "player" ) then
				if ( getElementData(source,"target") == player ) then
					local salary = (getElementData(player,"salary") or 0)
					rTruckerStop(player,salary,true)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getResourceRootElement(),rTruckerHit)