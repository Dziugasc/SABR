-- Hide default nametag when new player joins
function disable_nametag()
    setPlayerNametagShowing(source, false)
end
addEventHandler("onPlayerJoin", root, disable_nametag)

-- Hide default nametags for all players on resource start
for k,v in pairs(getElementsByType("player")) do
    setPlayerNametagShowing(v, false)
end
