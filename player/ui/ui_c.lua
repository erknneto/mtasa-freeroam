local sx,sy = guiGetScreenSize()
local px,py = 1366,768
local x,y = (sx/px),(sy/py)

showDebugUI = false
bindKey("F5","down",function()
	showDebugUI = not(showDebugUI)
end)
function rDrawDebugUI ()
	if not ( showDebugUI ) then return end
	if not ( getElementData(localPlayer,"rAdmin") ) then return end
	if ( getElementData(localPlayer,"rDead") ) then return end
	if ( getElementData(localPlayer,"rConnected") ) then
	
		dxDrawText("Work in progress\nErk, 2020", x*0, y*0, x*1366, y*50, tocolor(255, 255, 255, 125), 1, "default", "center", "center", false, false, false, false, false)
		
		dxDrawText("Vida: "..getElementHealth(localPlayer), x*0, y*0, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Colete: "..getPedArmor(localPlayer), x*0, y*10, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Fome: "..getElementData(localPlayer,"hunger"), x*0, y*20, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Sede: "..getElementData(localPlayer,"thirsty"), x*0, y*30, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Sono: "..getElementData(localPlayer,"sleep"), x*0, y*40, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Banco: $"..getElementData(localPlayer,"bankbalance"), x*0, y*50, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Dinheiro: $"..getPlayerMoney(localPlayer), x*0, y*60, x*0, y*0, tocolor(255, 255, 255, 150), 1, "default", "left", "top", false, false, false, false, false)
	end
end
addEventHandler("onClientRender",getRootElement(),rDrawDebugUI)

function rDrawUI ()
	if ( getElementData(localPlayer,"rDead") ) then return end
	if ( getElementData(localPlayer,"rConnected") ) then
		setPlayerHudComponentVisible("ammo",false)
		setPlayerHudComponentVisible("armour",false)
		setPlayerHudComponentVisible("breath",false)
		setPlayerHudComponentVisible("clock",false)
		setPlayerHudComponentVisible("health",false)
		setPlayerHudComponentVisible("money",false)
		setPlayerHudComponentVisible("weapon",false)
		setPlayerHudComponentVisible("wanted",false)
	
		local health = getElementHealth(localPlayer)
		local armor = getPedArmor(localPlayer)
		local sleep = getElementData(localPlayer,"sleep")
		local hunger = getElementData(localPlayer,"hunger")
		local thirsty = getElementData(localPlayer,"thirsty")
		if ( armor ) and ( armor > 0 )  and ( armor <= 100 ) then
			dxDrawRectangle(x*1100, y*580, x*200/100*100, y*10, tocolor(0, 0, 0, 50), false)
			dxDrawRectangle(x*1100, y*580, x*200/100*armor, y*10, tocolor(0, 0, 0, 120), false)
		end
		if ( health ) and ( health > 0 ) and ( health <= 100 ) then
			dxDrawRectangle(x*1100, y*596, x*200/100*100, y*23, tocolor(0, 0, 0, 50), false)
			dxDrawRectangle(x*1100, y*596, x*200/100*health, y*23, tocolor(0, 0, 0, 120), false)
			dxDrawLine(x*1150, y*596, x*1150, y*619, tocolor(0, 0, 0, 255), 1, true)
			dxDrawLine(x*1200, y*596, x*1200, y*619, tocolor(0, 0, 0, 255), 1, true)
			dxDrawLine(x*1250, y*596, x*1250, y*619, tocolor(0, 0, 0, 255), 1, true)
		end
		if ( sleep ) and ( sleep > 0 ) and ( sleep <= 100 ) then
			dxDrawText("Sono", x*1100, y*425, x*200, y*10, tocolor(255, 255, 255, 255), 1*y, "default", "left", "top", false, false, false, false, false)
			dxDrawRectangle(x*1100, y*445, x*200/100*100, y*10, tocolor(0, 0, 0, 50), false)
			dxDrawRectangle(x*1100, y*445, x*200/100*sleep, y*10, tocolor(0, 0, 0, 120), false)
		end
		if ( hunger ) and ( hunger > 0 ) and ( hunger <= 100 ) then
			dxDrawText("Fome", x*1100, y*465, x*200, y*10, tocolor(255, 255, 255, 255), 1*y, "default", "left", "top", false, false, false, false, false)
			dxDrawRectangle(x*1100, y*485, x*200/100*100, y*10, tocolor(0, 0, 0, 50), false)
			dxDrawRectangle(x*1100, y*485, x*200/100*hunger, y*10, tocolor(0, 0, 0, 120), false)
		end
		if ( thirsty ) and ( thirsty > 0 ) and ( thirsty <= 100 ) then
			dxDrawText("Sede", x*1100, y*505, x*200, y*10, tocolor(255, 255, 255, 255), 1*y, "default", "left", "top", false, false, false, false, false)
			dxDrawRectangle(x*1100, y*525, x*200/100*100, y*10, tocolor(0, 0, 0, 50), false)
			dxDrawRectangle(x*1100, y*525, x*200/100*thirsty, y*10, tocolor(0, 0, 0, 120), false)
		end
		dxDrawLinedRectangle(x*1100, y*625, x*200, y*50, tocolor(0, 0, 0, 200), 2, false)
		dxDrawRectangle(x*1100, y*625, x*200, y*50, tocolor(0, 0, 0, 100), false)
		dxDrawText(getPedAmmoInClip(getLocalPlayer()).."/"..getPedTotalAmmo(getLocalPlayer()), x*1115, y*635, x*245, y*35, tocolor(255, 255, 255, 255), 1*y, uiFont, "left", "top", false, false, false, false, false)
		dxDrawText("$"..getPlayerMoney(localPlayer), x*1100, y*543, x*200, y*10, tocolor(255, 255, 255, 255), 1*y, uiFont, "left", "top", false, false, false, false, false)
	end
end
addEventHandler("onClientRender",getRootElement(),rDrawUI)

function rDrawTags ()
	if ( getElementData(localPlayer,"rDead") ) then return end
	if ( getPedOccupiedVehicle(localPlayer) ) then return end
	if ( getElementData(localPlayer,"rConnected") ) then
		for _,ped in ipairs(getElementsByType("player")) do
			setPlayerNametagShowing(ped,false)
			if ( ped ~= localPlayer ) then
				if ( getElementDimension(ped) == getElementDimension(localPlayer) ) then
					local xHud,yHud,zHud = getElementPosition(localPlayer)
					local pxHud,pyHud,pzHud = getElementPosition(ped)
					local distanceHud = getDistanceBetweenPoints3D(xHud,yHud,zHud,pxHud,pyHud,pzHud)
					local sxHud,syHud = getScreenFromWorldPosition(pxHud,pyHud,pzHud+0.95,0.06)
					if ( sxHud and syHud ) then
						text = "Player"
						r,g,b = 0,127,255
						rDistance = 5
						if ( distanceHud <= rDistance ) then
							dxDrawText(text, sxHud, syHud - 45, sxHud, syHud - 45, tocolor(r,g,b,255), 1.5, "arial", "center", "bottom", false, false, false )
							dxDrawText(getPlayerName(ped), sxHud, syHud - 25, sxHud, syHud - 25, tocolor(255,255,255,255), 1.1, "clear", "center", "bottom", false, false, false )
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",getRootElement(),rDrawTags)

function rDrawDeadUI ()
	if ( getElementData(localPlayer,"rConnected") ) then
		if ( getElementData(localPlayer,"rDead") ) then
			dxDrawLinedRectangle(x*0, y*0, x*1366, y*60, tocolor(0, 0, 0, 200), 2, false)
			dxDrawRectangle(x*0, y*0, x*1366, y*60, tocolor(0, 0, 0, 120), false)
			dxDrawText("Você está morto!\nFique por aí que já estamos procurando um hospital disponível.\nAs despezas com o hospital serão pagas com o seu dinheiro.", x*0, y*0, x*1366, y*60, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, false, false, false)
		end
	end
end
addEventHandler("onClientRender",getRootElement(),rDrawDeadUI)