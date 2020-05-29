local defaults = {
{"health"},
{"armour"},
{"hunger"},
{"thirsty"},
{"sleep"},
{"bankbalance"},
{"money"},
{"weaponlicense"},
{"driverlicense"},
{"vehicle"},
}

function rCheckDefaults (player)
	if ( player ) then
		if ( getElementData(player,"rConnected") ) then
			if ( getPlayerAccount(player) ) then
				local pAcc = getPlayerAccount(player)
				for _,v in ipairs(defaults) do
					if ( getAccountData(pAcc,v[1]) ) then
						setElementData(player,v[1],getAccountData(pAcc,v[1]))
						if ( v[1] == "health" ) then
							setElementHealth(player,getAccountData(pAcc,v[1]))
						elseif ( v[1] == "armour" ) then
							setPedArmor(player,getAccountData(pAcc,v[1]))
						elseif ( v[1] == "money" ) then
							setPlayerMoney(player,getAccountData(pAcc,v[1]))
						end
					else
						if ( v[1] == "health" ) then
							setElementHealth(player,100)
						elseif ( v[1] == "armour" ) then
							setPedArmor(player,100)
						elseif ( v[1] == "hunger" ) then
							setElementData(player,v[1],100)
						elseif ( v[1] == "thirsty" ) then
							setElementData(player,v[1],100)
						elseif ( v[1] == "sleep" ) then
							setElementData(player,v[1],100)
						elseif ( v[1] == "bankbalance" ) then
							setElementData(player,v[1],0)
						elseif ( v[1] == "money" ) then
							setPlayerMoney(player,365)
						elseif ( v[1] == "weaponlicense" ) then
							setElementData(player,v[1],false)
						elseif ( v[1] == "vehicle" ) then
							setElementData(player,v[1],false)
						end
					end
				end
			end
		end
	end
end

function rSaveDefaults ()
	if ( getElementData(source,"rConnected") ) then
		if ( getPlayerAccount(source) ) then
			local pAcc = getPlayerAccount(source)
			for _,v in ipairs(defaults) do
				setAccountData(pAcc,v[1],getElementData(source,v[1]))
				if ( v[1] == "health" ) then
					setAccountData(pAcc,v[1],getElementHealth(source))
				elseif ( v[1] == "armour" ) then
					setAccountData(pAcc,v[1],getPedArmor(source))
				elseif ( v[1] == "money" ) then
					setAccountData(pAcc,v[1],getPlayerMoney(source))
				end
			end
		end
	end
end
addEventHandler("onPlayerQuit",getRootElement(),rSaveDefaults)