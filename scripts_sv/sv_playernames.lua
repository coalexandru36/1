local players = {}

function vRP.getPlayerList()
    players = {}
    for i,v in pairs(vRP.getUsers()) do
        players[i] = GetPlayerName(i)
    end
    return players
end

AddEventHandler("vRP:playerJoin", function(user_id, source, name)
    players[user_id] = name
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
    players[user_id] = nil
end)

RegisterCommand("players", function(source)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local list = vRP.getPlayerList()
        local message = "Players online: "
        for k,v in pairs(list) do
            message = message..v..", "
        end
        vRPclient.notify(source, {"[Player List]", message})
    end
end)