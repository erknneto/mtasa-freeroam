local screenW, screenH = guiGetScreenSize()
local pAvaible = {
{"Suicídio",25,"suicide"},
{"Ir para a prefeitura",50,"cityhall"},
{"Chamar veículo pessoal",50,"summonvehicle"},
{"Guardar veículo pessoal",50,"savevehicle"},
{"Reparar veículo pessoal",100,"repairvehicle"},
{"Resetar veículo pessoal",500,"resetvehicle"},
}

rPersonalWindow = guiCreateWindow((screenW - 291) / 2, (screenH - 389) / 2, 291, 389, "Painel pessoal", false)
guiWindowSetSizable(rPersonalWindow, false)
guiSetVisible(rPersonalWindow,false)
rPersonalGrid = guiCreateGridList(10, 27, 270, 243, false, rPersonalWindow)
rPersonalBUse = guiCreateButton(20, 280, 250, 39, "Usar", false, rPersonalWindow)
rPersonalBClose = guiCreateButton(20, 329, 250, 39, "Fechar", false, rPersonalWindow)
rPersonalListColumn1 = guiGridListAddColumn(rPersonalGrid, "Serviço", 0.65)
rPersonalListColumn2 = guiGridListAddColumn(rPersonalGrid, "Preço ($)", 0.2)

function rPersonalRefresh ()
	guiGridListClear(rPersonalGrid)
	for _,v in ipairs(pAvaible) do
		local row = guiGridListAddRow(rPersonalGrid)
		guiGridListSetItemText(rPersonalGrid, row, 1, v[1], false, false)
		guiGridListSetItemText(rPersonalGrid, row, 2, "$"..v[2], false, false)
	end
end

function rPersonalOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rPersonalWindow))
		guiSetVisible(rPersonalWindow,state)
		showCursor(state)
		rPersonalRefresh()
	end
end
bindKey("m","down",rPersonalOpen)

function rPersonalClose ()
	guiSetVisible(rPersonalWindow,false)
	showCursor(false)
	rPersonalRefresh()
end
addEventHandler("onClientGUIClick",rPersonalBClose,rPersonalClose,false)

function rPersonalUse ()
	local title = guiGridListGetItemText(rPersonalGrid,guiGridListGetSelectedItem(rPersonalGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(pAvaible) do
			if ( title == v[1] ) then
				triggerServerEvent("rPersonalServerUse",localPlayer,v[2],v[3])
			end
		end
	else
		outputChatBox("Você precisa selecionar um serviço antes!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rPersonalBUse,rPersonalUse,false)