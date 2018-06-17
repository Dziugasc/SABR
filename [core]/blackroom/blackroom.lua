local spawnpoint
addEventHandler("onPlayerLogin", root,
	function()
	    spawnpoint = getRandomSpawnPoint()
		spawn(source)
	end
)



addEventHandler("onPlayerWasted", root,
	    function()
	    spawnpoint = getRandomSpawnPoint()
		setTimer(spawn, 1800, 1, source)
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function()
		spawnpoint = getRandomSpawnPoint()
		resetMapInfo()
		for i,player in ipairs(getElementsByType("player")) do
			spawn(player)
		end
	end
)

function spawn(player)
	if not isElement(player) then return end
	if get("spawnreset") == onSpawn then
		spawnpoint = getRandomSpawnPoint()
	end
	exports.spawnmanager:spawnPlayerAtSpawnpoint(player,spawnpoint,false)
	repeat until setElementModel(player,math.random(312))
	fadeCamera(player, true)
	setCameraTarget(player, player)
	showChat(player, true)
end

function getRandomSpawnPoint ()
	local spawnpoints = getElementsByType("spawnpoint")
	return spawnpoints[math.random(1,#spawnpoints)]
end



addEventHandler("onPlayerQuit",root,
	function ()
		if getPlayerCount() == 1 and get("spawnreset") == onServerEmpty then
			spawnpoint = getRandomSpawnPoint()
		end
	end
)

function giveWeaponsOnSpawn ( theSpawnpont, theTeam )
    giveWeapon ( source, 24, 200 ) -- Gives the M4 weapon with 200 ammo
end
addEventHandler ( "onPlayerSpawn", getRootElement(), giveWeaponsOnSpawn )

function giveWeaponsOnSpawn ( theSpawnpont, theTeam )
    giveWeapon ( source, 24, 200 ) -- Gives the M4 weapon with 200 ammo
end
addEventHandler ( "onPlayerWasted", getRootElement(), giveWeaponsOnSpawn )

--[[

setElementData(getTeamFromName ( "[GANG] Stop The Violence" ), "spawnX", 2580.7)
setElementData(getTeamFromName ( "[GANG] Stop The Violence" ), "spawnY", 1419)
setElementData(getTeamFromName ( "[GANG] Stop The Violence" ), "spawnZ", 10.82031)
setElementData(getTeamFromName ( "[GANG] Stop The Violence" ), "skinas", 73 )



function spawn ()
    if getElementType(source) ~= 'player' then return end
    
    if getPlayerTeam(source) then
        spawnpoint = getRandomSpawnPoint()
        spawn(source)
        local team = getPlayerTeam(source)
        local x, y, z, skin = getElementData(team, "spawnX"), getElementData(team, "spawnY"), getElementData(team, "spawnZ"), getElementData(team, "skinas")
            spawnPlayer (source, x, y, z, 0, skin, 0, 0) 
            giveWeapon (source, 24, 126)
            setWeaponAmmo (source, 24, 126)
            fadeCamera (source, true)
            setCameraTarget (source, source)
    else
        local spawnpoints = getElementsByType ( "spawnpoint" )
        call(getResourceFromName("spawnmanager"), "spawnPlayerAtSpawnpoint", source, spawnpoints[math.random(1, #spawnpoints)] )
    end
end
addEventHandler("onPlayerWasted", getRootElement(), spawn, true, "high+4")

        
--]]
 