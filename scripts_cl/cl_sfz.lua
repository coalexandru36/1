RegisterFontFile('wmk')


local fontId = RegisterFontId('Freedom Font')
local CreateThread = Citizen.CreateThread
local safeZones = {
    ["Spawn"] = {
        position = vec3(-66.052978515625,-800.00915527344,44.227348327637),
        radius = 50.0,
        isSafezone = true,
        isSlowzone = true,
        isBlip = true,
        blocheaza = false
    },
    ["Showroom"] = {
        position = vec3(-30.075304031372,-1104.519897461,26.42236328125),
        radius = 80.0,
        isSafezone = true,
        isSlowzone = true,
        isBlip = true,
        blocheaza = false
    },
    -- ["Jail"] = {
    --     position = vec3(1793.5895996094,2483.0815429688,-122.69358062744),
    --     radius = 60.0,
    --     isSafezone = true,
    --     isSlowzone = true,
    --     isBlip = true,
    --     blocheaza = false
    -- },
    ["Spital"] = {
        position = vec3(-825.57214355469,-1221.052734375,6.934118270874),
        radius = 80.0,
        isSafezone = true,
        isSlowzone = true,
        isBlip = true,
        blocheaza = false
    },
    -- ["Fleeca Bank"] = {
    --     position = vec3(163.56593322754,-1019.1052856445,29.384721755981),
    --     radius = 60.0,
    --     isSafezone = false,
    --     isSlowzone = true,
    --     isBlip = false,
    --     blocheaza = false
    -- },
    -- ["Vama"] = {
    --     position = vec3(2020.7768554688,2586.0988769531,53.719787597656),
    --     radius = 60.0,
    --     isSafezone = false,
    --     isSlowzone = false,
    --     isBlip = false,
    --     blocheaza = false
    -- },
    ["Politie"] = {
         position = vec3(399.27752685547,-992.94964599609,29.465957641602),
         radius = 80.0,
         isSafezone = false,
         isSlowzone = true,
         isBlip = false,
         blocheaza = false
     },
    ["CNN"] = {
         position = vec3(-605.26379394531,-933.06182861328,23.862213134766),
         radius = 80.0,
         isSafezone = false,
         isSlowzone = true,
         isBlip = false,
         blocheaza = false
     },
    -- ["Casino"] = {
    --     position = vec3(974.30340576172,68.657249450684,75.741279602051),
    --     radius = 60.0,
    --     isSafezone = true,
    --     isSlowzone = false,
    --     isBlip = true,
    --     blocheaza = false
    -- },
    -- ["MasiniSpeciale"] = {
    --     position = vec3(-1636.1927490234,-888.49957275391,8.9839019775391),
    --     radius = 60.0,
    --     isSafezone = true,
    --     isSlowzone = false,
    --     isBlip = true,
    --     blocheaza = true
    -- },
    
}


local safezone = nil
local inSafezone = false
local inSlowzone = false
local theBlips = {}
local blipAlpha = 50


CreateThread(function()
    for k, v in pairs(safeZones) do
        if v.isBlip then
            theBlips[k] = AddBlipForRadius(v.position.x, v.position.y, v.position.z, v.radius + 0.0);
            SetBlipColour(theBlips[k], 2);
            SetBlipAlpha(theBlips[k], blipAlpha)
        end
    end
    CreateThread(function()
        while true do
            if safezone == nil then

                for sz, info in pairs(safeZones) do
                    if #(GetEntityCoords(_GPED) - info.position) <= info.radius then
                        safezone = sz;
                        if info.isSafezone then
                            --TriggerEvent("blockThCarry", true, false)
                            inSafezone = true;
                        else
                            if info.isSlowzone then
                                inSlowzone = true;
                            end
                        end
                        if info.blocheaza then
                            TriggerEvent('blockDV',true)
                            TriggerEvent('blockSHIFTE', true)
                            inSafezone = true
                        end
                    end
                end
            else
                if #(GetEntityCoords(_GPED) - safeZones[safezone].position) > safeZones[safezone].radius then
                    safezone = nil;
                    inSafezone = false;
                    inSlowzone = false;
                   -- TriggerEvent("blockThCarry", false)
                    TriggerEvent('blockDV',false)
                    TriggerEvent('blockSHIFTE', false)
                end
            end
            Wait(235)
        end
    end)
    while true do
        if safezone then
            while inSafezone do
                SendNUIMessage({ act = 'update_hud_safezone', value = true });
                DisableControlAction(0,24,true)
                DisableControlAction(0,25,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,58,true)
                DisableControlAction(0,263,true)
                DisableControlAction(0,264,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,140,true)
                DisableControlAction(0,141,true)
                DisableControlAction(0,142,true)
                DisableControlAction(0,143,true)
                DisableControlAction(0,37,true)
                SetPlayerCanDoDriveBy(PlayerId(),false)
                SetEntityInvincible(_GPED, true)
                SetPlayerInvincible(PlayerId(), true)
                ClearPedBloodDamage(_GPED)
                ResetPedVisibleDamage(_GPED)
                ClearPedLastWeaponDamage(_GPED)
                SetEntityProofs(_GPED, true, true, true, true, true, true, true, true)
                -- if inSlowzone == true then
                --  SetEntityMaxSpeed(GetVehiclePedIsIn(_GPED, false), 13.0)
                -- end
                SetEntityCanBeDamaged(_GPED, false)

                Wait(1)
            end
            SetPlayerCanDoDriveBy(PlayerId(),true)

            while inSlowzone do
                --SendNUIMessage({ action = 'updateAdmin', event = "updateSlowzone" });
                if GetVehiclePedIsIn(_GPED, false) == 0 then
                    Wait(500)
                else
                    SetEntityMaxSpeed(GetVehiclePedIsIn(_GPED, false), 17.0)
                end
                Wait(1)
            end
            
        end
        SendNUIMessage({ act = 'update_hud_safezone', value = false });

        SetEntityInvincible(_GPED, false)
		SetPlayerInvincible(PlayerId(), false)
		ClearPedLastWeaponDamage(_GPED)
		SetEntityProofs(_GPED, false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(_GPED, true)
		SetEntityMaxSpeed(GetVehiclePedIsIn(_GPED, false), 11001.5)

        Wait(235)
    end
end)

RegisterCommand("showSafezones", function(...)
    if blipAlpha == 0 then
        blipAlpha = 130
    else
        blipAlpha = 0
    end
    for k,v in pairs(safeZones) do
        SetBlipAlpha(theBlips[k], blipAlpha)
    end
end)


function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(0.28, 0.28)
	SetTextColour(r, g, b, 255)
    SetTextDropShadow(30, 5, 5, 5, 255)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end