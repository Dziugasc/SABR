--Trucking colored nametags

nametag = {}
local nametags = {}
local g_screenX,g_screenY = guiGetScreenSize()
local gui = {}
local flasher = 127  

local NAMETAG_SCALE = 0.2 --Overall adjustment of the nametag, use this to resize but constrain proportions
local NAMETAG_ALPHA_DISTANCE = 40 --Distance to start fading out
local NAMETAG_DISTANCE = 70 --Distance until we're gone
local NAMETAG_ALPHA = 110 --The overall alpha level of the nametag
--The following arent actual pixel measurements, they're just proportional constraints
local NAMETAG_TEXT_BAR_SPACE = 2
local NAMETAG_WIDTH = 65
local NAMETAG_HEIGHT = 5
local NAMETAG_TEXTSIZE = 0.26
local NAMETAG_OUTLINE_THICKNESS = 1.2
--default
local NAMETAG_FONT = "bankgothic"
local NAMETAG_SHADOW = 0
local NAMETAG_BAR_TYPE = 1
local NAMETAG_BAR_RED = 1
local NAMETAG_BAR_FRAME = 1
local NAMETAG_MY = 1
local NAMETAG_NAME_DDCCOLOR = 1
local NAMETAG_BAR_DDCCOLOR = 1
local fonts = { "default", "default-bold", "clear", "arial", "sans", "pricedown", "bankgothic", "diploma", "beckett" }
local nametagsvisible = true
--
local NAMETAG_ALPHA_DIFF = NAMETAG_DISTANCE - NAMETAG_ALPHA_DISTANCE
NAMETAG_SCALE = 1/NAMETAG_SCALE * 800 / g_screenY 

esquisito = "default"
boogaloo = "default"


-- Ensure the name tag doesn't get too big
local maxScaleCurve = { {0, 0}, {3, 3}, {13, 5} }
-- Ensure the text doesn't get too small/unreadable
local textScaleCurve = { {0, 0.8}, {0.8, 1.2}, {99, 99} }
-- Make the text a bit brighter and fade more gradually
local textAlphaCurve = { {0, 0}, {25, 100}, {120, 190}, {255, 255} }
local headtexts = {}
local headtimers = {}

local function drawHeadTexts()
	local x,y,z = getCameraMatrix()
	local mydim = getElementDimension(gMe)
	for player,headtext in pairs(headtexts) do
		if not isPedDead(player) then
			while true do
				if not isElement(player) then
					headtexts[player] = nil
					break
				end
				local px,py,pz = getPedBonePosition ( player,3 )
				local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				if pdistance <= NAMETAG_DISTANCE and getElementDimension(player) == mydim and isLineOfSightClear(px, py, pz+0.8,x,y,z,true,false,false) and getElementAlpha(player) > 0 then
					--Get screenposition
					local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.8, 0.06 )
					if not sx or not sy then break end
					--Calculate our components
					local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE))
					local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE) / NAMETAG_ALPHA_DIFF)
					alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
					scale = math.evalCurve(maxScaleCurve,scale)
					local textscale = math.evalCurve(textScaleCurve,scale)
					local textalpha = math.evalCurve(textAlphaCurve,alpha)
					--Draw our text
					local r,g,b = 255,175,0
					local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
					--dxDrawText ( getPlayerName(player), sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, "default", "center", "bottom", false, false, false )
					dxDrawText( headtext, sx + 1, sy - offset + 1, sx + 1, sy - offset + 1, tocolor(0,0,0,255), textscale*NAMETAG_TEXTSIZE, esquisito, 'center', 'bottom', false, false, false )
					dxDrawText( headtext, sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, esquisito, 'center', 'bottom' )
				end
				break
			end
		end
	end
end

