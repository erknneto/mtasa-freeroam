local cityhalls = {
{1481.5,-1743.4,13.5},
}

for _,v in ipairs(cityhalls) do
	cityhall = createMarker(v[1],v[2],v[3]-0.875,"cylinder",2,255,0,0)
	cityhallBlip = createBlip(v[1],v[2],v[3],19)
	setElementData(cityhall,"cityhall",true)
end

function cityhallEnter (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"cityhall") ) then
					triggerClientEvent(player,"rHallOpen",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),cityhallEnter)

function cityHallLeave (player)
	if ( getElementType(player) == "player" ) then
		if ( getElementData(player,"rConnected") ) then
			if not ( isPedInVehicle(player) ) then
				if ( getElementData(source,"cityhall") ) then
					triggerClientEvent(player,"rHallClose",player)
				end
			end
		end
	end
end
addEventHandler("onMarkerLeave",getRootElement(),cityHallLeave)

function rHallServerServiceUse (service,price)
	if ( service and price ) then
		if ( getPlayerMoney(client) >= price ) then
			if ( service == "sleep" ) then
				outputChatBox("Você dormiu, recuperou suas energias e gastou $"..price.." nesse serviço!",client,0,255,0)
				setElementData(client,"sleep",100)
				takePlayerMoney(client,price)
			elseif ( service == "restaurant" ) then
				outputChatBox("Você fez uma refeição e gastou $"..price.." nesse serviço!",client,0,255,0)
				setElementData(client,"hunger",100)
				setElementData(client,"thirsty",100)
				takePlayerMoney(client,price)
			elseif ( service == "medic" ) then
				outputChatBox("Você foi curado por um médico do estado e gastou $"..price.." nesse serviço!",client,0,255,0)
				setElementHealth(client,100)
				takePlayerMoney(client,price)
			elseif ( service == "license" ) then
				outputChatBox("Você agora pode usar todos os veículos disponíveis no servidor!",client,0,255,0)
				setElementData(client,"driverlicense",true)
				takePlayerMoney(client,price)
			elseif ( service == "allowweapons" ) then
				outputChatBox("Você agora pode portar armas pela cidade. Compre sua arma em uma ammu-nation!",client,0,255,0)
				setElementData(client,"weaponlicense",true)
				takePlayerMoney(client,price)
			end
		else
			outputChatBox("Você não tem dinheiro para usar esse serviço!",client,255,0,0)
		end
	else
		outputChatBox("Esse serviço é inválido!",client,255,0,0)
	end
end
addEvent("rHallServerServiceUse",true)
addEventHandler("rHallServerServiceUse",getRootElement(),rHallServerServiceUse)

function rHallServerJobsWork (job,salary)
	if ( job and salary ) then
		if ( job == "pizzaboy" ) then
			outputChatBox("Esse trabalho ainda não está disponível!",client,255,0,0)
		elseif ( job == "deliverboy" ) then
			outputChatBox("Esse trabalho ainda não está disponível!",client,255,0,0)
		end
	else
		outputChatBox("Esse trabalho é inválido!",client,255,0,0)
	end
end
addEvent("rHallServerJobsWork",true)
addEventHandler("rHallServerJobsWork",getRootElement(),rHallServerJobsWork)