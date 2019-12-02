local screenWidth, screenHeight = guiGetScreenSize()
local posX, posY = 10, 10

local TIMEFONT = dxCreateFont("client/RB.ttf", 11, false, "draft")
local MONEYFONT = dxCreateFont("client/RB.ttf", 12, false, "draft")
local COINSFONT = dxCreateFont("client/RB.ttf", 8, false, "draft")
local EXPFONT = dxCreateFont("client/RB.ttf", 7, false, "draft")

local health = 0
local nextHealth = getElementHealth(localPlayer)

local armor = 0
local nextArmor = getPedArmor(localPlayer)

local cap = 100
local nextCap = (getElementData(localPlayer, "zg:helmtprotection") == "sim" and 255 or 100)

local money = 0
local nextMoney = getPlayerMoney()


local ticks = {
	health = getTickCount(),
	armor = getTickCount(),
	cap = getTickCount(),
	money = getTickCount()
}

addEventHandler("onClientRender", root,
	function()


		local hX = interpolateBetween(health, 0, 0, nextHealth, 0, 0, (getTickCount() - ticks.health) / 3000, "Linear")
		local aX = interpolateBetween(armor, 0, 0, nextArmor, 0, 0, (getTickCount() - ticks.armor) / 3000, "Linear")
		local cA = interpolateBetween(cap, 0, 0, nextCap, 0, 0, (getTickCount() - ticks.cap) / 3000, "Linear")
		local m = interpolateBetween(money, 0, 0, nextMoney, 0, 0, (getTickCount() - ticks.money) / 5000, "Linear")

		armor = aX
		health = hX
		cap = cA
		money = m

		--exports["PainelBlur"]:dxDrawBluredRectangle((screenWidth-240)-posX, posY, 238, 32, tocolor(255, 255, 255, 255))
		local HP_BAR = 30/getPedMaxHealth(localPlayer)*health
	    local CO_BAR = 30/100*armor
		local stat = getPedStat ( getLocalPlayer(), 24 )
		local maxclip = tonumber(getWeaponProperty(getPedWeapon(getLocalPlayer()), "poor", "maximum_clip_ammo") or 1 )
		local sp1 = math.ceil((getPedTotalAmmo(getLocalPlayer())-getPedAmmoInClip(getLocalPlayer()))/maxclip)
		local sp2 = getPedAmmoInClip(getLocalPlayer())
		
		
		dxDrawImage((screenWidth-240)-posX, posY, 238, 32, "assets/bg.png")
		dxDrawRectangle((screenWidth-44)-25-posX, posY+1,CO_BAR,30,tocolor(116, 176, 228, 150), false)
		dxDrawImage((screenWidth-145)-5-posX, posY+2, 28, 28, "assets/hud_m.png")
		dxDrawText (string.format("%08d", money), (screenWidth-135)-95-posX, posY+0, screenWidth, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, MONEYFONT) 
		dxDrawText (getElementData(localPlayer,"zg:money") or 0, (screenWidth-26)-9-posX, posY+17, (screenWidth-140)-9-posX, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, COINSFONT, "right") 
		
	    dxDrawRectangle((screenWidth-79)-25-posX, posY+1,HP_BAR,30,tocolor(194, 225, 99, 150), false)
		
		dxDrawImage((screenWidth-30)-5-posX, posY+1, 32, 30, "assets/hud_ca.png", 0,0,0, tocolor (255, 255, 255, cap))
			
		dxDrawImage((screenWidth-66)-5-posX, posY+1, 32, 30, "assets/hud_co.png",0,0,0, tocolor (255, 255, 255, 255))
		
		dxDrawImage((screenWidth-100)-5-posX, posY+1, 32, 30, "assets/hud_h.png")

		if getElementHealth(localPlayer) >= 0 then
			if getElementHealth(localPlayer) ~= nextHealth then
				nextHealth = getElementHealth(localPlayer)
				ticks.health = getTickCount()
			end
		end

		if getPedArmor(localPlayer) >= 0 then
			if getPedArmor(localPlayer) ~= nextArmor then
				nextArmor = getPedArmor(localPlayer)
				ticks.armor = getTickCount()
			end
		end

		if getPlayerMoney() >= 0 then
			if getPlayerMoney() ~= nextMoney then
				nextMoney = getPlayerMoney()
				ticks.money = getTickCount()
			end
		end

		if (getElementData(localPlayer, "zg:helmtprotection") == "sim" and 255 or 100) ~= nextCap then
			nextCap = (getElementData(localPlayer, "zg:helmtprotection") == "sim" and 255 or 100)
			ticks.cap = getTickCount()
		end
	
		local wanted = getPlayerWantedLevel()

		if wanted > 0 then
			for i=1, wanted do
				dxDrawImage(((screenWidth-240)-posX + (238)) - (i*25), posY+40, 20, 20, "img/star.png",0,0,0, tocolor (255, 255, 255, 255))
			end
		end
		
		dxDrawImage(((screenWidth-240)-posX + (238)) - 256/2, posY+60, 256/2, 128/2, "img/"..getPedWeapon(getLocalPlayer())..".png")
			
		dxDrawText (sp2.."/"..sp1, posX, posY+110, (screenWidth)-9-posX, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, COINSFONT, "right") 
end)

local hudTable = {
	"ammo",
	"armour",
	"clock",
	"health",
	"money",
	"weapon",
	"wanted",
	"area_name",
	"vehicle_name",
	"breath",
	"clock"
}


addEventHandler("onClientResourceStart", resourceRoot,
    function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, false)
		end
    end
)

addEventHandler("onClientResourceStop", resourceRoot,
    function()
		for id, hudComponents in ipairs(hudTable) do
			showPlayerHudComponent(hudComponents, true)
		end
    end
)

function getPedMaxHealth(ped)
    -- Output an error and stop executing the function if the argument is not valid
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")

    -- Grab his player health stat.
    local stat = getPedStat(ped, 24)

    -- Do a linear interpolation to get how many health a ped can have.
    -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
    local maxhealth = 100 + (stat - 569) / 4.31

    -- Return the max health. Make sure it can't be below 1
    return math.max(1, maxhealth)
end