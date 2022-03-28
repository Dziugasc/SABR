local doherty = setGarageOpen(22, true)
local michelle = setGarageOpen(24, true)



local weaponTable = {
-- populate this list by adding weapons:
-- [weap_id] = { torso, ass, left_arm, right_arm, left_leg, right_leg, head }
 [23] = { 40, 35, 30, 30, 25, 25, 55 },
 [24] = { 40, 35, 30, 30, 25, 25, 55 },
}


addEventHandler("onPlayerDamage", getRootElement(),
	function (attacker, weapon, bodypart, loss)
		if getElementType(attacker) == "player" and getPedWeapon(attacker) and weaponTable[ getPedWeapon(attacker) ] then
			setElementHealth(source, getElementHealth(source) - weaponTable[ getPedWeapon(attacker) ] [ bodypart - 2] + loss)
			--local lastHP = getElementHealth(source)
			outputChatBox("tu padarei "..100-getElementHealth(source).." zalos pataikei i "..getBodyPartName(bodypart).." !", attacker)
			outputChatBox("tu gavai "..100-getElementHealth(source).." zalos pataike i "..getBodyPartName(bodypart).." !", source)
		end
	end
)

local teams = {
    --{"team" 1,r2,g3,b4, x5,y6,z7,skinid8, weapon1(Sniper)/(M4)9, weapon2 Pistol Slot10, weapon3 Melee/Thg11}
    {"Furistai", 255, 120, 0, -2057.91650, -236.21437, 35.32031,206,22,25,5},
    {"Policija", 0, 60, 160, -1636.95337, 691.31042, 7.16481,280,22,25,3},
	{"Samdomas Zudikas", 255, 55, 55, -2660, 878, 81,165,34,23,4},
	{"Armija", 75, 83, 32, -1321, 477, 8,179,31,28,24},
	{"Forsas", 10, 200, 100, -1880.95337, -200, 18,28,27,22,3},
	{"Teroristas", 255, 0, 0, -2740, 116, 5.7,162,22,30,39},
	{"Mechanikai", 128, 128, 128,-1791, 1202, 25.16481,192,24,32,25},
	{"A.R.A.S", 15, 0, 110,-2446.01343, 522.43359, 30.15485,285,31,28,24},
    {"Mafia", 128, 0, 0, -2306.69556, 277.60596, 35.36875,126,30,28,24}
}



local guestSpawns = {
    --{x,y,z,rotation,skinid}
{2207.3999, 1285.9, 10.8,0,0,24},
{2030, 1914.3, 12.3,0,0,24},
{2024.9004, 1104.7998, 10.8,0,0,24},
{1954.5, 1343.0996, 15.4,0,0,24},
{2026.7002, 1545.5, 10.8,0,0,24},
{2550.2, 1962.4, 10.8,0,0,24},
{2166.7002, 2012.2998, 10.8,0,0,24},
{2369.6006, 2044.4004, 10.8,0,0,24},
{2532.7, 1507.7, 11.8,0,0,24},
{2481.3999, 1525.4, 11.8,0,0,24},
{2451.1001, 1301.9, 10.8,0,0,24},
{2180.5, 1118.2, 12.6,0,0,24},
{2507.5, 1243.9, 10.8,0,0,24},
{2419.6001, 1123.4, 10.8,0,0,24},
{1937.1, 1081.7, 10.8,0,0,24},
{2032.4004, 995.7998, 10.8,0,0,24},
{1098.3, 1615.7, 12.5,0,0,24},
{1674.2998, 1447.7998, 10.8,0,0,24},
{1607.4004, 1816.5996, 10.8,0,0,24},
{1166.8, 1364.4, 10.8,0,0,24},
{1355.2, 2581.3999, 10.8,0,0,24},
{1161.5, 2100.2998, 11.1,0,0,24},
{1457.6, 2665.8, 10.8,0,0,24},
{1670.4, 2596.7, 10.8,0,0,24},
{1417.0996, 2611.1006, 10.8,0,0,24},
{2067.7, 2734.7, 10.8,0,0,24},
{2094.5, 2653.7002, 10.8,0,0,24},
{2288.2, 2425.8, 10.8,0,0,24},
{2360.3, 2380.6001, 10.8,0,0,24},
{2336.7002, 2455, 15,0,0,24},
{2368.3, 2124.5, 10.8,0,0,24},
{2317, 2289.7998, 10.8,0,0,24},
{2327.5, 2118.7998, 10.8,0,0,24},
{2624, 2342.6001, 10.8,0,0,24},
{2505.9004, 2125.4004, 10.8,0,0,24},
{2577.2002, 2225.1006, 10.8,0,0,24},
{2570.2, 2367.8, 17.8,0,0,24},
{2783.1001, 2446.3, 11.1,0,0,24},
{2899.1001, 2303.3999, 10.8,0,0,24},
{2809.2, 1979.3, 10.8,0,0,24},
{2786, 1455, 10.8,0,0,24},
{2849.2, 1289.9, 11.4,0,0,24},
{2746.8, 905.40002, 10.9,0,0,24},
{2597.7, 759.90002, 11,0,0,24},
{2367.1001, 705.90002, 10.8,0,0,24},
{1560.2, 773.40002, 10.8,0,0,24},
{2237.2002, 706.09961, 10.8,0,0,24},
{1500, 923, 10.8,0,0,24},
{1324.6, 1186.9, 10.8,0,0,24},
{1514.7002, 1102.5, 10.8,0,0,24},
{1323.1, 1186.9, 10.8,0,0,24},
{1049.7, 1013.8, 11,0,0,24},
{1020.9, 1059.8, 11,0,0,24},
{1088.7002, 1003, 11,0,0,24},
{944.40002, 1733, 8.9,0,0,24},
{999.79999, 1872.9, 10.8,0,0,24},
{1000.4, 1933, 10.8,0,0,24},
{1089.2, 2285.6001, 10.8,0,0,24},
{1000.0996, 2082.9004, 10.8,0,0,24},
{1000.5, 2272.9004, 10.8,0,0,24},
{1240.2, 2600, 10.8,0,0,24},
{1460.7, 2763.3999, 10.8,0,0,24},
{1496.5, 2773.5, 10.8,0,0,24},
{1749.3, 2797.8999, 10.8,0,0,24},
{1794.6, 2839.2, 10.8,0,0,24},
{1772.8, 2757.8999, 10.8,0,0,24},
{2125.2, 2460.7, 10.8,0,0,24},
{1811.4004, 2721.1006, 10.8,0,0,24},
{2208.3, 2363.2, 10.8,0,0,24},
{2128, 2361, 10.8,0,0,24},
{1920.1, 2153.7, 10.8,0,0,24},
{1919.5, 2052.7, 10.8,0,0,24},
{1847.7, 2045.8, 10.9,0,0,24},
{1719, 2162, 10.8,0,0,24},
{1785.5996, 2117.9004, 11,0,0,24},
{1587.7, 2181, 10.8,0,0,24},
{1657.7002, 2180.9004, 10.8,0,0,24},
{1610.8, 2063.3999, 10.7,0,0,24},
{1394.8, 2023.2, 10.8,0,0,24},
{1980.6, 1622.9, 12.2,0,0,24}
}



function getRandomSpawnpoint()
    randomNum = math.random(#guestSpawns)
    return randomNum
end

addEventHandler("onPlayerLogin", root,
  function()
    fadeCamera(source, true)
  end
)

function spawnOnWasted()
--cancelEvent()
--fadeCamera(source, true)
local num = getRandomSpawnpoint()
local ammo = 100
	local playerTeam = getPlayerTeam(source) -- source is the player who died onPlayerWasted
    local teamName = getTeamName(playerTeam) -- we get the team name
    local thePlayer = source
            if getElementDimension ( thePlayer ) == 69 then 
        spawnPlayer(thePlayer ,363.62066650391, 2548.7014160156, 16.5390625,0,192,0,0,playerTeam) 
        setElementDimension(thePlayer,69)
		return
        end
for _, v in pairs(teams) do
	if teamName == v[1] then
	
		setTimer(function() 
			spawnPlayer(thePlayer ,v[5],v[6],v[7],0,v[8],0,0,playerTeam)
			giveWeapon(thePlayer , v[9],ammo,false)
			giveWeapon(thePlayer , v[10],ammo,false)
			giveWeapon(thePlayer , v[11],ammo,false)
		end,5000,1)
		
		return -- this stops the whole function...
	end
end

setTimer(function()
	spawnPlayer(thePlayer,guestSpawns[num][1],guestSpawns[num][2],guestSpawns[num][3],guestSpawns[num][4],guestSpawns[num][5],0,0,playerTeam)
    giveWeapon(thePlayer , guestSpawns[num][6],ammo,false)
end,5000,1)
end
addEventHandler("onPlayerLogin", root,spawnOnWasted)
addEventHandler("onPlayerWasted", root,spawnOnWasted)

function isPlayerInTeam(player, team)
    assert(isElement(player) and getElementType(player) == "player", "Bad argument 1 @ isPlayerInTeam [player expected, got " .. tostring(player) .. "]")
    assert((not team) or type(team) == "string" or (isElement(team) and getElementType(team) == "team"), "Bad argument 2 @ isPlayerInTeam [nil/string/team expected, got " .. tostring(team) .. "]")
    return getPlayerTeam(player) == (type(team) == "string" and getTeamFromName(team) or (type(team) == "userdata" and team or (getPlayerTeam(player) or true)))
end

local mechanic = createPickup ( -1798.49121, 1199.62427, 25.11940, 3, 1275, 0 )
local team = createTeam ( "Mechanikai" , 128, 128, 128 )

function pickedUpWeaponCheck( source )
    local playerTeam =  getTeamFromName ( "Mechanikai" )
    if isPlayerInTeam(source , playerTeam) then 
    --outputChatBox( "[INFO] #ffffffTu, jau dirbi mechaniku :/", player, 0,0,0, true ) -- Output a message to the chatbox
	exports["notices"]:addNotification(source, "Tu, jau dirbi mechaniku.",'error')
	else
	--setPlayerTeam ( source, playerTeam )
	    exports["notices"]:addNotification(source, "Įsidarbinai Mechaniku!",'success')
				setTimer(function() 
		exports["notices"]:addNotification(source, "Nuo šiol gali taisyti mašinas NEMOKAMAI!",'info')
				end,3000,1)
			spawnPlayer(source ,-1791, 1202, 25.16481,180,192,0,0,playerTeam)
			giveWeapon(source , 24,192,false)
			giveWeapon(source , 32,500,false)
			giveWeapon(source , 25,1,false)
	--outputChatBox( "[INFO] #ffffff", player, 0,0,0, true ) -- Output a message to the chatbox
	--outputChatBox( "[INFO] #ffffffNuo šiol gali taisyti mašinas NEMOKAMAI!", player, 0,0,0, true ) -- Output a message to the chatbox
 end
end
addEventHandler( "onPickupHit", mechanic, pickedUpWeaponCheck )


--      TEAMS     --
-- made by Dziugas--



--Team save
function onPlayQuit ( )
      local playeraccount = getPlayerAccount ( source )
      if ( playeraccount ) and not isGuestAccount ( playeraccount ) then -- if the player is logged in
	      local myTeam = getPlayerTeam ( source )
			if (myTeam) then
			
            local currentTeam = getTeamName ( myTeam ) 
            setAccountData ( playeraccount, "TeamLog", currentTeam ) -- save it in his account
      end
end
end
addEventHandler ( "onPlayerQuit", getRootElement ( ), onPlayQuit )


--Team load
function onPlayLogin (_, playeraccount )
      if ( playeraccount ) then
            local LoadTeam = getAccountData ( playeraccount, "TeamLog" )

            if ( LoadTeam ) then
			      teamLoad = getTeamFromName ( LoadTeam ) 
                  setPlayerTeam ( source, teamLoad )
            end
      end
end
addEventHandler ( "onPlayerLogin", getRootElement ( ), onPlayLogin )
