local characters = {1, 2, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 70, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 170, 171, 173, 174, 175, 176, 177, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 247, 248, 249, 250, 252, 253, 254, 255, 258, 259, 260, 261, 262, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 299, 300, 301, 302, 303, 305, 306, 307, 308, 309, 310, 311, 312, 9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 224, 225, 226, 231, 232, 233, 237, 238, 243, 244, 245, 246, 251, 256, 257, 263, 298, 304}
local lanimations = {{"GANGS","prtial_gngtlkH"},{"GANGS","prtial_gngtlkG"},{"GANGS","prtial_gngtlkF"},{"GANGS","prtial_gngtlkE"},{"GANGS","prtial_gngtlkD"},{"GANGS","prtial_gngtlkC"},{"GANGS","prtial_gngtlkB"},{"GANGS","prtial_gngtlkA"},{"GANGS","drnkbr_prtl"},{"MISC","Idle_Chat_02"},{"MISC","Scratchballs_01"},{"LOWRIDER","RAP_A_Loop"},{"LOWRIDER","RAP_B_Loop"},{"LOWRIDER","RAP_C_Loop"},{"LOWRIDER","prtial_gngtlkE"},{"LOWRIDER","prtial_gngtlkH"},{"RAPPING","RAP_A_Loop"},{"RAPPING","RAP_B_Loop"},{"DANCING","dnce_M_b"},}

function rGetCharacter ()
	local number = math.random(table.size(characters))
	local rCharacter = characters[number]
	return rCharacter
end

function rGetAnim ()
	local number = math.random(table.size(lanimations))
	local c = lanimations[number][1]
	local n = lanimations[number][2]
	if ( c and n ) then
		return c,n
	end
end

function rSetAnim (p)
	local class,name = rGetAnim()
	setPedAnimation(p,class,name,-1,true,true,true,false)
end

function rAutoLogin ()
	local username = getPlayerSerial(source)
	local password = "mtasaroleplay"
	if ( getAccount(username,password) ) then
		local account = getAccount(username,password)
		logIn(source,account,password)
		
		local accName = getAccountName(account)
		if ( isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) ) then
			setElementData(source,"rAdmin",true)
		end
		clearChatBox(source)
		outputChatBox("Bem-vindo ao nosso servidor!",source,255,255,0)
		outputChatBox("Aperte 'M' para abrir o seu painel pessoal.",source,255,255,0)
	else
		local accAdded = addAccount(username,password)
		if ( accAdded ) then
			local account = getAccount(username,password)
			logIn(source,account,password)
			
			local accName = getAccountName(account)
			if ( isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) ) then
				setElementData(source,"rAdmin",true)
			end
			
			clearChatBox(source)
			outputChatBox("Bem-vindo ao nosso servidor!",source,255,255,0)
			outputChatBox("Aperte 'M' para abrir o seu painel pessoal.",source,255,255,0)
		else
			kickPlayer(source,"Erro de conta!")
		end
	end
end
addEventHandler("onPlayerJoin",getRootElement(),rAutoLogin)

function rJoin ()
	spawnPlayer(source,-42.0,132.0,3.1,360,rGetCharacter(),0,math.random(1,65535))
    fadeCamera(source,true)
	setCameraTarget(source,source)
	setCameraMatrix(source, -42.0,136.0,3.5, -42.0,132.0,3.1)
	rSetAnim(source)
end
addEventHandler("onPlayerJoin",getRootElement(),rJoin)

function rSpawn ()
	fadeCamera(client,false,2)
	setTimer(function(client)
		setElementPosition(client,1479.5,-1674.8,15.0)
		setElementInterior(client,0)
		setElementDimension(client,0)
		setElementData(client,"rConnected",true)
		setCameraTarget(client,client)
		showChat(client,true)
		setPlayerHudComponentVisible(client,"all",true)
		toggleAllControls(client,true)
		fadeCamera(client,true,2)
		rCheckDefaults(client)
	end,2000,1,client)
end
addEvent("rSpawn",true)
addEventHandler("rSpawn",getRootElement(),rSpawn)