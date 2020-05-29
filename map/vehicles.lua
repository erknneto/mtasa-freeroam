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

function rPVehicleEnter (player,seat,jacked)
	if ( getElementData(player,"rConnected") ) then
		if ( seat == 0 ) then
			if not ( getElementData(player,"driverlicense") ) then
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