local NAMETAG_DISTANCE_ = 80
local NAMETAG_DISTANCE__ = 110
local NAMETAG_ALPHA_DISTANCE_ = 15
local NAMETAG_HEALTH_HEIGHT = 10
local NAMETAG_ALPHA_DIFF_ = NAMETAG_DISTANCE_ - NAMETAG_ALPHA_DISTANCE_
local function drawNametags()
	local x,y,z = getCameraMatrix()
	--local mydim = getElementDimension(gMe)
	for i,player in ipairs(getElementsByType('player',root,true)) do
		 while true do
                if isPedDead(player) or player == localPlayer then break end
               -- local vehicle = getPedOccupiedVehicle(player)
				--if vehicle then break end
                local px,py,pz = getPedBonePosition ( player,3 )
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if pdistance <= NAMETAG_DISTANCE_ and getElementDimension(player) == mydim and isLineOfSightClear(px, py, pz,x,y,z,true,false,false,true) then
                    --Get screenposition
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz, 0.06 )
                    if not sx or not sy then break end
                    --Calculate our components
                    local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE__))
                    local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE_) / NAMETAG_ALPHA_DIFF_)
                    alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
                    scale = math.evalCurve(maxScaleCurve,scale)
                    local textscale = math.evalCurve(textScaleCurve,scale)
                    local textalpha = math.evalCurve(textAlphaCurve,alpha)
                    --local outlineThickness = NAMETAG_OUTLINE_THICKNESS*(scale)
                    local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
					local r,g,b = getPlayerNametagColor(player)
					--[[if getPlayerTeam(player) then
						r,g,b = getTeamColor(getPlayerTeam(player))
					else--]]
						--r,g,b = getPlayerNametagColor(player)
					--end
					--text
					dxDrawText( getPlayerName(player), sx+2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(player), sx-2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					dxDrawText( getPlayerName(player), sx, sy - offset+2, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(player), sx, sy - offset-2, sx, sy - offset, tocolor(0,0,0,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					dxDrawText( getPlayerName(player), sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--amor
					local width,height =  NAMETAG_WIDTH*scale, NAMETAG_HEIGHT*scale
					local drawX = sx - NAMETAG_WIDTH*scale/2
					local armor = getPedArmor(player)
					if armor > 0 then
						height = height + 2
						dxDrawRectangle(drawX, sy, width, height, tocolor(0,0,0,textalpha))
						dxDrawRectangle(drawX+2, sy+2, ((width-4)/100)*armor, height-4, tocolor(192,192,192,textalpha) )
					end
					local barcolor = tocolor(r,g,b,textalpha) 
					local health = getElementData(player,'minigame') == 'derby' and (getElementHealth(getPedOccupiedVehicle(player)) / 10) or getElementHealth(player)
					local drawY = sy + height + offset
					-- We draw three parts to make the healthbar.  First the outline/background		
					dxDrawRectangle(drawX, drawY, width, height, tocolor(0,0,0,textalpha))
					dxDrawRectangle(drawX+2, drawY+2, ((width-4)/100)*health, height-4, barcolor )
				end
				break
            end
	end
end
addEventHandler('onClientRender',root,drawNametags,true,"low-6")

local function drawNametagsCarball()
	local x,y,z = getCameraMatrix()
	local mydim = getElementDimension(localPlayer)
	for i,vehicle in ipairs(getElementsByType('vehicle',root,true)) do
		 while true do
                if getElementAlpha(vehicle) == 0 then break end
               -- local vehicle = getPedOccupiedVehicle(player)
				--if vehicle then break end
                local px,py,pz = getElementPosition ( vehicle )
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if pdistance <= NAMETAG_DISTANCE_ and getElementDimension(vehicle) == mydim and isLineOfSightClear(px, py, pz,x,y,z,true,false,false,true) then
                    --Get screenposition
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.5, 0.06 )
                    if not sx or not sy then break end
                    --Calculate our components
                    local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE__))
                    local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE_) / NAMETAG_ALPHA_DIFF_)
                    alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
                    scale = math.evalCurve(maxScaleCurve,scale)
                    local textscale = math.evalCurve(textScaleCurve,scale)
                    local textalpha = math.evalCurve(textAlphaCurve,alpha)
                    --local outlineThickness = NAMETAG_OUTLINE_THICKNESS*(scale)
                    local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
					local r,g,b = getVehicleColor(vehicle,true)
					--[[if getPlayerTeam(player) then
						r,g,b = getTeamColor(getPlayerTeam(player))
					else--]]
						--r,g,b = getPlayerNametagColor(player)
					--end
					--text
					dxDrawText( getElementData(vehicle,'name'), sx+2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(player), sx-2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					dxDrawText(getElementData(vehicle,'name'), sx, sy - offset+2, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(player), sx, sy - offset-2, sx, sy - offset, tocolor(0,0,0,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					dxDrawText( getElementData(vehicle,'name'), sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--amor
				end
				break
            end
	end
end

local function renderPoliceNametags()
	local x,y,z = getCameraMatrix()
	local mydim = getElementDimension(gMe)
	if mydim ~= 0 then return end
	for i,player in ipairs(getElementsByType('player',root,true)) do
		if not isPedDead(player) and player ~= localPlayer and getElementData(player,'wantedlevel') and getElementData(player,'wantedlevel') > 0 then
			while true do
				local px,py,pz = getPedBonePosition ( player,3 )
				local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				if pdistance <= NAMETAG_DISTANCE and getElementDimension(player) == mydim and isLineOfSightClear(px, py, pz+0.8,x,y,z,true,false,false) and getElementAlpha(player) > 0 then
					--Get screenposition
					local sx,sy = getScreenFromWorldPosition ( px, py, pz+1, 0.06 )
					if not sx or not sy then break end
					--Calculate our components
					local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE))
					local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE) / NAMETAG_ALPHA_DIFF)
					alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
					scale = math.evalCurve(maxScaleCurve,scale)
					local textscale = math.evalCurve(textScaleCurve,scale)
					local textalpha = math.evalCurve(textAlphaCurve,alpha)
					--Draw our text
					local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
					--dxDrawText ( getPlayerName(player), sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, "default", "center", "bottom", false, false, false )
					local wlevel = getElementData(player,'wantedlevel')
					for i=1, wlevel do
						dxDrawImage(sx + (wlevel/2)*(textscale*10) - i*(textscale*10), sy - offset + 1, textscale*(10/1650*g_screenX), textscale*(9/1080*g_screenY),'images/star.png',0,0,0,tocolor(255,255,255,textalpha))
					end
					local sx,sy = getScreenFromWorldPosition ( px, py, pz+1.2, 0.06 )
					if getPedTarget(gMe) == player and getPedWeapon(gMe) == 22 and getKeyState('lalt') and not isPedInVehicle(gMe) then
						dxDrawText( "TAZE!", sx, sy - offset, sx, sy - offset, tocolor(0,255,255,textalpha), textscale*NAMETAG_TEXTSIZE, esquisito, 'center', 'bottom' )
					end
				end
				break
			end
		end
	end
