local screenWidth, screenHeight = guiGetScreenSize()

-- 'Textures'
local speedometerBG = "textures/speedometerBG.png" 
local speedoBGTex = dxCreateTexture ( speedometerBG, "argb", true, "clamp" )
local speedometerBG2 = "textures/speedometerBG2.png"
local speedoBGTex2 = dxCreateTexture ( speedometerBG2, "argb", true, "clamp" )
local speedometerNeedleWhite = "textures/speedometerNeedleWhite.png"
local speedometerNeedleRed = "textures/speedometerNeedleRed.png"
local speedometerOverlay = "textures/speedometerOverlay.png"
local speedometerGlass = "textures/speedometerGlass.png"
local carState = "textures/carState.png"
local nitroState ="textures/nitroState.png"

local compatible = {['Automobile']=true,['Bike']=true,['Quad']=true,['Monster Truck']=true}
local hpcompatible = {['Boat']=true,['Helicopter']=true,['Plane']=true}

local smoothedRPMRotation = 0
local vehicleNos = nil
local vehicleRPM = 0

-- 'fonts'

function loadFonts()
	if not fontPrototype10 then
		if fileExists("fonts/Prototype.ttf") and not fontPrototype10 then
			fontPrototype10 = dxCreateFont("fonts/Prototype.ttf", 10)
			fontPrototype40 = dxCreateFont("fonts/Prototype.ttf", 40)
			fontLCD22 = dxCreateFont("fonts/lcd.ttf", 22)
			speedoBGTex2 = dxCreateTexture ( speedometerBG2, "argb", true, "clamp" )
			speedoBGTex = dxCreateTexture ( speedometerBG, "argb", true, "clamp" )
		end
	end
end
loadFonts()

-- 'vehicle speed'
local function getVehicleSpeed()   
    if (vehicle) then
        local vx, vy, vz = getElementVelocity(vehicle)
        
        if (vx) and (vy)and (vz) then
            return math.sqrt(vx^2 + vy^2 + vz^2) * 180 -- km/h
        else
            return 0
        end
    else
        return 0
    end
end


local function getVehicleSpeedString() 
    local speedString = math.floor(getVehicleSpeed() + 0.5)
    return string.format("%03d", speedString)
end


-- 'vehicle gear'
local function getVehicleGear()    
    if (vehicle) then
        local vehicleGear = getVehicleCurrentGear(vehicle)
        
        return tonumber(vehicleGear)
    else
        return 0
    end
end


local function getFormattedVehicleGear()
    local gear = getVehicleGear()
    local rearString = "R"
    
    if (gear > 0) then
        return gear
    else
        return rearString
    end
end


-- 'vehicle rpm'
local function getVehicleRPM() 
    if (vehicle) then   
        if (isVehicleOnGround(vehicle)) then
            isVehicleInStunt = "false"
           
            if (getVehicleEngineState(vehicle) == true) then
                if(getVehicleGear() > 0) then
                    vehicleRPM = math.floor(((getVehicleSpeed()/getVehicleGear())*180) + 0.5)
                    
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9800) then
                        vehicleRPM = 9800
                    end
                else
                    vehicleRPM = math.floor(((getVehicleSpeed()/1)*180) + 0.5)
                    
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9800) then
                        vehicleRPM = 9800
                    end
                end
            else
                vehicleRPM = 0
            end
        else
            isVehicleInStunt = "true"
            
            if (getVehicleEngineState(vehicle) == true) then
                vehicleRPM = vehicleRPM - 150
                    
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = 9800
                end
            else
                vehicleRPM = 0
            end
        end
        
        return tonumber(vehicleRPM)
    else
        return 0
    end
end


