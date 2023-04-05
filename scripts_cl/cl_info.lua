local m = {}
m.delay = 7
m.prefix = '^3Informatie: ^0'

m.messages = {
    'Apasa Tasta I ^1Pentru a Accesa Inventar-ul',
    'Ai nevoie de minim ^110 ore ^0pentru a jefui ^3persoane',
    'Roleplay-ul reprezinta simularea ^1vietii ^0reale in ^3joc',
    'Spam-ul nu este ^1tolerat ^0de echipa ^1staff',
    'Nu uita sa citesti ^3regulamentul ^0pe ^1discord.io/RealismRoRp',
    'Tasteaza ^1/gps ^0in chat pentru a vedea toate ^3locatiile ^0importante',
    'Comunitatea ^3Realism Romania ^0este una de tip ^3Medium Roleplay',
    'Echipa ^1Staff ^0este aici pentru a te ^1ajuta'
}

m.ignorelist = {
    'ip:127.0.1.5',
    'steam:',
    'license:',
}

local playerIdentifiers
local enableMessages = true
local timeout = m.delay * 1500 * 60

local playerOnIgnoreList = false
RegisterNetEvent('va:setPlayerIdentifiers')
AddEventHandler('va:setPlayerIdentifiers', function(identifiers)
    playerIdentifiers = identifiers
end)

Citizen.CreateThread(function()
    while playerIdentifiers == {} or playerIdentifiers == nil do
        Citizen.Wait(1000)
        TriggerServerEvent('va:getPlayerIdentifiers')
    end
    for iid in pairs(m.ignorelist) do
        for pid in pairs(playerIdentifiers) do
            if m.ignorelist[iid] == playerIdentifiers[pid] then
                playerOnIgnoreList = true
                break
            end
        end
    end
    if not playerOnIgnoreList then
        while true do
            for i in pairs(m.messages) do
                if enableMessages then
                    chat(i)
                end
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(0)
        end
    else
        end
end)

function chat(i)
    TriggerEvent('chatMessage', '', {255, 255, 255}, m.prefix .. m.messages[i])
end

RegisterCommand('infotog', function()
    enableMessages = not enableMessages
    if enableMessages then
        status = '^2activate'
    else
        status = '^1dezactivate'
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, '^0Mesajele automate sunt acum ' .. status)
end, false)