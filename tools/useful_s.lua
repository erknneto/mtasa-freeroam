function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function isNumeric(text) 
  if type(text)~="string" and type(text)~="number" then return false end 
  return tonumber(text) and true or false 
end 

function rKick (reason)
	kickPlayer(client,reason)
end
addEvent("rKick",true)
addEventHandler("rKick",getRootElement(),rKick)