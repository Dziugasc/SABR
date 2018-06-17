local dr2 = createObject ( 980, 1067.2, 1357.8, 11.5, 0, 0, 0 )
local x, y, z = getElementPosition (dr2)
Zona = createColCircle ( x,y, 10, 10 )

function open (element)
	if getElementType(element) ~= 'player' then return end
	if getPlayerTeam ( element ) == getTeamFromName ( "K.A.C.C" ) then
		moveObject ( dr2, 2000, 1067.2, 1357.8, 5 )
	end
end

function close (element)
	if getElementType(element) ~= 'player' then return end
	moveObject ( dr2, 2000, 1067.2, 1357.8, 12.5 )
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

