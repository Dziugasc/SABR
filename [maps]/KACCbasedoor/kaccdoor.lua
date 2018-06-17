

local dr1 = createObject ( 985, 2497.3999023438, 2777, 11.5, 0, 0, 90 )
local dr2 = createObject ( 986, 2497.3999023438, 2769.1000976563, 11.5, 0, 0, 90 )
local x, y, z = getElementPosition (dr2)
Zona = createColCircle ( x,y, 10, 10 )

function open (element)
	if getElementType(element) ~= 'player' then return end
	if getPlayerTeam ( element ) == getTeamFromName ( "K.A.C.C" ) then
		moveObject ( dr1, 2000, 2497.3999023438, 2782.1999511719, 11.5 )
		moveObject ( dr2, 2000, 2497.3999023438, 2764.1999511719, 11.5 )
	end
end

--[[setElementData(getTeamFromName ( "K.A.C.C" ), "spawnX", 2568.50854)
setElementData(getTeamFromName ( "K.A.C.C" ), "spawnY", 2784.44873)
setElementData(getTeamFromName ( "K.A.C.C" ), "spawnZ", 10.82031)

function spawn ()
    
    if getPlayerTeam(source) ~= false then

        local team = getPlayerTeam(source)
        local x, y, z = getElementData(team, "spawnX"), getElementData(team, "spawnY"), getElementData(team, "spawnZ")
            spawnPlayer (source, x, y, z, 0, 141, 0, 0) 
            fadeCamera (source, true)
            setCameraTarget (source, source)
    else
        return false
    end
end
addEventHandler("onPlayerWasted", getRootElement(), spawn , true, "high+4")
--]]
function close (element)
	if getElementType(element) ~= 'player' then return end
	moveObject ( dr1, 2000, 2497.3999023438, 2777, 11.5 )
	moveObject ( dr2, 2000, 2497.3999023438, 2769.1000976563, 11.5 )
end



if dr1 then
    setElementDoubleSided (dr1, true)
	setElementCollisionsEnabled (dr1, true)
end

if dr2 then
    setElementDoubleSided (dr2, true)
	setElementCollisionsEnabled (dr2, true)
end

--[[local function startup ()
	triggerClientEvent("onResourceStartPrepareDoor", resourceRoot, {dr1, dr2})
end--]]

addEventHandler ( "onColShapeHit", Zona, open )
addEventHandler ( "onColShapeLeave", Zona, close )
--addEventHandler("onResourceStart", resourceRoot, function() setTimer(startup, 100, 1) end)

