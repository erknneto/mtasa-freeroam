function rServerBankWithdraw (value)
	if ( isNumeric(value) ) then
		if ( value ) and ( value > 0 ) then
			if ( getElementData(client,"bankbalance") ) then
				if ( getElementData(client,"bankbalance") > 0 ) then
					if ( getElementData(client,"bankbalance") >= value ) then
						setElementData(client,"bankbalance",(getElementData(client,"bankbalance")) -value)
						givePlayerMoney(client,value)
						outputChatBox("Foram sacados $"..value.." de sua conta bancária!",client,0,255,0)
						triggerClientEvent(client,"rBankRefresh",client)
					else
						outputChatBox("Seu saldo bancário é menor que o valor digitado!",client,255,0,0)
					end
				else
					outputChatBox("Seu saldo bancário está negativo!",client,255,0,0)
				end
			else
				outputChatBox("Seu saldo bancário é inválido!",client,255,0,0)
			end
		else
			outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
		end
	else
		outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
	end
end
addEvent("rServerBankWithdraw",true)
addEventHandler("rServerBankWithdraw",getRootElement(),rServerBankWithdraw)

function rServerBankDeposit (value)
	if ( isNumeric(value) ) then
		if ( value ) and ( value > 0 ) then
			if ( getElementData(client,"bankbalance") ) then
				if ( getPlayerMoney(client) > 0 ) then
					if ( getPlayerMoney(client) >= value ) then
						takePlayerMoney(client,value)
						setElementData(client,"bankbalance",(getElementData(client,"bankbalance")) +value)
						outputChatBox("Foram depositados $"..value.." à sua conta bancária!",client,0,255,0)
						triggerClientEvent(client,"rBankRefresh",client)
					else
						outputChatBox("Seu dinheiro é menor que o valor digitado!",client,255,0,0)
					end
				else
					outputChatBox("Seu dinheiro está negativo!",client,255,0,0)
				end
			else
				outputChatBox("Seu saldo bancário é inválido!",client,255,0,0)
			end
		else
			outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
		end
	else
		outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
	end
end
addEvent("rServerBankDeposit",true)
addEventHandler("rServerBankDeposit",getRootElement(),rServerBankDeposit)

function rServerBankTransfer (value,playerName)
	local target = getPlayerFromName(playerName)
	if ( target ) then
		if ( isNumeric(value) ) then
			if ( value ) and ( value > 0 ) then
				if ( getElementData(client,"bankbalance") ) then
					if ( getElementData(target,"bankbalance") ) then
						if ( getElementData(client,"bankbalance") > 0 ) then
							if ( getElementData(client,"bankbalance") >= value ) then
								setElementData(client,"bankbalance",(getElementData(client,"bankbalance")) -value)
								setElementData(target,"bankbalance",(getElementData(target,"bankbalance")) +value)
								outputChatBox("Foram transferidos $"..value.." para o jogador "..getPlayerName(target).."!",client,0,255,0)
								outputChatBox("O jogador "..getPlayerName(client).." transferiu $"..value.." para a sua conta bancária!",target,0,255,0)
								triggerClientEvent(client,"rBankRefresh",client)
							else
								outputChatBox("Seu dinheiro é menor que o valor digitado!",client,255,0,0)
							end
						else
							outputChatBox("Seu dinheiro está negativo!",client,255,0,0)
						end
					else
						outputChatBox("O saldo bancário do jogador selecionado é inválido!",client,255,0,0)
					end
				else
					outputChatBox("Seu saldo bancário é inválido!",client,255,0,0)
				end
			else
				outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
			end
		else
			outputChatBox("Esse valor é inválido, tente novamente!",client,255,0,0)
		end
	else
		outputChatBox("O jogador selecionado é inválido!",client,255,0,0)
	end
end
addEvent("rServerBankTransfer",true)
addEventHandler("rServerBankTransfer",getRootElement(),rServerBankTransfer)