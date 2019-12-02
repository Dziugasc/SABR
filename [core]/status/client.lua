function CheckStatus()
local moveState = getPedMoveState( localPlayer )
    dxDrawText ( "Status: ".. moveState.."", 5, 560)
		if getPedMoveState == nil then
	cancelEvent()
	end
 if isPedOnFire ( localPlayer ) then
    dxDrawText ( "Action: On Fire", 5, 580) 
 elseif isPedDead ( localPlayer ) then
    dxDrawText ( "Action: Dead", 5, 580) 
 elseif isPedWearingJetpack ( localPlayer ) then
    dxDrawText ( "Action: Wearing Jetpack", 5, 580) 
 elseif isPedReloadingWeapon ( localPlayer ) then
    dxDrawText ( "Action: Reloading", 5, 580) 
end
end
addEventHandler ( "onClientRender", root, CheckStatus )

