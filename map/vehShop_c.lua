local vehForSale = {
{"Alpha",602,6452},
{"Blista Compact",496,3478},
{"Picador",600,1896},
{"Sanchez",468,1265},
}

local samples = {}

local screenW, screenH = guiGetScreenSize()
local sx,sy = guiGetScreenSize()
local px,py = 1366,768
local x,y = (sx/px),(sy/py)

rCarShopWindow = guiCreateWindow(10, (screenH - 531) / 2, 308, 531, "Loja de veículos", false)
guiWindowSetSizable(rCarShopWindow, false)
guiWindowSetMovable(rCarShopWindow, false)
guiSetVisible(rCarShopWindow, false)
rCarShopTitle = guiCreateLabel(10, 24, 288, 15, "Compre já o seu veículo", false, rCarShopWindow)
guiSetFont(rCarShopTitle, "clear-normal")
guiLabelSetHorizontalAlign(rCarShopTitle, "center", false)
rCarShopGrid = guiCreateGridList(20, 49, 268, 382, false, rCarShopWindow)
rCarShopGridColumn1 = guiGridListAddColumn(rCarShopGrid, "Veículo", 0.6)
rCarShopGridColumn2 = guiGridListAddColumn(rCarShopGrid, "Preço ($)", 0.2)
rCarShopBBuy = guiCreateButton(30, 441, 248, 38, "Comprar", false, rCarShopWindow)
rCarShopBClose = guiCreateButton(30, 489, 248, 26, "Fechar", false, rCarShopWindow)
rCarShopName = guiCreateLabel(x*0, y*20, x*1366, y*75, "", false)
guiSetFont(rCarShopName, "sa-gothic")
guiLabelSetHorizontalAlign(rCarShopName, "center", false)
guiLabelSetVerticalAlign(rCarShopName, "center")

function rCarShopOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rCarShopWindow))
		guiSetVisible(rCarShopWindow,state)
		guiSetVisible(rCarShopName,state)
		guiSetText(rCarShopName,"")
		showCursor(state)
		rCarShopRefresh()
	end
end
addEvent("rCarShopOpen",true)
addEventHandler("rCarShopOpen",getRootElement(),rCarShopOpen)

function rCarShopClose ()
	guiSetVisible(rCarShopWindow,false)
	guiSetVisible(rCarShopName,false)
	showCursor(false)
	rCarShopRefresh()
	triggerServerEvent("rCarShopResetCamera",getLocalPlayer())
	if ( samples[localPlayer] ) then
		destroyElement(samples[localPlayer])
		samples[localPlayer] = nil
	end
end
addEvent("rCarShopClose",true)
addEventHandler("rCarShopClose",getRootElement(),rCarShopClose)
addEventHandler("onClientGUIClick",rCarShopBClose,rCarShopClose,false)

function rCarShopRefresh ()
	guiGridListClear(rCarShopGrid)
	guiSetText(rCarShopName,"")
	for _,v in ipairs(vehForSale) do
		local row = guiGridListAddRow(rCarShopGrid)
		guiGridListSetItemText(rCarShopGrid, row, 1, v[1], false, false)
		guiGridListSetItemText(rCarShopGrid, row, 2, "$"..v[3], false, false)
	end
	guiGridListSetSelectedItem(rCarShopGrid,0,1)
	rCarShopClick()
end
addEvent("rCarShopRefresh",true)
addEventHandler("rCarShopRefresh",getRootElement(),rCarShopRefresh)

function rCarShopClick ()
	guiSetText(rCarShopName,"")
	local title = guiGridListGetItemText(rCarShopGrid,guiGridListGetSelectedItem(rCarShopGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(vehForSale) do
			if ( v[1] == title ) then
				if ( samples[localPlayer] ) then
					destroyElement(samples[localPlayer])
					samples[localPlayer] = nil
				end
				samples[localPlayer] = createVehicle(v[2],2128.1,-1136.7,25.5)
				guiSetText(rCarShopName,v[1])
			end
		end
	else
		if ( samples[localPlayer] ) then
			destroyElement(samples[localPlayer])
			samples[localPlayer] = nil
		end
		guiSetText(rCarShopName,"")
	end
end
addEventHandler("onClientGUIClick",rCarShopGrid,rCarShopClick,false)

function rCarShopBuy ()
	local title = guiGridListGetItemText(rCarShopGrid,guiGridListGetSelectedItem(rCarShopGrid),1)
	if ( title ) and ( title ~= nil ) and ( title ~= "" ) then
		for _,v in ipairs(vehForSale) do
			if ( title == v[1] ) then
				triggerServerEvent("rCarShopServerBuy",localPlayer,v[2],v[3])
			end
		end
	else
		outputChatBox("Você precisa selecionar um veículo!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rCarShopBBuy,rCarShopBuy,false)

function drawCarShopUI ()
	for _,v in ipairs(getElementsByType("marker")) do
		if ( v ) then
			if ( getElementData(v,"vehShop") ) then
				local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(getLocalPlayer())
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local sx,sy = getScreenFromWorldPosition(x,y,z+0.95,0.06)
				if not ( sx ) then
					return
				end
				if ( distance < 8 ) then
					local scale = 1/(0.3 * (distance / 5))
					dxDrawText("Loja de Veículos", sx, sy - 45, sx, sy - 45, tocolor(23, 85, 255,255), 1.3, "default-bold", "center", "bottom", false, false, false )
					dxDrawText("Compre já seu veículo!", sx, sy - 30, sx, sy - 30, tocolor(255,255,255,255), 0.9, "default-bold", "center", "bottom", false, false, false )
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawCarShopUI)