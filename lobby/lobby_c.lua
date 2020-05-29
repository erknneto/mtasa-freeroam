local sx,sy = guiGetScreenSize() 
local px,py = 1366,768
local x,y =  (sx/px),(sy/py)

function rLobbyEnable ()
	showCursor(true)
	showChat(false)
	setPlayerHudComponentVisible("all",false)
	toggleAllControls(false)
	addEventHandler("onClientRender",getRootElement(),rLobbyDraw)
	addEventHandler("onClientClick",getRootElement(),rLobbyClick)
end
addEvent("rLobbyEnable",true)
addEventHandler("rLobbyEnable",getRootElement(),rLobbyEnable)

function rLobbyDisable ()
	showCursor(false)
	removeEventHandler("onClientRender",getRootElement(),rLobbyDraw)
	removeEventHandler("onClientClick",getRootElement(),rLobbyClick)
	
	triggerServerEvent("rSpawn",localPlayer)
end
addEvent("rLobbyDisable",true)
addEventHandler("rLobbyDisable",getRootElement(),rLobbyDisable)

function rLobbyDraw ()
	dxDrawRectangle(x*0, y*0, x*1366, y*50, tocolor(0, 0, 0, 170), false)
	dxDrawText("Bem-vindo, "..getPlayerName(localPlayer).."!\nEsse é o nosso roleplay!", x*0, y*0, x*1366, y*50, tocolor(255, 255, 255, 255), 1*y, "default", "center", "center", false, false, false, false, false)
	
	dxDrawRectangle(x*10, y*60, x*200, y*50, tocolor(0, 0, 0, 170), false)
	dxDrawText("Jogar", x*10, y*120, x*200, y*50, tocolor(255, 255, 255, 255), 1*y, "default", "center", "center", false, false, false, false, false)
	
	dxDrawRectangle(x*215, y*60, x*200, y*50, tocolor(0, 0, 0, 170), false)
	dxDrawText("Sair", x*430, y*120, x*200, y*50, tocolor(255, 255, 255, 255), 1*y, "default", "center", "center", false, false, false, false, false)
	
	if ( isMouseInPosition(x*10, y*60, x*200, y*50) ) then
		dxDrawRectangle(x*10, y*60, x*200, y*50, tocolor(255, 255, 255, 120), false)
	elseif ( isMouseInPosition(x*215, y*60, x*200, y*50) ) then
		dxDrawRectangle(x*215, y*60, x*200, y*50, tocolor(255, 255, 255, 120), false)
	end
end

function rLobbyClick (button,state)
	if ( button == "left" and state == "up" ) then
		if ( isMouseInPosition(x*10, y*60, x*200, y*50) ) then
			rLobbyDisable()
		elseif ( isMouseInPosition(x*215, y*60, x*200, y*50) ) then
			triggerServerEvent("rKick",localPlayer,"Saiu!")
		end
	end
end