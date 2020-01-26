function commitSuicide ( sourcePlayer )
         killurself = outputChatBox("#FFAF00[INFO] You will die in 5 sec", source, 255, 0, 0,true)
	setTimer ( function()
		killPed ( sourcePlayer, sourcePlayer )
	end, 5000, 1 )
end
addCommandHandler ( "kill", commitSuicide )

function para( player, commandName )  
    giveWeapon ( player, 46, 1) 
end  
addCommandHandler ( "parachute", para ) 
addCommandHandler ( "para", para ) 

addEventHandler("onPlayerChangeNick", getRootElement(), 
    function() 
        cancelEvent(); 
    end 
); 

addEventHandler ( "onPlayerLogin", root , 
function ( _ , account )
setPlayerName ( source , getAccountName ( account ) )
end)

local function playerJoin()
	local red, green, blue = math.random (50, 255), math.random (50, 255), math.random (50, 255)
        setPlayerNametagColor(source, red, green, blue)
end
addEventHandler ("onPlayerJoin", root, playerJoin)

--This function is executed when a player says something in chat, it outputs the player's message, with their nick colored to match their name tag color.
local function playerChat(message, messageType)
                cancelEvent()
	            local id = getElementData(source,"id")
                local red, green, blue = getPlayerNametagColor(source)
		outputChatBox(getPlayerName(source).." #FFFFFF["..id.."]: "..message, root, red, green, blue, true )
end
addEventHandler("onPlayerChat", root, playerChat)

function updateTime()
	local offset = tonumber(get("offset"))
	local realtime = getRealTime()
	hour = realtime.hour 
	if hour >= 24 then
		hour = hour - 24
	elseif hour < 0 then
		hour = hour + 24
	end

	minute = realtime.minute

	setTime(hour, minute)

	nextupdate = (60-realtime.second) * 1000
	setMinuteDuration( nextupdate )
	setTimer( setMinuteDuration, nextupdate + 5, 1, 60000 )
end

addEventHandler("onResourceStart", getResourceRootElement(), updateTime )

-- update the time every 30 minutes (correction)
setTimer( updateTime, 1800000, 0 )



local glitches = {"quickreload","fastmove","fastfire","crouchbug","highcloserangedamage","hitanim","fastsprint","baddrivebyhitbox","quickstand"}

function enableGlitches ()
   for _,glitch in ipairs(glitches) do
      setGlitchEnabled (glitch, true )
   end 
end
addEventHandler ( "onResourceStart", getResourceRootElement ( ),enableGlitches)

--[[addCommandHandler ( "myexp", function ( thePlayer )

               local myExp = exports.exp_system:getPlayerEXP ( thePlayer )

outputChatBox ( "Your experience is: ".. myExp, thePlayer ) end ) --]]
