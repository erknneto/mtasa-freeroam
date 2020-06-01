function rPersonalServerUse (price,service)
	if ( client ) and ( price ) and ( service ) then
		if ( getPlayerMoney(client) >= price ) then
			if ( service == "suicide" ) then
				killPed(client)
				takePlayerMoney(client,price)
			elseif ( service == "cityhall" ) then
				setElementPosition(client,1479.5,-1674.8,15.0)
				takePlayerMoney(client,price)
			elseif ( service == "summonvehicle" ) then
				if ( getElementData(client,"vehicle") ) then
					if ( getElementData(client,"driverlicense") ) then
						if ( rIsPlayerVehicleOnMap(client) ) then
							rDestroyPlayerVehicle(client)
						end
						local x,y,z = getElementPosition(client)
						local rx,ry,rz = getElementRotation(client)
						local model = getElementData(client,"vehicle")
						local veh = createVehicle(model,x,y,z,rx,ry,rz)
						setElementData(veh,"vehicle",true)
						setElementData(veh,"owner",client)
						rUpdatePlayerVehicle(client,veh)
						takePlayerMoney(client,price)
						warpPedIntoVehicle(client,veh)
						outputChatBox("Seu veículo pessoal foi chamado com sucesso, o custo foi de $"..price.."!",client,0,255,0)
					else
						outputChatBox("Você não possui uma habilitação, compre uma na prefeitura!",client,255,0,0)
					end
				else
					outputChatBox("Você não possui um veículo pessoal, compre um na loja de veículos!",client,255,0,0)
				end
			elseif ( service == "savevehicle" ) then
				if ( getElementData(client,"vehicle") ) then
					if ( rIsPlayerVehicleOnMap(client) ) then
						rDestroyPlayerVehicle(client)
						takePlayerMoney(client,price)
						outputChatBox("Seu veículo pessoal foi guardado com sucesso, o custo foi de $"..price.."!",client,0,255,0)
					else
						outputChatBox("Seu veículo pessoal não foi encontrado no mapa!",client,255,0,0)
					end
				else
					outputChatBox("Você não possui um veículo pessoal, compre um na loja de veículos!",client,255,0,0)
				end
			elseif ( service == "resetvehicle" ) then
				if ( getElementData(client,"vehicle") ) then
					if ( rIsPlayerVehicleOnMap(client) ) then
						rDestroyPlayerVehicle(client)
					end
					setElementData(client,"vehicle",false)
					takePlayerMoney(client,price)
					outputChatBox("Seu veículo pessoal foi resetado com sucesso, o custo foi de $"..price.."!",client,0,255,0)
				else
					outputChatBox("Você não possui um veículo pessoal, compre um na loja de veículos!",client,255,0,0)
				end
			elseif ( service == "repairvehicle" ) then
				if ( getElementData(client,"vehicle") ) then
					if ( rIsPlayerVehicleOnMap(client) ) then
						rFixPlayerVehicle(client)
						takePlayerMoney(client,price)
						outputChatBox("Seu veículo pessoal foi reparado com sucesso, o custo foi de $"..price.."!",client,0,255,0)
					else
						outputChatBox("Seu veículo pessoal não foi encontrado no mapa!",client,255,0,0)
					end
				else
					outputChatBox("Você não possui um veículo pessoal, compre um na loja de veículos!",client,255,0,0)
				end
			end
		else
			outputChatBox("Você não possui dinheiro suficiente para usar este serviço!",client,255,0,0)
			return
		end
	end
end
addEvent("rPersonalServerUse",true)
addEventHandler("rPersonalServerUse",getRootElement(),rPersonalServerUse)