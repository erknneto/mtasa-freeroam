local quotes = {
{"foi mandado pro inferno"},
{"foi conhecer Jesus mais cedo"},
{"foi ver se no céu tem pão"},
{"foi aos braços dos anjos"},
{"se fudeu gostoso"},
{"parece que cansou de viver"},
{"morreu por ser ruim"},
{"deitou pra não levantar mais"},
}

function rPlayerDies (ammo,killer,weapon,bone,stealth)
	if ( killer ) then
		local pName = getPlayerName(source)
		local kName = getPlayerName(killer)
		local number = math.random(table.size(quotes))
		for _,p in ipairs(getElementsByType("player")) do
			if ( p ) then
				if ( getElementData(p,"rConnected") ) then
					outputChatBox("Morreu! "..pName.." "..quotes[number][1].." graças ao "..kName.."!",p,math.random(255),math.random(255),math.random(255))
				end
			end
		end
	end
	setPlayerHudComponentVisible(source,"all",false)
	toggleAllControls(source,false)
	showChat(source,false)
	fadeCamera(source,false,5)
	setElementData(source,"rDead",true)
	setTimer(rRespawnPlayer,5000,1,source)
end
addEventHandler("onPlayerWasted",getRootElement(),rPlayerDies)

function rRespawnPlayer (player)
	if ( getElementData(player,"rConnected") ) then
		local x,y,z = getElementPosition(player)
		local hX,hY,hZ = rGetNearestHospital(x,y,z)
		spawnPlayer(player,hX,hY,hZ,math.random(360),rGetCharacter())
		fadeCamera(player,true)
		setCameraTarget(player,player)
		setElementData(player,"rDead",false)
		takePlayerMoney(player,math.random(50,150))
		setPlayerHudComponentVisible(player,"all",true)
		toggleAllControls(player,true)
		showChat(player,true)
		outputChatBox("Você morreu e foi mandado para o hospital mais próximo, as despesas hospitalares foram cobradas de você!",player,255,0,0)
	end
end