end

local function drawVehicleBars()
	local x,y,z = getCameraMatrix()
	local mydim = getElementDimension(gMe)
	if mydim ~= 0 then return end
	for i,vehicle in ipairs(getElementsByType('vehicle',root,true)) do
		 while true do
                if isVehicleBlown(vehicle) or getVehicleType(vehicle) == 'BMX' or getVehicleType(vehicle) == 'Trailer' or vehicle == getPedOccupiedVehicle(localPlayer) then break end
               -- local vehicle = getPedOccupiedVehicle(vehicle)
				--if vehicle then break end
                local px,py,pz = getElementPosition ( vehicle )
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				local mydim = getElementDimension(localPlayer)
                if pdistance <= NAMETAG_DISTANCE_ and getElementDimension(vehicle) == mydim and isLineOfSightClear(px, py, pz,x,y,z,true,false,false,true) then
                    --Get screenposition
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz+getElementDistanceFromCentreOfMassToBaseOfModel(vehicle), 0.06 )
                    if not sx or not sy then break end
                    --Calculate our components
                    local scale = 1/(NAMETAG_SCALE * (pdistance / NAMETAG_DISTANCE__))
                    local alpha = ((pdistance - NAMETAG_ALPHA_DISTANCE_) / NAMETAG_ALPHA_DIFF_)
                    alpha = (alpha < 0) and NAMETAG_ALPHA or NAMETAG_ALPHA-(alpha*NAMETAG_ALPHA)
                    scale = math.evalCurve(maxScaleCurve,scale)
                    local textscale = math.evalCurve(textScaleCurve,scale)
                    local textalpha = math.evalCurve(textAlphaCurve,alpha)
                    --local outlineThickness = NAMETAG_OUTLINE_THICKNESS*(scale)
                    local offset = (scale) * NAMETAG_TEXT_BAR_SPACE/2
					local r,g,b,health = getCarStateColor(vehicle)
					--[[if getPlayerTeam(vehicle) then
						r,g,b = getTeamColor(getPlayerTeam(vehicle))
					else--]]
						--r,g,b = getPlayerNametagColor(vehicle)
					--end
					--text
					--dxDrawText( getPlayerName(vehicle), sx+2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(vehicle), sx-2, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(vehicle), sx, sy - offset+2, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(vehicle), sx, sy - offset-2, sx, sy - offset, tocolor(0,0,0,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--dxDrawText( getPlayerName(vehicle), sx, sy - offset, sx, sy - offset, tocolor(r,g,b,textalpha), textscale*NAMETAG_TEXTSIZE, boogaloo, 'center', 'bottom',false,false,false,false,true )
					--amor
					local width,height =  NAMETAG_WIDTH*scale, NAMETAG_HEIGHT*scale
					local drawX = sx - NAMETAG_WIDTH*scale/2
					--[[local armor = getPedArmor(vehicle)
					if armor > 0 then
						height = height + 2
						dxDrawRectangle(drawX, sy, width, height, tocolor(0,0,0,textalpha))
						dxDrawRectangle(drawX+2, sy+2, ((width-4)/100)*armor, height-4, tocolor(192,192,192,textalpha) )
					end--]]
					local barcolor = tocolor(r,g,b,textalpha) 
					local drawY = sy + height + offset
					-- We draw three parts to make the healthbar.  First the outline/background		
					dxDrawRectangle(drawX, drawY, width, height, tocolor(0,0,0,textalpha))
					local maxHealth = getElementData(vehicle,'armored') and 1250 or 750
					dxDrawRectangle(drawX+2, drawY+2, ((width-4)/maxHealth)*math.max((health-250),0), height-4, barcolor )
				end
				break
            end
	end
end

function getCarStateColor(vehicle)
    local health = getElementHealth(vehicle)
        
    if (health) then
        local g = math.min((255/1000) * health,255)
        local r = 255 - g
        local b = 0
     
        return r, g, b,health
    else
        return 0, 255, 0,health
    end
end

function math.lerp(from,to,alpha)
    return from + (to-from) * alpha
end

function math.evalCurve( curve, input )
	-- First value
	if input<curve[1][1] then
		return curve[1][2]
	end
	-- Interp value
	for idx=2,#curve do
		if input<curve[idx][1] then
			local x1 = curve[idx-1][1]
			local y1 = curve[idx-1][2]
			local x2 = curve[idx][1]
			local y2 = curve[idx][2]
			-- Find pos between input points
			local alpha = (input - x1)/(x2 - x1);
			-- Map to output points
			return math.lerp(y1,y2,alpha)
		end
	end
	-- Last value
	return curve[#curve][2]
end

function setPlayerHeadText(player,text)
	if player ~= gMe then
		headtexts[player] = text
		if isTimer(headtimers[player])then
			killTimer(headtimers[player])
		end
		if text ~= 'VIP' then
			headtimers[player] = setTimer(removePlayerHeadText,2000,1,player)
		end
		if not isEventHandlerAdded( "onClientRender", root,drawHeadTexts ) and nametagsvisible then
			addEventHandler ( "onClientRender", root,drawHeadTexts)
		end
	end
end
addEvent('onHeadText',true)
addEventHandler('onHeadText',root,setPlayerHeadText)

function removePlayerHeadText(player)
	if getElementData(player,'vip') and not getElementData(player,'dutyoff') then
		headtexts[player] = 'VIP'
	else
		headtexts[player] = nil
		if cTbl(headtexts) == 0 then
			removeEventHandler ( "onClientRender", root,drawHeadTexts)
		end
	end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
 
	return false
end

function setNametagsVisible(state)
	if state == nametagsvisible then return end
	nametagsvisible = state
	if nametagsvisible then
		addEventHandler('onClientRender',root,drawNametags,true,"low-6")
		if cTbl(headtexts) > 0 then
			addEventHandler ( "onClientRender", root,drawHeadTexts)
		end
	else
		removeEventHandler('onClientRender',root,drawNametags)
		if cTbl(headtexts) > 0 then
			removeEventHandler ( "onClientRender", root,drawHeadTexts)
		end
	end
end

function setCarballMode(state)
	if state then
		removeEventHandler('onClientRender',root,drawNametags)
		addEventHandler('onClientRender',root,drawNametagsCarball,true,"low-6")
	else
		addEventHandler('onClientRender',root,drawNametags,true,"low-6")
		removeEventHandler('onClientRender',root,drawNametagsCarball)
	end
end

local barsvisible = false
function setVehicleBarsVisible(state)
	if state == barsvisible then return end
	barsvisible = state
	if barsvisible then
		addEventHandler('onClientRender',root,drawVehicleBars,true,"low-6")
	else
		removeEventHandler('onClientRender',root,drawVehicleBars)
	end
end

local plcbarsvisible = false
function setPoliceNametags(state)
	if state == plcbarsvisible then return end
	plcbarsvisible = state
	if plcbarsvisible then
		addEventHandler('onClientRender',root,renderPoliceNametags,true,"low-5")
	else
		removeEventHandler('onClientRender',root,renderPoliceNametags)
	end
end


