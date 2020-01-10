--[[
	##########################################################################
	##                                                                      ##
	##                                                                      ##
	##                       Criador: Apollo                                ##
	##                Estou parando com o MTA:SA                            ##
    ##	     Por favor não retire os créditos quero deixar meu legado :D    ##
    ##                                                                      ## 
	##                                                                      ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2010-2015, Apollo

	-------------------------------------------------------------------------
	|																		|
	|						Correções: LordHenry							|
	|			Mapa corrigido para não explodir mais os vidros				|
	|		Database substituída para SQLite para não perder dados			|
	|		Correção de outros bugs menores	e novas configurações			|
	|																		|
	-------------------------------------------------------------------------
	© LordHenry 2014-2017
]]
priceBring = 0
priceRepair = 0

function updateThisShit()
	priceBring = tonumber (get ("*priceBring"))
	priceRepair = tonumber (get ("*priceRepair"))
	setTimer (triggerClientEvent, 200, 1, getRootElement(), "updatePrices", resourceRoot, priceBring, priceRepair)
end
addEvent ("upThisShit", true)
addEventHandler ("upThisShit", getRootElement(), updateThisShit)

local sqly = { Query = executeSQLQuery }
function getFreeID()
	local result = sqly.Query("SELECT ID FROM VehicleList ORDER BY ID ASC")
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getVehicleByID(id)
	v = false
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "ID") == id then
			v = veh
			break
		end
	end
	return v
end

function updateVehicleInfo(player)
	if isElement(player) then
		local result = sqly.Query("SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(player)))
		if type(result) == "table" then
			setElementData(player, "VehicleInfo", result)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	sqly.Query("CREATE TABLE IF NOT EXISTS VehicleList (ID INTEGER, Account TEXT, Model INTEGER, X REAL, Y REAL, Z REAL, RotZ REAL, Colors TEXT, Upgrades TEXT, Paintjob INTEGER, Cost INTEGER, HP REAL)")
	for i, player in ipairs(getElementsByType("player")) do
		updateVehicleInfo(player)
	end
	updateThisShit()
end)

addEvent("onOpenGui", true)
addEventHandler("onOpenGui", root,
function()
	updateVehicleInfo(source)
end)

function destroyVehicle(theVehicle)
	if isElement(theVehicle) then
		local Owner = getElementData(theVehicle, "Owner")
		if Owner then
			local x, y, z = getElementPosition(theVehicle)
			local _, _, rz = getElementRotation(theVehicle)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(theVehicle, true)
			local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
			upgrade = ""
			for _, upgradee in ipairs (getVehicleUpgrades(theVehicle)) do
				if upgrade == "" then
					upgrade = upgradee
				else
					upgrade = upgrade..","..upgradee
				end
			end
			local Paintjob = getVehiclePaintjob(theVehicle) or 3
			local id = getElementData(theVehicle, "ID")
			sqly.Query("UPDATE VehicleList SET X = ?, Y = ?, Z = ?, RotZ = ?, HP = ?, Colors = ?, Upgrades = ?, Paintjob = ? WHERE Account = ? AND ID = ?", x, y, z, rz, getElementHealth(theVehicle), color, upgrade, Paintjob, getAccountName(getPlayerAccount(Owner)), id)
			updateVehicleInfo(Owner)
			local attached = getAttachedElements(theVehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
		end
		destroyElement(theVehicle)
	end
end

addEvent("onBuyNewVehicle", true)
addEventHandler("onBuyNewVehicle", root, 
function(Model, cost, r1, g1, b1, r2, g2, b2)
	abc = false
	local data = sqly.Query("SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(source)))
	for i, data in ipairs (data) do
		if data["Model"] == Model then
			abc = true
			break
		end
	end
	if #data >= 50 then outputChatBox("#FFFFFFAtleiskite, jus negalite tureti daugiau nei 50automobiliu.", source, 38, 122, 216, true) return end
	if abc then outputChatBox("Jus nusipirkote si automobili.", source, 255, 150, 0) return end
	if getPlayerMoney(source) >= tonumber(cost) then
		takePlayerMoney ( source, cost )
		local x, y, z = getElementPosition(source)
		local _, _, rz = getElementRotation(source)
		local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
		vehicle = createVehicle(Model, x-5, y+5, z, 0, 0, rz)
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		setElementData(vehicle, "Owner", source)
		local NewID = getFreeID()
		setElementData(vehicle, "ID", NewID)
		sqly.Query("INSERT INTO VehicleList VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", NewID, getAccountName(getPlayerAccount(source)), Model, x-5, y+5, z, rz, color, "", 3, cost, 1000)
		outputChatBox("Tu nusipirkai: #FF0000"..getVehicleNameFromModel(Model), source, 255, 255, 255, true)
		outputChatBox("Kaina: #00FF00$"..cost, source, 255, 255, 255, true)
		updateVehicleInfo(source)
		-- vv[vehicle] = setTimer(function(source)
			-- if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
			-- if isElement(source) and getElementHealth(source) <= 255 then
				-- setElementHealth(source, 255.5)
				-- setVehicleDamageProof(source, true)
				-- setVehicleEngineState(source, false)
			-- end
		-- end, 50, 0, vehicle)
		addEventHandler("onVehicleDamage", vehicle,
		function(loss)
			local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
			setTimer(function(source) if isElement(source) then sqly.Query("UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
		end)
		-- addEventHandler("onVehicleEnter", vehicle,
		-- function(player)
			-- if getElementHealth(source) <= 255.5 then 
				-- setVehicleEngineState(source, false)
			-- else
				-- if isVehicleDamageProof(source) then
					-- setVehicleDamageProof(source, true)
				-- end
			-- end
		-- end)
	else
		outputChatBox("Jus neturite pakankamai pinigu.", source, 255, 150, 0)
	end
end)

vv = {}

addEvent("SpawnMyVehicle", true)
addEventHandler("SpawnMyVehicle", root, 
function(id)
	if not id then
		outputChatBox ("Prasau, pirma pasirinkti masina sarase.", source, 255, 150, 0)
		return
	else
		local data = sqly.Query("SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		if type(data) == "table" and #data ~= 0 then
			if data[1]["HP"] < 255.5 then
				outputChatBox ("Tu negali iskviesti sios transporto priemones nes ji sunaikinta.", source, 255, 150, 0)
			elseif getVehicleByID(id) then
				outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(data[1]["Model"]).."#FFFFFF buvo sukurta.", source, 255, 255, 255, true)
			else
				local color = split(data[1]["Colors"], ',')
				r1 = color[1] or 255
				g1 = color[2] or 255
				b1 = color[3] or 255
				r2 = color[4] or 255
				g2 = color[5] or 255
				b2 = color[6] or 255
				
				vehicle = createVehicle(data[1]["Model"], data[1]["X"], data[1]["Y"], data[1]["Z"], 0, 0, data[1]["RotZ"])
				setElementData(vehicle, "ID", id)
				local upd = split(tostring(data[1]["Upgrades"]), ',')
				for i, upgrade in ipairs(upd) do
					addVehicleUpgrade(vehicle, upgrade)
				end
				local Paintjob = data[1]["Paintjob"] or 3
				setVehiclePaintjob(vehicle, Paintjob) 
				setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
				-- if data[1]["HP"] <= 255.5 then data[1]["HP"] = 255 end
				setElementHealth(vehicle, data[1]["HP"])
				setElementData(vehicle, "Owner", source)
				-- vv[vehicle] = setTimer(function(source)
					-- if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
					-- if isElement(source) and getElementHealth(source) <= 255 then
						-- setElementHealth(source, 255.5)
						-- setVehicleDamageProof(source, true)
						-- setVehicleEngineState(source, false)
					-- end
				-- end, 50, 0, vehicle)
				addEventHandler("onVehicleDamage", vehicle,
				function(loss)
					local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
					setTimer(function(source) if isElement(source) then sqly.Query("UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
				end)
				-- addEventHandler("onVehicleEnter", vehicle,
				-- function(player)
					-- if getElementHealth(source) <= 255.5 then 
						-- setVehicleEngineState(source, false)
					-- else
						-- if isVehicleDamageProof(source) then
							-- setVehicleDamageProof(source, false)
						-- end
					-- end
				-- end)
				outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(data[1]["Model"]).." #FFFFFFbuvo sukurtas.", source, 255, 255, 255, true)
			end
		else
			outputChatBox("Su sia transporto priemone atsirado problemu isitikinkite kad turite ja garaze F3.", source, 255, 0, 0, true)
		end
	end
end)

addEvent("DestroyMyVehicle", true)
addEventHandler("DestroyMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local data = sqly.Query("SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		if type(data) == "table" and #data ~= 0 then
			destroyVehicle(vehicle)
			outputChatBox ("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(data[1]["Model"]).." #FFFFFFbuvo nukelta i garaza.", source, 255, 255, 255, true)
		else
			outputChatBox("Pasirinkite transporto priemone kuri norite iskviesti i garaza.", source, 255, 150, 0)
		end
	else
		outputChatBox("Transporto priemone nera iskviesta, neimanoma uzrakinti.", source, 255, 150, 0)
	end
end)

addEvent("LightsMyVehicle", true)
addEventHandler("LightsMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local Vehicle = getPedOccupiedVehicle(source)
		if Vehicle == vehicle then
			if getVehicleOverrideLights(vehicle) ~= 2 then
				setVehicleOverrideLights(vehicle, 2)
				outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo Apsviestas.", source, 255, 255, 255, true)
			elseif getVehicleOverrideLights(vehicle) ~= 1 then
				setVehicleOverrideLights(vehicle, 1)
				outputChatBox("Jusu automobilio #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FF0000sviesos ijungtos.", source, 255, 255, 255, true)
			end
		else
			outputChatBox("Jus nesate transporto priemoneje!", source, 255, 150, 0)
		end
	else
		outputChatBox("Transporto priemone nera iskviesta, neimanoma atlikti sio veiksmo.", source, 255, 150, 0)
	end
end)

addEvent("LockMyVehicle", true)
addEventHandler("LockMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, true)
			setVehicleDoorsUndamageable(vehicle, true)
			setVehicleDoorState(vehicle, 0, 0)
			setVehicleDoorState(vehicle, 1, 0)
			setVehicleDoorState(vehicle, 2, 0)
			setVehicleDoorState(vehicle, 3, 0) 
			outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo atrakintas.", source, 255, 255, 255, true)
		elseif isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, false)
			setVehicleDoorsUndamageable(vehicle, false)
			outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo uzrakintas.", source, 255, 255, 255, true)
		end
	else
		outputChatBox("Neimanoma uzrakinti.", source, 255, 150, 0)
	end
end)

addEvent("BlipMyVehicle", true)
addEventHandler("BlipMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not getElementData(vehicle, "ABlip") then
			setElementData(vehicle, "ABlip", true)
			createBlipAttachedTo(vehicle, 41, 2, 255, 0, 0, 255, 0, 65535, source)
			outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo pazymetas zemelapyje. paspauskite F11.", source, 255, 255, 255, true)
		else
			local attached = getAttachedElements(vehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
			setElementData(vehicle, "ABlip", false)
			outputChatBox("transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFnebuvo pazymetas zemelapyje.", source, 255, 255, 255, true)
		end
	else
		outputChatBox("Transporto priemone nera iskviesta, pazymeti neimanoma.", source, 255, 150, 0)
	end
end)

addEventHandler ("onVehicleExplode", getRootElement(), function ()
	if isElement (source) then
		local attached = getAttachedElements(source)
		local owner = getElementData (source, "Owner")
		if (attached) then
			for k,element in ipairs(attached) do
				if getElementType(element) == "blip" then
					destroyElement(element)
					if owner then
						outputChatBox("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(source)).." #FFFFFFnebuvo pazymetas zemelapyje.", owner, 255, 255, 255, true)
					end
				end
			end
		end
		setElementData(source, "ABlip", false)
	end
end)

addEvent("FixMyVehicle", true)
addEventHandler("FixMyVehicle", root, 
function(id)
	if getPlayerMoney(source) >= priceRepair then
		takePlayerMoney (source, priceRepair)
		local vehicle = getVehicleByID(id)
		if isElement(vehicle) then
			fixVehicle(vehicle)
			setVehicleEngineState(vehicle, true)
			if isVehicleDamageProof(vehicle) then
				setVehicleDamageProof(vehicle, false)
			end
		end
		sqly.Query("UPDATE VehicleList SET HP = ? WHERE Account = ? AND ID = ?", 1000, getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		if vehicle then
			outputChatBox ("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo sutaisytas", source, 255, 255, 255, true)
		else
			outputChatBox ("Jusu transporto priemone buvo sutaisyta.", source, 255, 255, 255)
		end
	else
		outputChatBox("Jus neturite pakankamai pinigu sutaisymui. ($2000)", source, 255, 150, 0)
	end
end)

addEvent("WarpMyVehicle", true)
addEventHandler("WarpMyVehicle", root, 
function(id)
    if not isPedInVehicle (source) then
		if getElementInterior(source) == 0 then
			if getPlayerMoney(source) >= priceBring then
				local vehicle = getVehicleByID(id)
				if isElement(vehicle) then
					takePlayerMoney (source, priceBring)
					local x, y, z = getElementPosition(source)
					setElementPosition(vehicle, x+3, y+2, z+1.5)
					outputChatBox ("Jusu transporto priemone #FF0000"..getVehicleNameFromModel(getElementModel(vehicle)).." #FFFFFFbuvo sekmingai pristatytas.", source, 255, 255, 255, true)
				else
					outputChatBox("Jusu transporto priemone nebuvo pristatyta sekmingai.", source, 255, 150, 0)
				end
			else
				outputChatBox("Jus neturite pinigu iskviesti masina.", source, 255, 150, 0)
			end
		else
			outputChatBox("Tu negali iskviesti transporto priemones interjere.", source, 255, 150, 0)
		end
    else
		outputChatBox("Tu negali iskviesti automobilio jau budamas automobilyje.", source, 255, 150, 0)
    end
end)
	
addEvent("SellMyVehicle", true)
addEventHandler("SellMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	local data = sqly.Query("SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
	if type(data) == "table" and #data ~= 0 then
		local Money = math.ceil((data[1]["Cost"]*.9)*math.floor(data[1]["HP"])/100/10)
		givePlayerMoney (source, Money)
		if isElement(vehicle) then destroyElement(vehicle) end
		sqly.Query("DELETE FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		outputChatBox("Jus pardavete savo automobili uz #00FF00$"..Money, source, 255, 255, 255, true)
	end
end)

function getDataOnLogin(_, account)
	updateVehicleInfo(source)
end
addEventHandler("onPlayerLogin", root, getDataOnLogin)

function SaveVehicleDataOnQuit()
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "Owner") == source then
			destroyVehicle(veh)
		end
	end
end
addEventHandler("onPlayerQuit", root,SaveVehicleDataOnQuit)
