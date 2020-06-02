local sx,sy = guiGetScreenSize()
local px,py = 1366,768
local x,y = (sx/px),(sy/py)

function drawTruckerUI ()
	if ( getElementData(localPlayer,"rConnected") ) then
		if ( getElementData(localPlayer,"working") ) then
			dxDrawRectangle(x*10, y*300, x*250, y*25, tocolor(0, 0, 0, 170), false)
			dxDrawText("Pressione 'L' para cancelar o trabalho!", x*20, y*305, x*250, y*20, tocolor(255, 255, 255, 255), 1*y, "default", "left", "top", false, false, false, false, false)
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawTruckerUI)