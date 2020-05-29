local vehShops = {
{2125.953125,-1125.1640625,25.501134872437},
}

for _,v in ipairs(vehShops) do
	vehShop = createMarker(v[1],v[2],v[3]-0.875,"cylinder",3,255,0,0)
	vehShopBlip = createBlip(v[1],v[2],v[3],55)
	setElementData(vehShop,"vehShop",true)
end

function rCarShopEnter (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"vehShop") ) then
					showChat(player,false)
					setPlayerHudComponentVisible(player,"all",false)
					toggleAllControls(player,false)
					setCameraMatrix(player,2127.9,-1125.1,30,2128.1,-1136.7,25.5)
					triggerClientEvent(player,"rCarShopOpen",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),rCarShopEnter)

function rCarShopLeave (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"vehShop") ) then
					showChat(player,true)
					setPlayerHudComponentVisible(player,"all",true)
					toggleAllControls(player,true)
					setCameraTarget(player,player)
					triggerClientEvent(player,"rCarShopClose",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerLeave",getRootElement(),rCarShopLeave)

function rCarShopResetCamera ()
	showChat(client,true)
	setPlayerHudComponentVisible(client,"all",true)
	toggleAllControls(client,true)
	setCameraTarget(client,client)
end
addEvent("rCarShopResetCamera",true)
addEventHandler("rCarShopResetCamera",getRootElement(),rCarShopResetCamera)