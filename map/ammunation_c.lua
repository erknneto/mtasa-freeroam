local ammunationWeapons = {
{"Colete",0,150,0,false},
{"Parachute",46,100,1,false},
{"Brassknuckle",1,25,1,false},
{"Golfclub",2,30,1,false},
{"Nightstick",3,30,1,false},
{"Knife",4,40,1,false},
{"Bat",5,30,1,false},
{"Shovel",6,30,1,false},
{"Poolstick",7,30,1,false},
{"Katana",8,50,1,false},
{"Chainsaw",9,120,1,false},
{"Colt 45",22,230,17,true},
{"Silenced",23,350,17,true},
{"Deagle",24,420,7,true},
{"Shotgun",25,245,1,true},
{"Sawed-off",26,215,2,true},
{"Combat Shotgun",27,495,7,true},
{"Uzi",28,465,50,true},
{"MP5",29,510,30,true},
{"Tec-9",32,480,50,true},
{"AK-47",30,758,30,true},
{"M4",31,842,50,true},
{"Rifle",33,241,1,true},
{"Sniper",34,305,1,true},
{"Grenade",16,214,1,true},
{"Teargas",17,190,1,false},
{"Molotov",18,145,1,false},
}

local screenW, screenH = guiGetScreenSize()
rAmmunationWindow = guiCreateWindow((screenW - 288) / 2, (screenH - 433) / 2, 288, 433, "Loja de Armas", false)
guiWindowSetSizable(rAmmunationWindow, false)
guiSetVisible(rAmmunationWindow, false)
rAmmunationTitle = guiCreateLabel(10, 27, 268, 15, "Compre já sua arma", false, rAmmunationWindow)
guiLabelSetHorizontalAlign(rAmmunationTitle, "center", false)
rAmmunationGrid = guiCreateGridList(20, 52, 248, 261, false, rAmmunationWindow)
rAmmunationGridColumn1 = guiGridListAddColumn(rAmmunationGrid, "Armas", 0.6)
rAmmunationGridColumn2 = guiGridListAddColumn(rAmmunationGrid, "Preço ($)", 0.2)
rAmmunationBBuy = guiCreateButton(30, 323, 228, 42, "Comprar", false, rAmmunationWindow)
rAmmunationBClose = guiCreateButton(30, 375, 228, 39, "Fechar", false, rAmmunationWindow)

function rAmmunationOpen ()
	if ( getElementData(localPlayer,"rConnected") ) then
		local state = not(guiGetVisible(rAmmunationWindow))
		guiSetVisible(rAmmunationWindow,state)
		showCursor(state)
		rAmmunationRefresh()
	end
end
addEvent("rAmmunationOpen",true)
addEventHandler("rAmmunationOpen",getRootElement(),rAmmunationOpen)

function rAmmunationClose ()
	guiSetVisible(rAmmunationWindow,false)
	showCursor(false)
	rAmmunationRefresh()
end
addEvent("rAmmunationClose",true)
addEventHandler("rAmmunationClose",getRootElement(),rAmmunationClose)
addEventHandler("onClientGUIClick",rAmmunationBClose,rAmmunationClose,false)

function rAmmunationRefresh ()
	guiGridListClear(rAmmunationGrid)
	for _,v in ipairs(ammunationWeapons) do
		local row = guiGridListAddRow(rAmmunationGrid)
		guiGridListSetItemText(rAmmunationGrid, row, 1, v[1], false, false)
		guiGridListSetItemText(rAmmunationGrid, row, 2, "$"..v[3], false, false)
	end
end
addEvent("rAmmunationRefresh",true)
addEventHandler("rAmmunationRefresh",getRootElement(),rAmmunationRefresh)

function rAmmunationBuy ()
	local weapon = guiGridListGetItemText(rAmmunationGrid,guiGridListGetSelectedItem(rAmmunationGrid),1)
	if ( weapon ) and ( weapon ~= nil ) and ( weapon ~= "" ) then
		for _,v in ipairs(ammunationWeapons) do
			if ( weapon == v[1] ) then
				if ( v[5] == false ) then
					triggerServerEvent("rAmmunationServerBuy",localPlayer,v[1],v[2],v[3],v[4])
					return
				elseif ( v[5] == true ) then
					if ( getElementData(localPlayer,"weaponlicense") ) then
						triggerServerEvent("rAmmunationServerBuy",localPlayer,v[1],v[2],v[3],v[4])
					else
						outputChatBox("Você precisa de uma licença para comprar essa arma! Compre uma licença na prefeitura.",255,0,0)
						return
					end
				end
			end
		end
	else
		outputChatBox("Você precisa selecionar uma arma antes!",255,0,0)
	end
end
addEventHandler("onClientGUIClick",rAmmunationBBuy,rAmmunationBuy,false)

function drawAmmunationUI ()
	for _,v in ipairs(getElementsByType("marker")) do
		if ( v ) then
			if ( getElementData(v,"ammunation") ) then
				local x,y,z = getElementPosition(v)
				local px,py,pz = getElementPosition(getLocalPlayer())
				local distance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
				local sx,sy = getScreenFromWorldPosition(x,y,z+0.95,0.06)
				if not ( sx ) then
					return
				end
				if ( distance < 8 ) then
					local scale = 1/(0.3 * (distance / 5))
					dxDrawText("Loja de Armas", sx, sy - 45, sx, sy - 45, tocolor(23, 85, 255,255), 1.3, "default-bold", "center", "bottom", false, false, false )
					dxDrawText("Compre já a sua arma!", sx, sy - 30, sx, sy - 30, tocolor(255,255,255,255), 0.9, "default-bold", "center", "bottom", false, false, false )
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawAmmunationUI)