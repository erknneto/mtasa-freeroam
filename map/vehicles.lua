local playerVehicles = {}

for _,v in ipairs(getElementsByType("vehicle")) do
	if ( v ) then
		if ( getElementData(v,"vehicle") ) then
			if ( getElementData(v,"owner") ) then
				playerVehicles[getElementData(v,"owner")] = nil
				outputChatBox("Seu veículo foi destruído, outro está disponível para ser chamado no seu painel.",getElementData(source,"owner"),255,255,0)
			end
		end
		destroyElement(v)
	end
end

function rIsPlayerVehicleOnMap (ped)
	if ( playerVehicles[ped] ) then
		if ( isElement(playerVehicles[ped]) ) then
			return true
		end
	end
	return false
end

function rDestroyWaterVehicles ()
	for _,v in ipairs(getElementsByType("vehicle")) do
		if ( v ) then
			if ( isElementInWater(v) ) then
				if ( getElementData(v,"vehicle") ) then
					if ( getElementData(v,"owner") ) then
						playerVehicles[getElementData(v,"owner")] = nil
						outputChatBox("Seu veículo foi destruído, outro está disponível para ser chamado no seu painel.",getElementData(v,"owner"),255,255,0)
					end
					destroyElement(v)
				end
			end
		end
	end
end
setTimer(rDestroyWaterVehicles,10000,0)

function rDestroyExplodedVehicles ()
	if ( getElementData(source,"vehicle") ) then
		if ( getElementData(source,"owner") ) then
			playerVehicles[getElementData(source,"owner")] = nil
			outputChatBox("Seu veículo foi destruído, outro está disponível para ser chamado no seu painel.",getElementData(source,"owner"),255,255,0)
		end
	end
	destroyElement(source)
end
addEventHandler("onVehicleExplode",getRootElement(),rDestroyExplodedVehicles)

function rDestroyPlayerVehicleQuit ()
	if ( playerVehicles[source] ) then
		destroyElement(playerVehicles[source])
		playerVehicles[source] = nil
	end
end
addEventHandler("onPlayerQuit",getRootElement(),rDestroyPlayerVehicleQuit)

function rDestroyPlayerVehicle (ped)
	if ( ped ) then
		if ( playerVehicles[ped] ) then
			destroyElement(playerVehicles[ped])
			playerVehicles[ped] = nil
		end
	end
end

function rUpdatePlayerVehicle (ped,vehicle)
	if ( ped ) and ( vehicle ) then
		if ( playerVehicles[ped] ) then
			destroyElement(playerVehicles[ped])
			playerVehicles[ped] = nil
		end
		playerVehicles[ped] = vehicle
	end
end

function rFixPlayerVehicle (ped)
	if ( ped ) then
		if ( playerVehicles[ped] ) then
			fixVehicle(playerVehicles[ped])
		end
	end
end

function rPVehicleEnter (player,seat,jacked)
	if ( getElementData(player,"rConnected") ) then
		if ( seat == 0 ) then
			if not ( getElementData(player,"driverlicense") ) and not ( getElementData(player,"temporaryallowed") ) then
				removePedFromVehicle(player)
				outputChatBox("Você não tem uma habilitação para utilizar veículos, compre uma na prefeitura!",player,255,0,0)
				return
			end
			if ( getElementData(source,"vehicle") ) then
				if not ( getElementData(source,"owner") == player ) then
					removePedFromVehicle(player)
					outputChatBox("Você não é o dono desse veículo!",player,255,0,0)
					return
				end
				return
			end
			if ( getElementData(source,"publicVehicle") ) then
				outputChatBox("Esse é um veículo público, ele pode ser respawnado a qualquer momento!",player,255,0,0)
				return
			end
		end
	else
		removePedFromVehicle(player)
		outputChatBox("Erro!",player,255,0,0)
	end
end
addEventHandler("onVehicleEnter",getRootElement(),rPVehicleEnter)