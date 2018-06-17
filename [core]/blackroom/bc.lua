local screenW, screenH = guiGetScreenSize()

addEventHandler("onClientRender", root,
    function()
        dxDrawText("MTA-SABR.com", screenW * 0.7738, screenH * 0.0208, screenW * 0.9583, screenH * 0.0560, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText("San Andreas Black Room 0.5r", screenW * 0.8126, screenH * 0.9818, screenW * 0.9341, screenH * 0.9000, tocolor(136, 135, 134, 230), 1.00, "default", "left", "top", false, false, true, false, false)
    end
)

setBlurLevel(0)

FPSLimit = 100
FPSMax = 1

function onClientResourceStart ( resource )
	if ( not isElement(guiFPSLabel )) then
		FPSLimit = 255 / FPSLimit
		guiFPSLabel	= guiCreateLabel ( 0.00, 0.94, 0.2, 0.1, "FPS: 0", true )
		guiSetFont(guiFPSLabel,'default-bold-small')
		guiLabelSetColor ( guiFPSLabel, 120,120,120 )
		FPSCalc = 0
		FPSTime = getTickCount() + 1000
		addEventHandler ( "onClientRender", getRootElement (), onClientRenderr )
	end
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onClientResourceStart )

function onClientRenderr ( )
	if ( getTickCount() < FPSTime ) then
		FPSCalc = FPSCalc + 1
	else
		if ( FPSCalc > FPSMax ) then FPSLimit = 255 / FPSCalc FPSMax = FPSCalc end
		setElementData(localPlayer,'fpscalc',FPSCalc)
		guiSetText ( guiFPSLabel, "FPS: "..FPSCalc.." Max: "..FPSMax )
		--guiLabelSetColor ( guiFPSLabel, 255 - math.ceil ( FPSCalc * FPSLimit ), math.ceil ( FPSCalc * FPSLimit ), 0 )
		FPSCalc = 0
		FPSTime = getTickCount() + 1000
	end
end

showingMessages = true
addEvent('toggleEXP',false)
addEventHandler('toggleEXP',getRootElement(),function(toggle)
	if showingMessages == toggle then return end
	showingMessages = toggle
	if not toggle then
		guiSetVisible(guiFPSLabel,false)
		removeEventHandler ( "onClientRender", getRootElement (), onClientRenderr )
	else
		guiSetVisible(guiFPSLabel,true)
		addEventHandler ( "onClientRender", getRootElement (), onClientRenderr )
	end
end)



local screenW, screenH = guiGetScreenSize()


addEventHandler("onClientRender", root,
    function()
        dxDrawRectangle(screenW * 0.8089, screenH * 0.8438, screenW * 0.1911, screenH * 0.1563, tocolor(0, 0, 0, 200), false)
        dxDrawText("+1337", screenW * 0.8902, screenH * 0.8568, screenW * 0.9597, screenH * 0.8841, tocolor(219, 82, 46, 255), 0.70, "bankgothic", "right", "top", false, false, false, false, false)    
		dxDrawText("EXP:", screenW * 0.8477, screenH * 0.8581, screenW * 0.8865, screenH * 0.8919, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "left", "top", false, false, false, false, false)
        dxDrawText("420", screenW * 0.8265, screenH * 0.8906, screenW * 1.0000, screenH * 0.9753, tocolor(255, 255, 255, 255), 3, "bankgothic", "right", "top", false, false, false, false, false)
    end
)

DGS = exports.dgs
progressbar = DGS:dgsCreateProgressBar(screenW * 0.8448, screenH * 0.8867, screenW * 0.1164, screenH * 0.0104, false ) 
DGS:dgsSetProperty(progressbar,"bgcolor",tocolor(0,0,0,200))
DGS:dgsSetProperty(progressbar,"barcolor",tocolor(255,255,255,200))      
number = 0 
setTimer(function ()
	number = number + 1 
	DGS:dgsProgressBarSetProgress(progressbar,number)
	if number == 100 then
		number = 0
	end 
end,3000,0)

local explosionEnabled = true
local explostionDistance = 150

addEventHandler("onClientExplosion", getRootElement(), function(x,y,z, theType)
	if(explosionEnabled)then
		if(theType == 0)then--Grenade
			local explSound = playSound3D("explosion1.mp3", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		elseif(theType == 4 or theType == 5 or theType == 6 or theType == 7)then --car, car quick, boat, heli
			local explSound = playSound3D("explosion3.mp3", x,y,z)
			setSoundMaxDistance(explSound, explostionDistance)
		end
	end
end)

addEventHandler("onClientPlayerWeaponFire", root, 
function (weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement) 
    if (weapon) and (getElementType(hitElement)=="player") then 
        playSound3D("camp1.wav", hitX, hitY, hitZ, false) 
    end 
end 
) 
