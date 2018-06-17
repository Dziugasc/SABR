 
function OpenStatusWindow()
guiSetVisible(GUIEditor.window[1],true)
showCursor(true)
end
 
addCommandHandler("gang",OpenStatusWindow)

function OpenInviteWindow()
	if getPlayerTeam ( localPlayer ) then
		guiSetVisible(GUIEditor.window[2],true)
		showCursor(true)
	end
end
addCommandHandler("invite",OpenInviteWindow)

GUIEditor = {

    button = {},

    window = {},

    edit = {},

    label = {}

}

        GUIEditor.window[1] = guiCreateWindow(0.37, 0.28, 0.28, 0.42, "MINI-GANG Kurimo panele", true)

        guiWindowSetSizable(GUIEditor.window[1], false)

        guiSetAlpha(GUIEditor.window[1], 0.90)

        guiSetProperty(GUIEditor.window[1], "TitlebarEnabled", "True")

        guiSetProperty(GUIEditor.window[1], "CaptionColour", "FFFFFEFE")
		
		guiSetInputMode("no_binds_when_editing")
		
        GUIEditor.label[1] = guiCreateLabel(0.05, 0.12, 0.35, 0.05, "1. Gang Name:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[1], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)

        GUIEditor.edit[1] = guiCreateEdit(0.40, 0.11, 0.52, 0.07, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[1], 25)

        GUIEditor.label[2] = guiCreateLabel(0.05, 0.24, 0.24, 0.06, "2. Gang TAG:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[2], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[2], "left", true)

        GUIEditor.label[3] = guiCreateLabel(0.39, 0.24, 0.04, 0.06, "[", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[3], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", true)

        GUIEditor.label[4] = guiCreateLabel(0.83, 0.24, 0.04, 0.06, "]", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[4], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", true)

        GUIEditor.edit[2] = guiCreateEdit(0.46, 0.22, 0.34, 0.09, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[2], 10)

        GUIEditor.label[5] = guiCreateLabel(0.05, 0.35, 0.28, 0.05, "3. Gang Color:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[5], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[5], "left", true)

        GUIEditor.label[6] = guiCreateLabel(0.36, 0.34, 0.05, 0.07, "R:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[6], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", true)

        guiLabelSetVerticalAlign(GUIEditor.label[6], "center")

        GUIEditor.edit[3] = guiCreateEdit(0.40, 0.34, 0.14, 0.07, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[3], 3)
		
		guiSetProperty(GUIEditor.edit[3], "ValidationString", "[0-9]*")

        GUIEditor.label[7] = guiCreateLabel(0.55, 0.34, 0.05, 0.07, "G:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[7], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", true)

        guiLabelSetVerticalAlign(GUIEditor.label[7], "center")

        GUIEditor.edit[4] = guiCreateEdit(0.59, 0.34, 0.14, 0.07, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[4], 3)
		
		guiSetProperty(GUIEditor.edit[4], "ValidationString", "[0-9]*")

        GUIEditor.label[8] = guiCreateLabel(0.74, 0.34, 0.05, 0.07, "B:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[8], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", true)

        guiLabelSetVerticalAlign(GUIEditor.label[8], "center")

        GUIEditor.edit[5] = guiCreateEdit(0.79, 0.34, 0.14, 0.07, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[5], 3)
		
		guiSetProperty(GUIEditor.edit[5], "ValidationString", "[0-9]*")

        GUIEditor.edit[6] = guiCreateEdit(0.40, 0.46, 0.14, 0.07, "", true, GUIEditor.window[1])

        guiEditSetMaxLength(GUIEditor.edit[6], 3)
		
		guiSetProperty(GUIEditor.edit[6], "ValidationString", "[0-9]*")

        GUIEditor.label[9] = guiCreateLabel(0.05, 0.47, 0.26, 0.05, "4. Gang skin:", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[9], "default-bold-small")

        guiLabelSetHorizontalAlign(GUIEditor.label[9], "left", true)

        GUIEditor.label[10] = guiCreateLabel(0.05, 0.62, 0.51, 0.05, "Gang price 20M = 20 000 000 $", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[10], "default-bold-small")

        GUIEditor.label[11] = guiCreateLabel(0.05, 0.71, 0.92, 0.05, "Gang colors have to be unique", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[11], "default-bold-small")

        GUIEditor.label[12] = guiCreateLabel(0.05, 0.67, 0.61, 0.05, "Rules are equal for everyone", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[12], "default-bold-small")

        GUIEditor.label[13] = guiCreateLabel(0.05, 0.76, 0.61, 0.05, "Looking for RGB? www.colorpicker.com", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[13], "default-bold-small")

        GUIEditor.label[14] = guiCreateLabel(0.05, 0.81, 0.84, 0.05, "Looking for Skins? http://wiki.sa-mp.com/wiki/Skins:All", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[14], "default-bold-small")

        GUIEditor.button[1] = guiCreateButton(0.91, 0.91, 0.06, 0.06, "X", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.button[1], "default-bold-small")

        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")

        GUIEditor.button[2] = guiCreateButton(16, 293, 58, 19, "Create!", false, GUIEditor.window[1])

        guiSetFont(GUIEditor.button[2], "default-bold-small")

        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFAAAAAA")

        GUIEditor.label[15] = guiCreateLabel(88, 275, 106, 43, "Black", false, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[15], "sa-header")

        guiLabelSetColor(GUIEditor.label[15], 0, 0, 0)

        GUIEditor.label[16] = guiCreateLabel(0.56, 0.85, 0.30, 0.13, "Room", true, GUIEditor.window[1])

        guiSetFont(GUIEditor.label[16], "sa-header")

        guiLabelSetColor(GUIEditor.label[16], 254, 254, 254)
		
		guiSetVisible(GUIEditor.window[1],false)
		
		GUIEditor.window[2] = guiCreateWindow(0.43, 0.39, 0.15, 0.11, "INVITE", true)
        guiWindowSetSizable(GUIEditor.window[2], false)
		guiSetVisible(GUIEditor.window[2],false)

        GUIEditor.button[10] = guiCreateButton(10, 59, 81, 18, "Invite", false, GUIEditor.window[2])
        GUIEditor.button[20] = guiCreateButton(112, 59, 80, 18, "Cancel", false, GUIEditor.window[2])
        GUIEditor.edit[10] = guiCreateEdit(94, 26, 98, 23, "11", false, GUIEditor.window[2])
        GUIEditor.label[10] = guiCreateLabel(66, 30, 18, 14, "ID:", false, GUIEditor.window[2])
        guiSetFont(GUIEditor.label[10], "default-bold-small")   

		
addEventHandler ( "onClientGUIClick", resourceRoot,  
  function ( ) 
    if (source == GUIEditor.button[1]) then
    guiSetVisible (GUIEditor.window[1], not guiGetVisible ( GUIEditor.window[1]	) ) 
	showCursor(false)
  end 
  end 
  
)  

addEventHandler( "onClientGUIClick", root,
function( b, s )
	if (source == GUIEditor.button[2]) then
                    local teamN, r, g, b, teamT, teamS = guiGetText( GUIEditor.edit[1] ), guiGetText( GUIEditor.edit[3] ), guiGetText( GUIEditor.edit[4] ), guiGetText( GUIEditor.edit[5] ), guiGetText( GUIEditor.edit[2] ), guiGetText( GUIEditor.edit[6] )
                    if (teamN == "") then return outputChatBox( "#808080[INFO] #FF0000Gang name cannot be empty!", 255, 120, 0, true) end
                    if (getTeamFromName( teamN )) then return outputChatBox( "#808080[INFO] #FF0000A Gang ("..teamN..") with this name already exist!", 255, 120, 0, true) end
					if (teamT == "") then return outputChatBox( "#808080[INFO] #FF0000TAG cannot be empty!", 255, 120, 0, true) end
                    if (r == "") then return outputChatBox( "#808080[INFO] #FF0000R (Red) cannot be empty!", 255, 120, 0, true) end
                    if (g == "") then return outputChatBox( "#808080[INFO] #FF0000G (Green) cannot be empty!", 255, 120, 0, true) end
                    if (b == "") then return outputChatBox( "#808080[INFO] #FF0000B (Blue) cannot be empty!", 255, 120, 0, true) end
					if (teamS == "") then return outputChatBox( "#808080[INFO] #FF0000Skin cannot be empty!", 255, 120, 0, true) end
                    outputChatBox( "#808080[INFO] #00FF00Gang "..teamN.." created!", 255, 120, 0, true)
					triggerServerEvent( "GUI:createTeam", localPlayer, teamN, r, g, b, teamT, teamS)
					guiSetVisible(GUIEditor.window[1],false)
                    showCursor(false)
	elseif (source == GUIEditor.button[10]) then
					local id = guiGetText(GUIEditor.edit[10])
						if id ~= "" then
							triggerServerEvent( "onPlayerInvite", localPlayer, id)	
							guiSetVisible (GUIEditor.window[2], not guiGetVisible ( GUIEditor.window[2]	) )
							showCursor(false)
						end
	elseif (source == GUIEditor.button[20]) then
		guiSetVisible (GUIEditor.window[2], not guiGetVisible ( GUIEditor.window[2]	) )
		showCursor(false)
	end
end) 

local gangs = {
    	window = { },
    	label = { }
}

addEvent( "gang.invite", true )
addEventHandler( "gang.invite", root, function( team )
    		if isElement( gangs.window["invite"] ) or not isElement( team ) then
    			return
    		end
			
    		gangs.inviter = source
    		gangs.team = team

    		gangs.window["invite"] = guiCreateWindow( 540, 636, 285, 91, "GANG INVITE", false )
    		guiWindowSetSizable( gangs.window["invite"], false )
    		guiSetAlpha( gangs.window["invite"], 0.72 )

    		gangs.label["invite"] = guiCreateLabel( 176, 64, 101, 18, "Press 'N' to reject", false, gangs.window["invite"] )
    		guiLabelSetHorizontalAlign( gangs.label["invite"], "center", false )

    		gangs.label["invite1"] = guiCreateLabel( 10, 17, 267, 21, getPlayerName ( gangs.inviter ) .. " has invited you to the gang '" .. getTeamName(gangs.team) .. "'", false, gangs.window["invite"] )
    		guiLabelSetHorizontalAlign( gangs.label["invite1"], "center", false )

    		gangs.label["invite2"] = guiCreateLabel( 10, 64, 113, 18, "Press 'J' to accept", false, gangs.window["invite"] )
    		guiLabelSetHorizontalAlign( gangs.label["invite2"], "center", false )
			
			addEventHandler("onClientKey", root, respondInvite)
end)

function cleanUp()
	if isElement( gangs.window["invite"] ) then
    	destroyElement(gangs.window["invite"])
    end
	gangs.inviter = nil
    gangs.team = nil
	removeEventHandler("onClientKey", root, respondInvite)
end

function respondInvite( key )
    if key == "j" then
    	triggerServerEvent( "onPlayerRespondedToInvite", localPlayer, true, gangs.inviter, gangs.team )
		cleanUp()
    elseif key == "n" then
    	triggerServerEvent( "onPlayerRespondedToInvite", localPlayer, false, gangs.inviter, gangs.team )
		cleanUp()
	end
end

	
	
	
	
	
	
	
	