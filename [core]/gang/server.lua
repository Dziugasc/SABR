function createTeamEvent( teamN, r, g, b, teamT, teamS )
  local team = createTeam ( "[GANG] "..teamN, r or 255, g or 255, b or 255, teamT, teamS )
  setPlayerTeam ( source, team)
  setPlayerNametagColor ( source, r or 255, g or 255, b or 255 )
  setPedSkin ( source, teamS )
  setPlayerName(source, "["..teamT.."]"..getPlayerName(source))
end
addEvent( "GUI:createTeam", true )
addEventHandler( "GUI:createTeam", root, createTeamEvent ) 


function Invite(id)
	local team = getPlayerTeam ( source )
	local id = getElementData(source,"id")
	local player = (tonumber(id))
    	if team and player then
    		triggerClientEvent( player, "gang.invite", source, team )
    	end
end
addEvent( "onPlayerInvite", true )
addEventHandler( "onPlayerInvite", root, Invite )

 function InviteToGang( wasAccepted, inviter, team )
    	-- If we have a team element
    	if isElement( team ) then
    		-- If the invitation was accepted
    		if wasAccepted then
    			-- Set the player's team
    			setPlayerTeam( team )

    			-- Let the player know
    			outputChatBox( "You accepted the gang invitation.", client, 0, 255, 0 )

    		-- If the invitation was not accepted
    		else
    			-- Let the player know
    			outputChatBox( "You ignored the gang invitation.", client, 255, 0, 0 )
    		end
    	elseif wasAccepted then -- If the invite was accepted but we had no team element, let's say we don't have that team anymore
    		outputChatBox( "This gang does not exist.", client, 255, 0, 0 )
    	end
    end
addEvent( "onPlayerRespondedToInvite", true )
addEventHandler( "onPlayerRespondedToInvite", resourceRoot, InviteToGang )