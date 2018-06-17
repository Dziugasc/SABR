comondo = {}
laikas = 3000

function Tele(playerSource)
    teleportTimerLS = setTimer(function()
	   if  not isPedInVehicle(playerSource) then
	        setElementPosition(playerSource, 1518.88757, -1668.16504, 13.54688)
			comondo[playerSource] = true
			setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   else
		   car = getPedOccupiedVehicle(playerSource)
		   comondo[playerSource] = true
		   setElementPosition(car, 1518.88757, -1668.16504, 13.54688)
		   warpPedIntoVehicle(playerSource, car)
		   setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   end  
	end, 4000, 1)
  remain = getTimerDetails(teleportTimerLS)
  setTimer ( outputChatBox, 1000, 1, "3 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 2000, 1, "2 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 3000, 1, "1 second untill teleport", playerSource, r, g, b)
end
addCommandHandler("ls", Tele)
-------------------------------------------------------------------------------------------------------------------------
function Tele(playerSource)
    teleportTimerLV = setTimer(function()
	   if  not isPedInVehicle(playerSource) then
	        setElementPosition(playerSource, 2032.60022, 1343.41199, 10.82031)
			comondo[playerSource] = true
			setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   else
		   car = getPedOccupiedVehicle(playerSource)
		   comondo[playerSource] = true
		   setElementPosition(car, 2032.60022, 1343.41199, 10.82031)
		   warpPedIntoVehicle(playerSource, car)
		   setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   end
	end, 3000, 1)
  remain = getTimerDetails(teleportTimerLV)
  setTimer ( outputChatBox, 1000, 1, "3 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 2000, 1, "2 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 3000, 1, "1 second untill teleport", playerSource, r, g, b)
end
addCommandHandler("lv", Tele)
-------------------------------------------------------------------------------------------------------------------------
function Tele(playerSource)
    teleportTimerSF = setTimer(function()
	   if  not isPedInVehicle(playerSource) then
	        setElementPosition(playerSource, -2028.97644, 148.12634, 28.83594)
			comondo[playerSource] = true
			setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   else
		   car = getPedOccupiedVehicle(playerSource)
		   comondo[playerSource] = true
		   setElementPosition(car, -2028.97644, 148.12634, 28.83594)
		   warpPedIntoVehicle(playerSource, car)
		   setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   end
	end, 3000, 1)
  remain = getTimerDetails(teleportTimerSF)
  setTimer ( outputChatBox, 1000, 1, "3 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 2000, 1, "2 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 3000, 1, "1 second untill teleport", playerSource, r, g, b)
end
addCommandHandler("sf", Tele)
-------------------------------------------------------------------------------------------------------------------------
function Tele(playerSource)
    teleportTimerCanyon = setTimer(function()
	   if  not isPedInVehicle(playerSource) then
	        setElementPosition(playerSource, 1964.04602, -7867.70459, 4)
			comondo[playerSource] = true
			setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   else
		   car = getPedOccupiedVehicle(playerSource)
		   comondo[playerSource] = true 
		   setElementPosition(car, 1964.04602, -7867.70459, 4)
		   warpPedIntoVehicle(playerSource, car)
		   setTimer(function()
			    comondo[playerSource] = false
			end, laikas, 1)
	   end
	end, 3000, 1)
  remain = getTimerDetails(teleportTimerCanyon)
  setTimer ( outputChatBox, 1000, 1, "3 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 2000, 1, "2 seconds untill teleport", playerSource, r, g, b)
  setTimer ( outputChatBox, 3000, 1, "1 second untill teleport", playerSource, r, g, b)
end
addCommandHandler("Vestas", Tele)
