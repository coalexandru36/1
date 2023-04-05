AddEventHandler("vRP:playerLeave", function(user_id, thePlayer)
    local source = thePlayer
    local coords = GetEntityCoords(GetPlayerPed(source))
    x = coords[1]
    y = coords[2]
    z = coords[3]
    TriggerClientEvent("addDeadPlayer",-1,user_id,"ID: [ "..user_id.." ] s-a deconectat: [ Exiting ]",x,y,z)
end)

-- RegisterCommand("testam",function(source)
--     local user_id = vRP.getUserId(source)
--     local coords = GetEntityCoords(GetPlayerPed(source))
--     x = coords[1]
--     y = coords[2]
--     z = coords[3]
--     TriggerClientEvent("addDeadPlayer",-1,user_id,"ID "..user_id.." \n Exiting",x,y,z)
-- end)