local function getRPMRoation()
	local currentRPM = getVehicleRPM()
    if currentRPM and currentRPM >= 0 then
    local rpmRotation = math.floor(((270/9800)* currentRPM) + 0.5)
        
        if (smoothedRPMRotation < rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation + 2
        end
        
        if (smoothedRPMRotation > rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation - 2
        end
        
        return tonumber(smoothedRPMRotation)
    else
        return 0
    end   
end


local function getFormattedRpmRotation()
    local rpm = getRPMRoation()
    local rpm1 = rpm
    local rpm2 = rpm
    local rpm3 = rpm
    local rpm4 = rpm
    
    if (rpm1 >= 90) then
        rpm1 = 90
    elseif (rpm1 < 0) then
        rpm1 = 0
    end
    
    if (rpm2 >= 180) then
        rpm2 = 180
    elseif (rpm2 < 0) then
        rpm2 = 0
    end
    
    if (rpm3 >= 219) then
        rpm3 = 219
    elseif (rpm3 < 0) then
        rpm3 = 0
    end
        
    if (rpm4 >= 360) then
        rpm4 = 360
    elseif (rpm4 < 0) then
        rpm4 = 0
    end
    
    return rpm1, rpm2, rpm3, rpm4
end


local function getCarStateColor()
    local health = getElementHealth(vehicle)
    local maxHealth = getElementData(vehicle,'armored') and 2000 or 1000
    if (health) then
        local g = (255/maxHealth) * health
        local r = 255 - g
        local b = 0
     
        return r, g, b
    else
        return 0, 255, 0
    end
end


local function getNitroStateColor()   
    local nitro = getVehicleUpgradeOnSlot(vehicle, 8)
     
    if (nitro > 0) then
        return 0, 255, 0
    else
        return 75, 75, 75
    end
end

local function getFormattedVehicleHealth()
	local maxhp = getElementData(vehicle,'armored') and 1750 or 750
    local health = math.max((getElementHealth(vehicle) - 250),0)
    return math.floor(((getElementData(vehicle,'armored') and 200 or 100)/maxhp) * health)
end

local function speedoMeterGUI() 
	local target = getCameraTarget()
	vehicle = target and getElementType(target) == 'vehicle' and target or getPedOccupiedVehicle(localPlayer)
    if (vehicle) then 
		if compatible[getVehicleType(vehicle)] then
			local rpm1, rpm2, rpm3, rpm4 = getFormattedRpmRotation()
			-- 'Speedometer'
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedoBGTex)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerNeedleRed, rpm4)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerNeedleWhite, rpm3)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerNeedleWhite, rpm2)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerNeedleWhite, rpm1)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedoBGTex2)
			dxDrawText(getFormattedVehicleGear(), screenWidth - 160, screenHeight - 245, screenWidth - 160, screenHeight - 245, tocolor(255, 255, 255, 255), 1, fontPrototype40, "left", "top", false, false, false)
			dxDrawText("OOO", screenWidth - 160, screenHeight - 185, screenWidth - 160, screenHeight - 185, tocolor(25, 25, 25, 255), 1, fontLCD22, "left", "top", false, false, false)
			dxDrawText("***", screenWidth - 160, screenHeight - 185, screenWidth - 160, screenHeight - 185, tocolor(25, 25, 25, 255), 1, fontLCD22, "left", "top", false, false, false)
			dxDrawText(getVehicleSpeedString(), screenWidth - 160, screenHeight - 185, screenWidth - 160, screenHeight - 185, tocolor(255, 255, 255, 255), 1, fontLCD22, "left", "top", false, false, false)
			dxDrawText("km/h", screenWidth - 110, screenHeight - 170, screenWidth - 110, screenHeight - 170, tocolor(255, 255, 255, 255), 1, fontPrototype10, "left", "top", false, false, false)
			local nsr, nsg, nsb = getNitroStateColor()
			dxDrawImage(screenWidth - 108, screenHeight - 230, 24, 24, nitroState, 0, 0, 0, tocolor(nsr, nsg, nsb, 255), false)
			local csr, csg, csb = getCarStateColor()
			dxDrawImage(screenWidth - 108, screenHeight - 200, 24, 24, carState, 0, 0, 0, tocolor(csr, csg, csb , 255), false)
			dxDrawText(getFormattedVehicleHealth(),screenWidth - 97, screenHeight - 191, screenWidth - 95, screenHeight - 185, tocolor(5, 5, 5, 255), 0.7, 'default-bold', "center", "top", false, false, false)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerOverlay)
			dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 345), 200, 200, speedometerGlass)
		elseif hpcompatible[getVehicleType(vehicle)] then
			local csr, csg, csb = getCarStateColor()
			dxDrawImage(screenWidth - 108, screenHeight - 200, 24, 24, carState, 0, 0, 0, tocolor(csr, csg, csb , 255), false)
			dxDrawText(getFormattedVehicleHealth(),screenWidth - 97, screenHeight - 191, screenWidth - 95, screenHeight - 185, tocolor(5, 5, 5, 255), 0.7, 'default-bold', "center", "top", false, false, false)
		end
    end
end
if screenWidth > 800 then
	if fileExists(speedometerBG) then
		addEventHandler("onClientRender", root, speedoMeterGUI)
	end
end

addEvent('toggleSPEEDO',false)
addEventHandler('toggleSPEEDO',getRootElement(),function(toggle)
	if screenWidth > 800 then
		if enabled == toggle then return end
		enabled = toggle
		if not toggle then
			removeEventHandler("onClientRender", root, speedoMeterGUI)
		else
			addEventHandler("onClientRender", root, speedoMeterGUI)
		end
	end
end)

local images = {'textures/carState.png','textures/nitroState.png','textures/speedometerBG.png','textures/speedometerBG2.png','textures/speedometerGlass.png','textures/speedometerNeedleRed.png','textures/speedometerNeedleWhite.png','textures/speedometerOverlay.png','fonts/lcd.ttf','fonts/Prototype.ttf'}

addEvent('setupShader7Download',true)
addEventHandler('setupShader7Download',getRootElement(),function()
	for i,v in ipairs(images)do
		if not fileExists(v) then
			triggerServerEvent('downloadShader',localPlayer,'speedo_gfx',v)
			setElementData(source,'downloading','misc')
			return
		end
	end
	loadFonts()
	if screenWidth > 800 then
		addEventHandler("onClientRender", root, speedoMeterGUI)
	end
	setElementData(source,'downloading',nil)
	triggerEvent('setupShader8Download',source)
end)

addEvent('receiveShaderData',true)
addEventHandler('receiveShaderData',getRootElement(),function(dataFlow,res,name)
	if res ~= 'speedo_gfx' then return end
	local file = fileCreate(name)
	fileWrite(file, dataFlow)
	fileClose(file)
	triggerEvent('setupShader7Download',source)
end)

addCommandHandler('dl',function()
	if isPedInVehicle(localPlayer) then
		outputChatBox('ID: '..getElementModel(getPedOccupiedVehicle(localPlayer))..' HP: '..getFormattedVehicleHealth()..'%',255,180,0)
	end
end)
