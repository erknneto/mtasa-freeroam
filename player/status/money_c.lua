local screenW, screenH = guiGetScreenSize()
rBankWindow = guiCreateWindow((screenW - 409) / 2, (screenH - 278) / 2, 409, 278, "Banco", false)
guiWindowSetSizable(rBankWindow, false)
guiSetVisible(rBankWindow, false)
rBankMenu = guiCreateTabPanel(10, 26, 389, 242, false, rBankWindow)
rBankMenuBank = guiCreateTab("Conta bancária", rBankMenu)
rBankLTitle = guiCreateLabel(10, 10, 369, 15, "Deposite ou saque dinheiro :", false, rBankMenuBank)
guiSetFont(rBankLTitle, "clear-normal")
rBankLBalance = guiCreateLabel(20, 35, 349, 15, "Saldo bancário:", false, rBankMenuBank)
rBankLPBalance = guiCreateLabel(20, 54, 349, 15, "Saldo atual:", false, rBankMenuBank)
rBankEBank = guiCreateEdit(114, 101, 255, 33, "0", false, rBankMenuBank)
rBankLValue = guiCreateLabel(20, 109, 84, 15, "Digite um valor:", false, rBankMenuBank)
rBankBWithdraw = guiCreateButton(20, 165, 121, 43, "Sacar", false, rBankMenuBank)
rBankBDeposit = guiCreateButton(151, 165, 121, 43, "Depositar", false, rBankMenuBank)
rBankMenuTransfer = guiCreateTab("Transferir", rBankMenu)
rBankLTitle2 = guiCreateLabel(10, 10, 369, 15, "Transfira dinheiro para outros jogadores :", false, rBankMenuTransfer)
guiSetFont(rBankLTitle2, "clear-normal")
rBankLBalance2 = guiCreateLabel(203, 45, 176, 15, "Saldo bancário:", false, rBankMenuTransfer)
rBankLValue2 = guiCreateLabel(287, 86, 26, 15, "Valor", false, rBankMenuTransfer)
rBankETransfer = guiCreateEdit(223, 105, 148, 26, "0", false, rBankMenuTransfer)
rBankPGrid = guiCreateGridList(10, 35, 183, 173, false, rBankMenuTransfer)
rBankPGridColumn = guiGridListAddColumn(rBankPGrid, "Jogadores", 0.8)
rBankBTransfer = guiCreateButton(213, 168, 166, 30, "Transferir", false, rBankMenuTransfer)
rBankBClose = guiCreateButton(292, 184, 87, 24, "Fechar", false, rBankMenuBank)

function rBankOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rBankWindow))
		guiSetVisible(rBankWindow,state)
		showCursor(state)
		rBankRefresh()
	end
end
addEvent("rBankOpen",true)
addEventHandler("rBankOpen",getRootElement(),rBankOpen)

function rBankClose ()
	guiSetVisible(rBankWindow,false)
	showCursor(false)
	rBankRefresh()
end
addEvent("rBankClose",true)
addEventHandler("rBankClose",getRootElement(),rBankClose)
addEventHandler("onClientGUIClick",rBankBClose,rBankClose,false)

function rBankRefresh ()
	guiSetText(rBankLBalance,"Saldo bancário: $"..(getElementData(localPlayer,"bankbalance") or 0))
	guiSetText(rBankLPBalance,"Saldo atual: $"..getPlayerMoney())
	guiSetText(rBankLBalance2,"Saldo bancário: $"..(getElementData(localPlayer,"bankbalance") or 0))
	guiSetText(rBankEBank,"0")
	guiSetText(rBankETransfer,"0")
	guiGridListClear(rBankPGrid)
	for _,v in ipairs(getElementsByType("player")) do
		if ( getElementData(v,"rConnected") ) then
			if ( v ~= localPlayer ) then
				local row = guiGridListAddRow(rBankPGrid)
				guiGridListSetItemText(rBankPGrid, row, 1, getPlayerName(v), false, false)
			end
		end
	end
end
addEvent("rBankRefresh",true)
addEventHandler("rBankRefresh",getRootElement(),rBankRefresh)

function rBankWithdraw ()
	local value = tonumber(guiGetText(rBankEBank))
	if ( isNumeric(value) ) then
		if ( value ) and ( value > 0 ) then
			triggerServerEvent("rServerBankWithdraw",localPlayer,value)
		else
			outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
		end
	else
		outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
		guiSetText(rBankEBank,"0")
		guiSetText(rBankETransfer,"0")
	end
end
addEventHandler("onClientGUIClick",rBankBWithdraw,rBankWithdraw,false)

function rBankDeposit ()
	local value = tonumber(guiGetText(rBankEBank))
	if ( isNumeric(value) ) then
		if ( value ) and ( value > 0 ) then
			triggerServerEvent("rServerBankDeposit",localPlayer,value)
		else
			outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
		end
	else
		outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
		guiSetText(rBankEBank,"0")
		guiSetText(rBankETransfer,"0")
	end
end
addEventHandler("onClientGUIClick",rBankBDeposit,rBankDeposit,false)

function rBankTransfer ()
	local value = tonumber(guiGetText(rBankETransfer))
	local playerName = guiGridListGetItemText(rBankPGrid,guiGridListGetSelectedItem(rBankPGrid),1)
	if ( playerName ) and ( playerName ~= nil ) and ( playerName ~= "" ) then
		if ( getPlayerFromName(playerName) ~= localPlayer ) then
			if ( isNumeric(value) ) then
				if ( value ) and ( value > 0 ) then
					triggerServerEvent("rServerBankTransfer",localPlayer,value,playerName)
				else
					outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
				end
			else
				outputChatBox("Esse valor é inválido, tente novamente!",255,0,0)
			end
		else
			outputChatBox("Você não pode transferir dinheiro para si mesmo!",255,0,0)
		end
	else
		outputChatBox("Você precisa selecionar um jogador!",255,0,0)
		guiSetText(rBankEBank,"0")
		guiSetText(rBankETransfer,"0")
	end
end
addEventHandler("onClientGUIClick",rBankBTransfer,rBankTransfer,false)