ConfigNPC = {}
ConfigNPC.NPCList = {
	-- NPC ProTv - Anunturi
	[1] = {
		-- Ped data
		coordonate = vector3(-598.36804199219,-929.87854003906,22.869131088257),
		holo = {-598.36804199219,-929.87854003906,23.869131088257},
		npc = 'a_f_y_vinewood_04',
		text = 'Andreea Esca',

		-- Data meniu
		meniu = 'protv',
		rolNPC = 'Anunturi CNN',
		descriereMeniu = '🖐🏼 Bine ai venit in studioul nostru, cu ce te putem ajuta?',

		-- Camera jucator (nu modifica -> decat heading daca vrei sa intorci NPC-ul)
		heading = 70.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
	},
}
-- RegisterCommand('gcc',function()
--     SetEntityCoords(PlayerPedId(),-598.36804199219,-929.87854003906,22.869131088257);
-- end)
local openCache = {}

CreateThread(function ()
    for i = 1, #ConfigNPC.NPCList do
        openCache[i] = false
        RequestModel(GetHashKey(ConfigNPC.NPCList[i].npc))
        while not HasModelLoaded(GetHashKey(ConfigNPC.NPCList[i].npc)) do
            Wait(1)
        end

        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
            Wait(1)
        end

        local ped = CreatePed(4, ConfigNPC.NPCList[i].npc, ConfigNPC.NPCList[i].coordonate[1], ConfigNPC.NPCList[i].coordonate[2], ConfigNPC.NPCList[i].coordonate[3], ConfigNPC.NPCList[i].heading, false, true)
        SetEntityHeading(ped, ConfigNPC.NPCList[i].heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

CreateThread(function ()
    while true do
        local ped = PlayerPedId();
        local pos = GetEntityCoords(ped);
        for i=1, #ConfigNPC.NPCList do
            while #(ConfigNPC.NPCList[i].coordonate - pos) <= 3.5 and not openCache[i] do
                DrawText3D(ConfigNPC.NPCList[i].holo, '~w~[~b~E~w~] Vorbeste cu ~b~'..ConfigNPC.NPCList[i].text)
                if IsDisabledControlJustPressed(0, 51) then
                    openCache[i] = true
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        action = "createSelector",
                        meniu = tostring(ConfigNPC.NPCList[i].meniu),
                        index = i,
                        descriere = tostring(ConfigNPC.NPCList[i].descriereMeniu),
                        rolNPC = tostring(ConfigNPC.NPCList[i].rolNPC),
                        numeNPC = tostring(ConfigNPC.NPCList[i].text),
                    })
                end
                ped = PlayerPedId();
                pos = GetEntityCoords(ped);
                Wait(5)
            end
        end
        Wait(1500)
    end
end)

RegisterNUICallback('__anunt:darkweb__',function()
    TriggerServerEvent('CNN:anuntPost', 'darkweb')
end)

RegisterNUICallback('__anunt:comercial__', function()
    TriggerServerEvent('CNN:anuntPost', 'comercial')
end)

RegisterNUICallback('__anunt:eveniment__', function()
    TriggerServerEvent('CNN:anuntPost', 'eveniment')
end)

RegisterNUICallback("inchideMeniul", function(data)
    openCache[data] = false
    SetNuiFocus(false, false)
end)

function DrawText3D(coordsTable, text)
    local x,y,z = table.unpack(coordsTable)
    local scale = 0.4
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 300
        DrawRect(_x, _y + 0.0135, 0.0 + factor, 0.030, 0, 0, 0, 65)
    end
end