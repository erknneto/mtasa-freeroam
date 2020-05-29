local markets = {
{2398.927734375,-1892.21875,13.3828125},
{2408.7802734375,-1485.974609375,23.828125},
{2095.3427734375,-1806.9208984375,13.551473617554},
{1222.2685546875,-920.46484375,42.911834716797},
{810.734375,-1631.7177734375,13.390567779541},
}

for _,v in ipairs(markets) do
	market = createMarker(v[1],v[2],v[3]-0.875,"cylinder",1.5,255,0,0)
	marketBlip = createBlip(v[1],v[2],v[3],10)
	setElementData(market,"market",true)
end

function marketEnter (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"market") ) then
					triggerClientEvent(player,"rMarketOpen",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),marketEnter)

function marketLeave (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"market") ) then
					triggerClientEvent(player,"rMarketClose",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerLeave",getRootElement(),marketLeave)

function rMarketBuySnack (snack,price,hp,which)
	if ( snack ) and ( price ) and ( hp ) and ( which ) then
		if ( getPlayerMoney(client) >= price ) then
			setElementHealth(client,(getElementHealth(client)) +hp)
			if ( getElementHealth(client) > 100 ) then
				setElementHealth(client,100)
			end
			if ( which == "food" ) then
				setElementData(client,"hunger",100)
			elseif ( which == "drink" ) then
				setElementData(client,"thirsty",100)
			end
			takePlayerMoney(client,price)
			outputChatBox("Você comprou 1 "..snack.." por $"..price.." e recuperou "..hp.."% de vida!",client,0,255,0)
		else
			outputChatBox("Você não tem dinheiro para comprar esse lanche!",client,255,0,0)
		end
	else
		outputChatBox("Esse lanche é inválido!",client,255,0,0)
	end
end
addEvent("rMarketBuySnack",true)
addEventHandler("rMarketBuySnack",getRootElement(),rMarketBuySnack)