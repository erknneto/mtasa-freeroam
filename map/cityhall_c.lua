local cityhallServices = {
{"Dormir",50,"Durma para recuperar suas energias e não morrer de sono.","sleep"},
{"Restaurante",25,"Faça uma refeição para não morrer de fome ou sede.","restaurant"},
{"Médico",100,"Faça uma consulta com os médicos do estado para ver se está tudo bem.","medic"},
{"Habilitação",2000,"Compre uma habilitação para usar os veículos do servidor.","license"},
{"Limpar ficha criminal",1000,"Limpe sua ficha criminal para não ser mais perseguido pela polícia.","cleancriminalrecords"},
{"Porte de armas",2500,"Tenha permissão para portar armas nas ruas da cidade.","allowweapons"},
}

local cityhallJobs = {
{"Policial militar",1200,"Seja a força da lei! Prenda jogadores que estão sendo procurados no momento.\nSalário de $1200 por captura!","police"},
{"Entregador de pizza",25,"Entregue pizzas pela cidade e ganhe $25 por entrega feita!","pizzaboy"},
{"Entregador de mercadorias",25,"Entregue mercadorias pela cidade e ganhe $25 por entrega feita!","deliverboy"},
}

local screenW, screenH = guiGetScreenSize()
rHallWindow = guiCreateWindow((screenW - 432) / 2, (screenH - 275) / 2, 432, 275, "Prefeitura", false)
guiWindowSetMovable(rHallWindow, false)
guiWindowSetSizable(rHallWindow, false)
guiSetVisible(rHallWindow, false)
rHallMenu = guiCreateTabPanel(9, 24, 413, 241, false, rHallWindow)
rHallMenuServices = guiCreateTab("Serviços", rHallMenu)
rHallServicesTitle = guiCreateLabel(10, 10, 393, 15, "Selecione um serviço oferecido pela prefeitura:", false, rHallMenuServices)
rHallServicesGrid = guiCreateGridList(10, 35, 191, 171, false, rHallMenuServices)
rHallServicesGridColumn1 = guiGridListAddColumn(rHallServicesGrid, "Serviço", 0.65)
rHallServicesGridColumn2 = guiGridListAddColumn(rHallServicesGrid, "Preço ($)", 0.2)
rHallBClose = guiCreateButton(340, 191, 63, 15, "Fechar", false, rHallMenuServices)
rHallBServicesUse = guiCreateButton(211, 159, 119, 47, "Usar", false, rHallMenuServices)
rHallServicesName = guiCreateLabel(211, 35, 182, 15, "", false, rHallMenuServices)
guiSetFont(rHallServicesName, "default-bold-small")
rHallServicesDescription = guiCreateMemo(211, 54, 192, 99, "", false, rHallMenuServices)
guiMemoSetReadOnly(rHallServicesDescription, true)
rHallMenuJobs = guiCreateTab("Encontrar trabalho", rHallMenu)
rHallJobsTitle = guiCreateLabel(10, 10, 393, 15, "Trabalhos disponíveis:", false, rHallMenuJobs)
rHallJobsGrid = guiCreateGridList(10, 35, 196, 172, false, rHallMenuJobs)
rHallJobsGridColumn1 = guiGridListAddColumn(rHallJobsGrid, "Trabalhos", 1)
rHallJobsName = guiCreateLabel(216, 35, 187, 15, "", false, rHallMenuJobs)
rHallJobsDescription = guiCreateMemo(216, 54, 187, 111, "", false, rHallMenuJobs)
guiMemoSetReadOnly(rHallJobsDescription, true)
rHallBWork = guiCreateButton(216, 168, 187, 39, "Trabalhar", false, rHallMenuJobs)

function rHallOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rHallWindow))
		guiSetVisible(rHallWindow,state)
		showCursor(state)
		rHallRefresh()
	end
end
addEvent("rHallOpen",true)
addEventHandler("rHallOpen",getRootElement(),rHallOpen)

function rHallClose ()
	guiSetVisible(rHallWindow,false)
	showCursor(false)
	rHallRefresh()
