local posicoes = {
	{2848.41, -1590.6, 12},
	{2850.66, -1585.2, 12},
	{2858.22, -1581.4, 12}
}
	 
addCommandHandler ("conce", function (thePlayer, command)
	local azar = math.random (#posicoes)
	local veh = getPedOccupiedVehicle (thePlayer)
	if (veh) then
		setElementPosition (veh, unpack (posicoes [azar]))
	else
		setElementPosition (thePlayer, unpack (posicoes [azar]))
	end	
	outputChatBox ("#FFFFFF[#00FF00Teleport#FFFFFF] "..getPlayerName(thePlayer).." #FFFFFFfoi para a Concessionária! (#00FF00/conce#FFFFFF)", root, 0, 255, 0, true)
end)
