local dr2 = createObject ( 980, 2557.2, 1393, 12.6, 0, 0, 270 )
local x, y, z = getElementPosition (dr2)
Zona = createColCircle ( x,y, 10, 10 )

function open (element)
	if getElementType(element) ~= 'player' then return end
	if getPlayerTeam ( element ) == getTeamFromName ( "[GANG] Stop The Violence" ) then
		moveObject ( dr2, 2000, 2557.2, 1393, 5 )
	end
end

function close (element)
	if getElementType(element) ~= 'player' then return end
	moveObject ( dr2, 2000, 2557.2, 1393, 12.6 )
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

function whatTeamAmIOn (source)
    -- Get the player's team (source is the player who entered the command)
    local playerTeam = getPlayerTeam(source)
  
    if (playerTeam) then -- if he was on a team
        outputChatBox(getPlayerName(source).." is on team: "..getTeamName(playerTeam))
    else
        outputChatBox(getPlayerName(source).. " isn't on a team")
    end
end

-- Add console command to find your team when 'whatTeamAmIOn' is typed.
addCommandHandler("whatTeamAmIOn", whatTeamAmIOn)

