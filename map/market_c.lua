local marketItems = {
{"Hamburger",10,40,"food"},
{"X-Bacon",12,42,"food"},
{"X-Egg-Bacon",15,45,"food"},
{"X-Salada",8,45,"food"},
{"Misto quente",5,30,"food"},
{"Pão com mortadela",3,20,"food"},
{"Fritas",10,40,"food"},
{"X-Picanha",25,60,"food"},
{"Vegetariano",18,55,"food"},
{"Vegano",22,60,"food"},
{"Tacos",12,42,"food"},
{"Pizza",25,60,"food"},
{"Lasanha",28,65,"food"},
{"Água",5,70,"drink"},
{"Energético",12,70,"drink"},
{"Cerveja",8,40,"drink"},
{"Pinga",6,20,"drink"},
{"Cachaça",7,20,"drink"},
{"Mix de Frutas",12,70,"drink"},
{"Suco",8,70,"drink"},
}

local screenW, screenH = guiGetScreenSize()

rMarketWindow = guiCreateWindow((screenW - 384) / 2, (screenH - 456) / 2, 384, 456, "Comprar lanche", false)
guiWindowSetSizable(rMarketWindow, false)
guiSetVisible(rMarketWindow, false)

rMarketTitle = guiCreateLabel(10, 29, 364, 15, "Compre já seu lanche", false, rMarketWindow)
guiLabelSetHorizontalAlign(rMarketTitle, "center", false)
rMarketGrid = guiCreateGridList(10, 54, 364, 300, false, rMarketWindow)
rMarketGridColumn1 = guiGridListAddColumn(rMarketGrid, "Lanche", 0.6)
rMarketGridColumn2 = guiGridListAddColumn(rMarketGrid, "Preço ($)", 0.2)
rMarketGridColumn3 = guiGridListAddColumn(rMarketGrid, "HP", 0.1)
rMarketBBuy = guiCreateButton(20, 360, 348, 50, "Comprar", false, rMarketWindow)
rMarketBClose = guiCreateButton(20, 416, 348, 30, "Fechar", false, rMarketWindow)

function rMarketOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rMarketWindow))
		guiSetVisible(rMarketWindow,state)
		showCursor(state)
		rMarketRefresh()
	end
end
addEvent("rMarketOpen",true)
addEventHandler("rMarketOpen",getRootElement(),rMarketOpen)

function rMarketClose ()
	guiSetVisible(rMarketWindow,false)
	showCursor(false)
	rMarketRefresh()
end
addEvent("rMarketClose",true)
addEventHandler("rMarketClose",getRootElement(),rMarketClose)
addEventHandler("onClientGUIClick",rMarketBClose,rMarketClose,false)

function rMarketRefresh ()
	guiGridListClear(rMarketGrid)
	for _,v in ipairs(marketItems) do
		local row = guiGridListAddRow(rMarketGrid)
		guiGridListSetItemText(rMarketGrid, row, 1, v[1], false, false)
		guiGridListSetItemText(rMarketGrid, row, 2, "$"..v[2], false, false)
		guiGridListSetItemText(rMarketGrid, row, 3, v[3], false, false)
	end
end
addEvent("rMarketRefresh",true)
addEventHandler("rMarketRefresh",getRootElement(),rMarketRefresh)

function rMarketBuy ()
	local snack = guiGridListGetItemText(rMarketGrid,guiGridListGetSelectedItem(rMarketGrid),1)
	if ( snack ) and ( snack ~= nil ) and ( snack ~= "" ) then
		for _,v in ipairs(marketItems) do
			if ( snack == v[1] ) then
				triggerServerEvent("rMarketBuySnack",localPlayer,v[1],v[2],v[3],v[4])
			end
		end
	else
		outputChatBox("Você precisa selecionar um lanche antes!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rMarketBBuy,rMarketBuy,false)

function drawMarketUI ()
	for _,v in ipairs(getElementsByType("marker")) do
		if ( v ) then
			if ( getElementData(v,"market") ) then
				local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(getLocalPlayer())
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local sx,sy = getScreenFromWorldPosition(x,y,z+0.95,0.06)
				if not ( sx ) then
					return
				end
				if ( distance < 8 ) then
					local scale = 1/(0.3 * (distance / 5))
					dxDrawText("Comprar lanche", sx, sy - 45, sx, sy - 45, tocolor(23, 85, 255,255), 1.3, "default-bold", "center", "bottom", false, false, false )
					dxDrawText("Compre já seu lanche!", sx, sy - 30, sx, sy - 30, tocolor(255,255,255,255), 0.9, "default-bold", "center", "bottom", false, false, false )
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawMarketUI)