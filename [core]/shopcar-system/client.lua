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

function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end

setTimer (function ()
	local theCol = getElementData(root, "BlockExportCol")
	
	function isInColExport ()
		if isElement(theCol) and isElementWithinColShape(localPlayer,theCol) then
			return true else return false
		end
	end

	function ClientExplosionCFunction()
		if isInColExport ()  then
			cancelEvent ()
		end
	end
	addEventHandler("onClientExplosion", root, ClientExplosionCFunction)

end, 1000, 1)

local screX, screY = guiGetScreenSize()

addEventHandler ('onClientResourceStart', resourceRoot, function()
	Window_VS = guiCreateWindow(500, 254, 276, 420,"Masinu valdymas",false)
	guiSetAlpha(Window_VS, 0.88)
	guiWindowSetSizable(Window_VS, false)
	guiSetVisible(Window_VS, false)
	centerWindow(Window_VS)
	Grid_VS = guiCreateGridList(11, 75, 255, 275,false,Window_VS)
	guiGridListSetSelectionMode(Grid_VS, 1)
	guiGridListAddColumn(Grid_VS,"Modelis",0.44)
	guiGridListAddColumn(Grid_VS,"Kaina",0.26)
	guiGridListAddColumn(Grid_VS,"Bukle",0.20)
	Label_VeS = guiCreateLabel(9, 25, 257, 15, "",false,Window_VS)
	Label_SVS = guiCreateLabel(10, 386, 257, 15, "",false,Window_VS)
	guiLabelSetColor(Label_VeS, 38, 122, 216)
	guiLabelSetColor(Label_SVS, 38, 122, 216)
	guiSetFont(Label_VeS, "default-bold-small")
	guiSetFont(Label_SVS, "default-bold-small")

	--Button_VS_sl = guiCreateButton(19, 24, 67, 40, "Parduoti", false, Window_VS)
	Button_VS_bp = guiCreateButton(19, 24, 67, 40, "Pazymeti", false, Window_VS)
	Button_VS_lk = guiCreateButton(184, 24, 67, 40, "Atrakinti", false, Window_VS)
	Button_VS_sn = guiCreateButton(10, 369, 61, 40, "Susigrazinti", false, Window_VS)
	Button_VS_dy = guiCreateButton(75, 369, 61, 40, "Slepti", false, Window_VS)
	Button_VS_Warp = guiCreateButton(140, 369, 50, 40, "Kviesti", false, Window_VS)
	Button_VS_Fix = guiCreateButton(195, 369, 70, 40, "Remontuoti", false, Window_VS)
	Label_VS_Warp = guiCreateLabel (140, 350, 50, 20, "$0", false, Window_VS)
	Label_VS_Fix = guiCreateLabel (195, 350, 70, 20, "$0", false, Window_VS)
	guiLabelSetHorizontalAlign (Label_VS_Warp, "center")
	guiLabelSetHorizontalAlign (Label_VS_Fix, "center")
	guiLabelSetColor (Label_VS_Warp, 90, 90, 90)
	guiLabelSetColor (Label_VS_Fix, 90, 90, 90)

	Window_CHK = guiCreateWindow(screX/2-155,screY/2-60,310,120,"Demesio",false)
	guiSetVisible(Window_CHK, false)
	guiSetProperty(Window_CHK, "AlwaysOnTop", "true")
	guiWindowSetSizable(Window_CHK, false)
	Label_CHK = guiCreateLabel(21,28,266,36,"",false,Window_CHK)
	guiLabelSetColor(Label_CHK, 38, 122, 216)
	guiLabelSetHorizontalAlign(Label_CHK,"center",true)
	Button_CHK_Y = guiCreateButton(17,73,129,36,"Taip",false,Window_CHK)
	Button_CHK_N = guiCreateButton(161,73,129,36,"Ne",false,Window_CHK)
end)

addEvent ("updatePrices", true)
addEventHandler ("updatePrices", resourceRoot, function (bring, repair)
	guiSetText (Label_VS_Warp, "$"..bring)
	guiSetText (Label_VS_Fix, "$"..repair)
end)

function updateGridList()
	local data = getElementData(localPlayer, "VehicleInfo")
	if data then
		local rw, cl = guiGridListGetSelectedItem(Grid_VS)
		guiGridListClear(Grid_VS)
		for i, data in ipairs (data) do
			local carName = getVehicleNameFromModel(data["Model"])
			local ID = data["ID"]
			local Cost = data["Cost"]
			local HP = math.floor(data["HP"])
			local PreCost = math.ceil(Cost*.9*HP/100/10)
			local row = guiGridListAddRow(Grid_VS)
			guiGridListSetItemText(Grid_VS, row, 1, carName, false, true)
			guiGridListSetItemData(Grid_VS, row, 1, ID)
			guiGridListSetItemText(Grid_VS, row, 2, PreCost, false, true)
			guiGridListSetItemText(Grid_VS, row, 3, HP.." HP", false, true)
		end
		guiGridListSetSelectedItem(Grid_VS, rw, cl)
	end
end

bindKey("F3", "down", function()
	if getElementInterior(localPlayer) == 0 and getElementDimension(localPlayer) == 0 then
		if getElementData(localPlayer, "MissionWarProtection") and getElementData(localPlayer, "MissionProtection")then return end
		triggerServerEvent ("upThisShit", localPlayer)
		guiSetVisible(Window_VS, not guiGetVisible(Window_VS))
		guiSetVisible (Window_CHK, false)
		showCursor(guiGetVisible(Window_VS))
	end
end)

triggerServerEvent("onOpenGui", localPlayer)

addEventHandler("onClientElementDataChange", root,
function(dd)
	if getElementType(source) == "player" and source == localPlayer and dd == "VehicleInfo" then
		local data = getElementData(source, dd)
		if data then
			updateGridList()
		end
	end
end)

function WINDOW_CLICK_VEHICLE (button, state, absoluteX, absoluteY)
	local id = guiGridListGetSelectedItem(Grid_VS)
	local ID = guiGridListGetItemData(Grid_VS, id, 1)
	if source == Button_VS_close then
		guiSetVisible(Window_VS, false)
		showCursor(false)
	end
	if (source == Grid_VS) then
		if id == -1 and idd then
			guiGridListSetSelectedItem(Grid_VS, idd, 1)
			return false
		else
			idd = guiGridListGetSelectedItem(Grid_VS)
		end
	elseif (source == Button_VS_sn) then
		if not isInColExport () then
			triggerServerEvent("SpawnMyVehicle", localPlayer, ID)
		end
	elseif (source == Button_VS_dy) then 
		triggerServerEvent("DestroyMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_lt) then 
		triggerServerEvent("LightsMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_bp) then 
		triggerServerEvent("BlipMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_lk) then 
		triggerServerEvent("LockMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_sl) then 
		guiSetVisible(Window_CHK, true)
		local carName = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 1)
		local carprice = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 2)
		guiSetText(Label_CHK, 'Ar tikrai nori parduoti masina uz $'..carprice)
	elseif source == Button_CHK_Y then
		triggerServerEvent("SellMyVehicle", localPlayer, ID)
		guiSetVisible(Window_VS, false)
		guiSetVisible(Window_CHK, false)
		showCursor(false)
	elseif source == Button_CHK_N then
		guiSetVisible (Window_CHK, false)
	elseif source == Button_VS_Spc then
		if getElementInterior(localPlayer) == 0 then
			if getElementData(localPlayer,"Stats") < 2 then
				SpecVehicle(ID)
			end
		end
	elseif source == Button_VS_Fix then
		triggerServerEvent("FixMyVehicle", localPlayer, ID)
	elseif source == Button_VS_Warp then
		if not isInColExport () then
			triggerServerEvent("WarpMyVehicle", localPlayer, ID)
		end
	end
end
addEventHandler("onClientGUIClick", resourceRoot, WINDOW_CLICK_VEHICLE)

function SpecVehicle(id)

	if spc then 
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
	return end
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "Owner") == localPlayer and getElementData(vehicle, "ID") == id then
			cVeh = vehicle
			spc = true
			addEventHandler("onClientPreRender", root, Sp)
			guiSetVisible(Window_VS, false)
			showCursor(false)
			break
		  end
	end
end

function Sp()
	if isElement(cVeh) then
		local x, y, z = getElementPosition(cVeh)
		setElementFrozen(localPlayer, true)
		setCameraMatrix(x, y-1, z+15, x, y, z)

	else
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
	  end
end

ShopMarkersTable = {}	

local ShopTable = {
	[1] = {ID = {
	     {541, 1250000} --Bullet 
		,{411, 1250000} --Infernus
		,{415, 1200000} --Cheetah 
		,{451, 1150000} --Turismo 
		,{480, 1000000} --Comet 
		,{495, 950000} --Sandking 
		,{562, 900000} --Elegy 
		,{402, 900000} --Buffalo 
		,{506, 850000} --Super GT 
		,{560, 800000} --Sultan 
		,{475, 800000} --Sabre 
		,{559, 750000} --Jester 
		,{565, 650000} --Flash 
		,{494, 600000} --Hotring Racer
		,{502, 600000} --Hotring Racer 2
		,{503, 600000} --Hotring Racer 3 
		,{444, 600000} --Monster 
		,{556, 600000} --Monster 2 
		,{557, 600000} --Monster 3 
		,{504, 600000} --Bloodring Banger
		,{561, 500000} --Stratum  
		,{558, 450000} --Uranus 
		,{555, 400000} --Windsor 
		,{579, 400000} --Huntley 
		,{477, 350000} --ZR-350 
		,{568, 300000} --Bandito 
		,{424, 300000} --BF Injection 
		,{483, 250000} --Camper 
		,{508, 250000} --Journey 
		,{500, 250000} --Mesa 
		,{542, 200000} --Clover
		,{603, 200000} --Phoenix 
		,{412, 200000} --Voodoo 
		,{535, 200000} --Tornado 
		,{542, 200000} --Slamvan
		,{567, 200000} --Savanna 
	    ,{542, 200000} --Clover
		,{603, 200000} --Phoenix 
		,{412, 200000} --Voodoo 
		,{535, 200000} --Tornado 
		,{542, 200000} --Slamvan
		,{567, 200000} --Savanna 
		,{534, 200000} --Remington 
		,{575, 200000} --Broadway 
		,{536, 200000} --Blade 
		,{406, 150000} --Dumper  
		,{554, 150000} --Yosemite 
		,{458, 150000} --Solair 
	    ,{479, 150000} --Regina 
		,{489, 150000} --Rancher  
		,{404, 150000} --Perennial  
		,{400, 150000} --Landstalker  
		,{420, 150000} --TAXI
	    ,{602, 150000} --Alpha   
		,{496, 150000} --Blista Compact  
		,{401, 150000} --Bravura  
	    ,{518, 150000} --Buccaneer  
		,{527, 150000} --Cadrona   
		,{589, 150000} --Club   
		,{419, 150000} --Esperanto   
		,{587, 150000} --Euros 
		,{533, 150000} --Feltzer   
		,{526, 150000} --Fortune  
		,{474, 150000} --Hermes  
	    ,{545, 150000} --Hustler  
		,{517, 150000} --Majestic   
		,{410, 150000} --Manana   
		,{600, 150000} --Picador   
		,{436, 150000} --Previon 
	    ,{439, 150000} --Stallion    
		,{549, 150000} --Tampa   
		,{491, 150000} --Virgo   
	    ,{445, 150000} --Admiral   
		,{507, 150000} --Elegant    
		,{585, 150000} --Emperor    
		,{466, 150000} --Glendale    
		,{492, 150000} --Greenwood  
		,{546, 150000} --Intruder   
		,{551, 150000} --Merit   
		,{516, 150000} --Nebula  
	    ,{467, 150000} --Oceanic  
		,{426, 150000} --Premier   
		,{547, 150000} --Primo   
		,{405, 150000} --Sentinel   
		,{580, 150000} --Stafford 
	    ,{409, 150000} --Stretch    
		,{550, 150000} --Sunrise   
		,{566, 150000} --Tahoma   
	    ,{540, 150000} --Vincent   
		,{421, 150000} --Washington     
		,{529, 150000} --Willard     
		}, vPosX = -1660, vPosY = 1213, vPosZ = 21.5, PosX = -1657.8, PosY = 1211, PosZ = 6, CamX = -1647, CamY = 1207, CamZ = 24.16, lookAtX = -1660, lookAtY = 1213, lookAtZ = 23}
		}

VehicleShop_Window = guiCreateWindow(screX-350,screY-450, 343, 436, "Automobiliu Parduotuve", false)
guiSetVisible(VehicleShop_Window, false)
guiWindowSetSizable(VehicleShop_Window , false)
guiSetAlpha(VehicleShop_Window, 0.8)
carGrid = guiCreateGridList(9, 20, 324, 360, false, VehicleShop_Window)
guiGridListSetSelectionMode(carGrid, 0)
carColumn = guiGridListAddColumn(carGrid, "Modelis", 0.7)
costColumn = guiGridListAddColumn(carGrid, "Kaina", 0.2)
carButton = guiCreateButton(20, 385, 86, 36,"Pirkti", false, VehicleShop_Window)
guiSetFont (carButton, "default-bold-small")
closeButton = guiCreateButton(237, 385, 86, 36, "Iseiti", false, VehicleShop_Window)
guiSetFont (closeButton, "default-bold-small")
carColorButton = guiCreateButton(128, 385, 86, 36,"Keisti spalva", false, VehicleShop_Window)
guiSetFont (carColorButton, "default-bold-small")
guiSetProperty(carButton, "NormalTextColour", "FF069AF8")
guiSetProperty(closeButton, "NormalTextColour", "FF069AF8")
guiSetProperty(carColorButton, "NormalTextColour", "FF069AF8")  

for i, M in ipairs(ShopTable) do
	ShopMarker = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkerShader = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkersTable[ShopMarker] = true
	setElementID(ShopMarker, tostring(i))
	createBlipAttachedTo(ShopMarker, 55, 2, 255, 255, 255, 255, 0, 500)
end

addEventHandler("onClientGUIClick", resourceRoot,
function()
	if (source == carGrid) then
		local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
		local carprice = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 2)
		if guiGridListGetSelectedItem(carGrid) ~= -1 then
			-- guiSetText(CarName, carName)
			-- guiSetText(CarPrice, "$"..carprice)
			local carID = getVehicleModelFromName(carName)
			if isElement(veh) then
				setElementModel(veh, carID)
				return 
			end
			veh = createVehicle(carID, ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"])
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
		else
			-- guiSetText(CarName, "Noun")
			-- guiSetText(CarPrice, "Noun")
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
		elseif (source == carColorButton) then
		openColorPicker()
	elseif (source == carButton) then
		if guiGridListGetSelectedItem(carGrid) then
			local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
			local carID = getVehicleModelFromName(carName)
			local carCost = guiGridListGetItemText (carGrid, guiGridListGetSelectedItem(carGrid), 2)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
			triggerServerEvent("onBuyNewVehicle", localPlayer, carID, carCost, r1, g1, b1, r2, g2, b2)
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	elseif (source == closeButton) then
		if guiGetVisible(VehicleShop_Window) then 
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	end
end)

function openColorPicker()
	if (colorPicker.isSelectOpen) or not isElement(veh) then return end
	colorPicker.openSelect(colors)
end

function closedColorPicker()
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (veh and isElement(veh)) then
		r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
	end
end
addEventHandler("onClientRender", root, updateColor)

--[[addCommandHandler("xx", function()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	setCameraMatrix(x, y, z, lx, ly, lz)
	outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..z)
end)]]

