local weather = {1,2,3,5,6,10,11,17,18}

function rGetWeather ()
	local number = math.random(table.size(weather))
	local rWeather = weather[number]
	return rWeather
end

setTime(07,00)
setMinuteDuration(2000)

function rSetWeather ()
	setWeatherBlended(rGetWeather())
end
setTimer(rSetWeather,2880000,0)