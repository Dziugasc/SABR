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
    label = {},
    edit = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[2] = guiCreateWindow(0.43, 0.39, 0.15, 0.11, "INVITE", true)
        guiWindowSetSizable(GUIEditor.window[2], false)

        GUIEditor.button[10] = guiCreateButton(10, 59, 81, 18, "Invite", false, GUIEditor.window[2])
        GUIEditor.button[20] = guiCreateButton(112, 59, 80, 18, "Cancel", false, GUIEditor.window[2])
        GUIEditor.edit[10] = guiCreateEdit(94, 26, 98, 23, "11", false, GUIEditor.window[2])
        GUIEditor.label[10] = guiCreateLabel(66, 30, 18, 14, "ID:", false, GUIEditor.window[2])
        guiSetFont(GUIEditor.label[10], "default-bold-small")   
        guiSetVisible(GUIEditor.window[2],false)		
    end
)

addEventHandler ( "onClientGUIClick", GUIEditor.button[20],
  function ( )
    if (source == GUIEditor.button[10]) then
					--local id = guiGetText(GUIEditor.edit[10])
						--if id ~= "" then
							--triggerServerEvent( "onPlayerInvite", localPlayer, id)	
							guiSetVisible (GUIEditor.window[2], not guiGetVisible ( GUIEditor.window[2]	) )
							showCursor(false)
						--end
	elseif (source == GUIEditor.button[20]) then
		guiSetVisible (GUIEditor.window[2], not guiGetVisible ( GUIEditor.window[2]	) )
		showCursor(false)
	end
end
)