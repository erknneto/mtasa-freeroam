function setSleep ()
	for _,v in ipairs(getElementsByType("player")) do
		if ( getElementData(v,"rConnected") ) then
			if ( getElementData(v,"sleep") ) then
				setElementData(v,"sleep",(getElementData(v,"sleep")) -math.random(1,2))
				if ( getElementData(v,"sleep") < 0 ) then
					killPed(v)
					outputChatBox("Você morreu de sono, vê se dorme na próxima vez!",v,255,0,0)
				end
			end
		end
	end
end
setTimer(setSleep,120000,0)

function setHunger ()
	for _,v in ipairs(getElementsByType("player")) do
		if ( getElementData(v,"rConnected") ) then
			if ( getElementData(v,"hunger") ) then
				setElementData(v,"hunger",(getElementData(v,"hunger")) -math.random(1,2))
				if ( getElementData(v,"hunger") < 0 ) then
					killPed(v)
					outputChatBox("Você morreu de fome, vê se come na próxima vez!",v,255,0,0)
				end
			end
		end
	end
end
setTimer(setHunger,120000,0)

function setThirsty ()
	for _,v in ipairs(getElementsByType("player")) do
		if ( getElementData(v,"rConnected") ) then
			if ( getElementData(v,"thirsty") ) then
				setElementData(v,"thirsty",(getElementData(v,"thirsty")) -math.random(1,2))
				if ( getElementData(v,"thirsty") < 0 ) then
					killPed(v)
					outputChatBox("Você morreu de sede, vê se bebe algo na próxima vez!",v,255,0,0)
				end
			end
		end
	end
end
setTimer(setThirsty,120000,0)