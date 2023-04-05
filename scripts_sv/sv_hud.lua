

AddEventHandler('vRP:playerSpawn', function(user_id, source, fs)
    local faction = vRP["getUserFaction"](user_id)
    if faction == "user" then
        faction = "Cetatean"
    end
    local job = vRP["getUserGroupByType"](user_id,"job")
    if job == "" then
        job = "Somer"
    end
    if not fs then return end;
    TriggerClientEvent('hud:updateThings', source, "myId", vRP["getUserId"](source))
    TriggerClientEvent('hud:updateThings', source, "playerName", GetPlayerName(source))
    TriggerClientEvent('hud:updateThings', source, "playerAtribute", faction)
    TriggerClientEvent('hud:updateThings', source, "theJob", job)
end)