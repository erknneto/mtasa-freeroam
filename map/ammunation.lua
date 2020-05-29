local ammunations = {
{1366.1,-1279.7,13.5},
}

for _,v in ipairs(ammunations) do
	ammunation = createMarker(v[1],v[2],v[3]-0.875,"cylinder",1.5,255,0,0)
	ammunationBlip = createBlip(v[1],v[2],v[3],6)
	setElementData(ammunation,"ammunation",true)
end

function ammunationEnter (player)
	if ( getElementType(player) == "player" ) then
		if not ( isPedInVehicle(player) ) then
			if ( getElementData(player,"rConnected") ) then
				if ( getElementData(source,"ammunation") ) then
					triggerClientEvent(player,"rAmmunationOpen",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),ammunationEnter)

function ammunationLeave (player)
	if ( getElementType(player) == "player" ) then
		if not ( isPedInVehicle(player) ) then
			if ( getElementData(player,"rConnected") ) then
				if ( getElementData(source,"ammunation") ) then
					triggerClientEvent(player,"rAmmunationClose",player)
				end
			end
		end
	end		
end
addEventHandler("onMarkerLeave",getRootElement(),ammunationLeave)

function rAmmunationServerBuy (weap,id,price,ammo)
	if ( weap ) and ( id ) and ( price ) and ( ammo ) then
		if ( getPlayerMoney(client) >= price ) then
			if ( weap == "Colete" ) then
				takePlayerMoney(client,price)
				setPedArmor(client,100)
				outputChatBox("Você comprou 1 "..weap.." por $"..price,client,0,255,0)
				return
			end
			takePlayerMoney(client,price)
			giveWeapon(client,id,ammo)
			outputChatBox("Você comprou "..ammo.." "..weap.." por $"..price,client,0,255,0)
		else
			outputChatBox("Você não tem dinheiro para comprar essa arma!",client,255,0,0)
		end
	else
		outputChatBox("Essa arma é inválida!",client,255,0,0)
	end
end
addEvent("rAmmunationServerBuy",true)
addEventHandler("rAmmunationServerBuy",getRootElement(),rAmmunationServerBuy)