end
addEvent("rHallClose",true)
addEventHandler("rHallClose",getRootElement(),rHallClose)
addEventHandler("onClientGUIClick",rHallBClose,rHallClose,false)

function rHallRefresh ()
	guiSetText(rHallServicesName,"")
	guiSetText(rHallServicesDescription,"")
	guiSetText(rHallJobsName,"")
	guiSetText(rHallJobsDescription,"")
	guiGridListClear(rHallServicesGrid)
	guiGridListClear(rHallJobsGrid)
	for _,v in ipairs(cityhallServices) do
		local row = guiGridListAddRow(rHallServicesGrid)
		guiGridListSetItemText(rHallServicesGrid, row, 1, v[1], false, false)
		guiGridListSetItemText(rHallServicesGrid, row, 2, "$"..v[2], false, false)
	end
	for _,v in ipairs(cityhallJobs) do
		local row = guiGridListAddRow(rHallJobsGrid)
		guiGridListSetItemText(rHallJobsGrid, row, 1, v[1], false, false)
	end
end
addEvent("rHallRefresh",true)
addEventHandler("rHallRefresh",getRootElement(),rHallRefresh)

function rHallServicesUpdate ()
	local title = guiGridListGetItemText(rHallServicesGrid,guiGridListGetSelectedItem(rHallServicesGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(cityhallServices) do
			if ( title == v[1] ) then
				guiSetText(rHallServicesName,v[1])
				guiSetText(rHallServicesDescription,v[3])
			end
		end
	else
		guiSetText(rHallServicesName,"")
		guiSetText(rHallServicesDescription,"")
	end
end
addEventHandler("onClientGUIClick",rHallServicesGrid,rHallServicesUpdate,false)

function rHallJobsUpdate ()
	local title = guiGridListGetItemText(rHallJobsGrid,guiGridListGetSelectedItem(rHallJobsGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(cityhallJobs) do
			if ( title == v[1] ) then
				guiSetText(rHallJobsName,v[1])
				guiSetText(rHallJobsDescription,v[3])
			end
		end
	else
		guiSetText(rHallJobsName,"")
		guiSetText(rHallJobsDescription,"")
	end
end
addEventHandler("onClientGUIClick",rHallJobsGrid,rHallJobsUpdate,false)

function rHallServicesUse ()
	local title = guiGridListGetItemText(rHallServicesGrid,guiGridListGetSelectedItem(rHallServicesGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(cityhallServices) do
			if ( title == v[1] ) then
				triggerServerEvent("rHallServerServiceUse",localPlayer,v[4],v[2])
			end
		end
	else
		outputChatBox("Você precisa selecionar um serviço antes!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rHallBServicesUse,rHallServicesUse,false)

function rHallWork ()
	local title = guiGridListGetItemText(rHallJobsGrid,guiGridListGetSelectedItem(rHallJobsGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(cityhallJobs) do
			if ( title == v[1] ) then
				triggerServerEvent("rHallServerJobsWork",localPlayer,v[4],v[2])
			end
		end
	else
		outputChatBox("Você precisa selecionar um trabalho antes!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rHallBWork,rHallWork,false)

function drawCityHallUI ()
	for _,v in ipairs(getElementsByType("marker")) do
		if ( v ) then
			if ( getElementData(v,"cityhall") ) then
				local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(getLocalPlayer())
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local sx,sy = getScreenFromWorldPosition(x,y,z+0.95,0.06)
				if not ( sx ) then
					return
				end
				if ( distance < 8 ) then
					local scale = 1/(0.3 * (distance / 5))
					dxDrawText("Prefeitura", sx, sy - 45, sx, sy - 45, tocolor(23, 85, 255,255), 1.3, "default-bold", "center", "bottom", false, false, false )
					dxDrawText("Confira os serviços que a prefeitura oferece!", sx, sy - 30, sx, sy - 30, tocolor(255,255,255,255), 0.9, "default-bold", "center", "bottom", false, false, false )
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawCityHallUI)