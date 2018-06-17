

local dr1 = createObject ( 980, 1535.9, 2323.2, 12.6, 0, 0, 180 )
local dr2 = createObject ( 980, 1413.2, 2383.5, 12.5, 0, 0, 0 )
local x, y, z = getElementPosition (dr1)
local x2, y2, z = getElementPosition (dr2)
Zona = createColCircle ( x,y, 10, 10 )
Zona2 = createColCircle ( x2,y2, 10, 10 )

function open1 (element)
	if getElementType(element) ~= 'player' then return end
	if getPlayerTeam ( element ) == getTeamFromName ( "[GANG] AAAA" ) then
		moveObject ( dr1, 2000, 1535.9, 2323.2, 5 )
	end
end

function close1 (element)
	if getElementType(element) ~= 'player' then return end
	moveObject ( dr1, 2000, 1535.9, 2323.2, 12.6 )
end

function open2 (element)
	if getElementType(element) ~= 'player' then return end
	if getPlayerTeam ( element ) == getTeamFromName ( "[GANG] AAAA" ) then
		moveObject ( dr2, 2000, 1413.2, 2383.5, 5 )
	end
end

function close2 (element)
	if getElementType(element) ~= 'player' then return end
	moveObject ( dr2, 2000, 1413.2, 2383.5, 12.5 )
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
	triggerClientEvent("onResourceStartPrepareDoor2", resourceRoot, {dr1, dr2})
end--]]

addEventHandler ( "onColShapeHit", Zona, open1 )
addEventHandler ( "onColShapeLeave", Zona, close1 )
addEventHandler ( "onColShapeHit", Zona2, open2 )
addEventHandler ( "onColShapeLeave", Zona2, close2 )
--addEventHandler("onResourceStart", resourceRoot, function() setTimer(startup, 100, 1) end)

