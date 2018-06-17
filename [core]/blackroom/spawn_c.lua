function protect() 
    if getElementAlpha(localPlayer) == 255 then 
    setElementAlpha(localPlayer, 128) 
    setElementData(localPlayer, "inv", true) 
    setTimer(setElementData, 15000, 1, localPlayer, "inv", false)  
     setTimer(setElementAlpha, 15000, 1, localPlayer, 255) 
end 
end 
addEventHandler("onClientPlayerSpawn", getRootElement(), protect) 

function onPSKill(target)
	if getElementData (target, "inv") then
		cancelEvent()
	end
end
addEventHandler ("onClientPlayerStealthKill", localPlayer, onPSKill)
  
  
  
function CancelEvent () 
    if getElementData(localPlayer, "inv") == true then 
    cancelEvent() 
    end 
end 
addEventHandler("onClientPlayerDamage", getRootElement(), CancelEvent) 

function renderGreenzoneTag()
	local streamedPlayers = getElementsByType ("player", root, true)
	if streamedPlayers and #streamedPlayers ~= 0 then
		local lpos = {getElementPosition(localPlayer)}
		for _,p in ipairs (streamedPlayers) do
			if p and isElement (p) then
				if getElementData (p, "inv") then
					local ppos = {getElementPosition(p)}
					if getDistanceBetweenPoints3D (lpos[1], lpos[2], lpos[3], ppos[1], ppos[2], ppos[3]) <= 20 then
						local x, y = getScreenFromWorldPosition (ppos[1], ppos[2], ppos[3]+1.2)
						if x and y then
							dxDrawText ("Spawn Protection", x+1, y+1, x, y, tocolor (0, 0, 0), 0.5, "bankgothic", "center")
							dxDrawText ("Spawn Protection", x, y, x, y, tocolor (255, 255, 255), 0.5, "bankgothic", "center")
						end
					end
				end
			end
		end
	end
end
addEventHandler ("onClientRender", root, renderGreenzoneTag)