addEventHandler("onClientMarkerHit", resourceRoot,
function(player)
	if getElementType(player) ~= "player" or player ~= localPlayer or isPedInVehicle(player) then return end
	if ShopMarkersTable[source] then
		i = tonumber(getElementID(source))
		guiGridListClear(carGrid)
		for i, v in ipairs(ShopTable[i]["ID"]) do
			local carName = getVehicleNameFromModel(v[1])
			local row = guiGridListAddRow(carGrid)
			guiGridListSetItemText(carGrid, row, 1, carName, false, true)
			guiGridListSetItemText(carGrid, row, 2, tostring(v[2]), false, true)
		end
		setCameraMatrix(ShopTable[i]["CamX"], ShopTable[i]["CamY"], ShopTable[i]["CamZ"], ShopTable[i]["lookAtX"], ShopTable[i]["lookAtY"], ShopTable[i]["lookAtZ"])
		guiSetVisible(VehicleShop_Window, true)
		showCursor(true)
		guiGridListSetSelectedItem(carGrid, 0, 1)
		setTimer(function()
			setElementFrozen(localPlayer, true)
			local carName = guiGridListGetItemText(carGrid, 0, 1)
			local carID = getVehicleModelFromName(carName)
			local x, y, z = ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"]
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			veh = createVehicle(carID, x, y, z)
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
		end, 100, 1)
	end
end)