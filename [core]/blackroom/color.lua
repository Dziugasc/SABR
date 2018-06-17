function respawnExplodedVehicle()
	setTimer(respawnVehicle, 5000, 1, source)
    setVehicleColor ( source,math.random(0,255),math.random(0,255),math.random(0,255))
	end
addEventHandler("onVehicleExplode", getRootElement(), respawnExplodedVehicle)



