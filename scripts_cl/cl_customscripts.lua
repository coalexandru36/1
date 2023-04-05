

-------------------------------------------------------------------

-- HOSPITAL

-------------------------------------------------------------------

Keys = {["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, }

local IsCheckingUp = false
local injuredrecovertimer = 180000
local beingtreated = false
local beingtreatedrespawn = false
local beingtreatedhospital = false
local IsInABed = false
local treatedpercentage = 0

local inBedDict = "misslamar1dead_body"
local inBedAnim = "dead_idle"

local getOutDict = "switch@franklin@bed"
local getOutAnim = "sleep_getup_rubeyes"

local isInHospitalBed = false
local canLeaveBed = true

local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local closestBed = nil

local pos = vector3(0, 0, 0)

local HospitalCheckinStation = {
        ---------------------------------------------------> Los Santos <---------------------------------------------------
        {-816.97052001954, -1237.2557373046, 7.3373575210572, -790.48962402344, -1220.8354492188, 8.311695098877, true},
        -----------------------------------------------------> Sandy <------------------------------------------------------
        {1827.7368164062, 3685.8239746094, 34.271026611328, 1821.9697265625, 3680.2578125, 34.981372833252},
        ----------------------------------------------------> Paleto <------------------------------------------------------
        {-263.59649658204, 6314.18359375, 32.436401367188, -257.91693115234, 6317.86328125, 33.358364105224},
        {-262.1251525879, 6312.7626953125, 32.436367034912, -259.97091674804, 6320.2705078125, 33.358364105224},
        --------------------------------------------------> Dark Spital <---------------------------------------------------
        {806.71704101562, -493.35165405274, 30.688272476196, 807.71575927734, -495.5769958496, 31.523160934448},
        --------------------------------------------------> Puscarie <---------------------------------------------------
        {1777.6655273438, 2555.1196289062, 45.797832489014, 1779.8344726562, 2556.7023925781, 46.770965576172},
        --------------------------------------------------> Cayo Perico <---------------------------------------------------
        {5077.3828125, -4566.0522460938, 5.990080356598, 5077.3740234375, -4570.3110351562, 6.9075231552124},
        {5530.1494140625, -5223.9038085938, 13.765712738038, 5533.5180664062, -5221.1884765625, 14.6831598281868},
        {4877.6391601562, -5268.0249023438, 9.1636667251586, 4875.2856445312, -5264.6147460938, 10.083464622498},
}

local bedsLocations = {
    [1] = {x = -797.14, y = -1231.29, z = 7.25, h = 142.96, taken = false, model = 1631638868},
    [2] = {x = -800.99, y = -1227.95, z = 7.25, h = 142.96, taken = false, model = 1631638868},
    [3] = {x = -805.52, y = -1224.05, z = 7.25, h = 142.96, taken = false, model = 1631638868},
    [4] = {x = -809.12, y = -1221.04, z = 7.25, h = 142.96, taken = false, model = 1631638868},
    [5] = {x = -812.11, y = -1224.56, z = 7.25, h = 317.26, taken = false, model = 1631638868},
    [6] = {x = -809.66, y = -1226.70, z = 7.25, h = 317.26, taken = false, model = 1631638868},
    [7] = {x = -806.74, y = -1228.98, z = 7.25, h = 317.26, taken = false, model = 1631638868},
    [8] = {x = -804.08, y = -1231.26, z = 7.25, h = 317.26, taken = false, model = 1631638868},
    [9] = {x = -800.06, y = -1234.67, z = 7.25, h = 317.26, taken = false, model = 1631638868},
}


-- RegisterCommand("grip", function(source, args, rawCommand)
--     RequestAnimDict("combat@aim_variations@1h@gang")
--     while not HasAnimDictLoaded("combat@aim_variations@1h@gang") do
--         Citizen.Wait(100)
--     end
--     if IsEntityPlayingAnim(PlayerPedId(), "combat@aim_variations@1h@gang", "aim_variation_a", 3) then
--         ClearPedSecondaryTask(PlayerPedId())
--     else
--         TaskPlayAnim(PlayerPedId(), "combat@aim_variations@1h@gang", "aim_variation_a", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
--     end
-- end)

CreateThread(function()
    while true do
        Citizen.Wait(1)
        local inRange = false
        for i = 1, #HospitalCheckinStation do
            HospitalCoords2 = HospitalCheckinStation[i]
            DrawMarker(-27, HospitalCoords2[1], HospitalCoords2[2], HospitalCoords2[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if #(vector3(pos.x, pos.y, pos.z) - vector3(HospitalCoords2[1], HospitalCoords2[2], HospitalCoords2[3])) < 1.2 then
                inRange = true
                Draw3DText2(HospitalCoords2[1], HospitalCoords2[2], HospitalCoords2[3] + 0.2, tostring("~w~~g~[E]~w~ Internare"))
                if IsControlJustPressed(1, Keys['E']) then
                    if not IsEntityPlayingAnim(PlayerPedId(), "nm", "firemans_carry", 3) then
                        RequestAnimDict("anim@mp_atm@enter")
                        TaskPlayAnim(PlayerPedId(), "anim@mp_atm@enter", "enter", 3.0, -1, -1, 50, 0, false, false, false)
                        HCheckIn = true
                        Citizen.Wait(1)
                        
                        exports.rprogress:Custom({
                            Duration = 2000,
                            Label = "Verificam documentele tale!",
                            Animation = {},
                            DisableControls = {
                                Mouse = false,
                                Player = true,
                                Vehicle = true,
                            },
                        })
                        
                        Citizen.Wait(2000)
                        
                        ClearPedSecondaryTask(PlayerPedId())
                        HCheckIn = false
                        
                        if HospitalCheckinStation[i][7] then
                            local bedId = GetAvailableBed()
                            if bedId ~= nil then
								TriggerServerEvent("vrp_hospital:SendToBed", bedId, true)
								TriggerServerEvent("vrp_hospital:hospitalCheckInPay")
                                beingtreatedhospital = true
                            else
                                TriggerEvent("fplaytbank:notifications", "error", "Nu mai sunt paturi pentru internare.")
                            end
                        else
                            HospitalCheck(HospitalCheckinStation[i][4], HospitalCheckinStation[i][5], HospitalCheckinStation[i][6])
							TriggerServerEvent("vrp_hospital:hospitalCheckInPay")
                        end
                    else
                        TriggerEvent("fplaytbank:notifications", "error", "Nu poti face aceasta actiune!")
                    end
                end
            end
        end
        
        if closestBed ~= nil and not isInHospitalBed then
            if #(vector3(pos.x, pos.y, pos.z) - vector3(bedsLocations[closestBed].x, bedsLocations[closestBed].y, bedsLocations[closestBed].z)) < 1.5 then
                inRange = true
                Draw3DText2(bedsLocations[closestBed].x, bedsLocations[closestBed].y, bedsLocations[closestBed].z + 0.3, "~g~E~w~ - Aseaza-te pe pat")
                
                if IsControlJustReleased(0, Keys["E"]) then
                    if GetAvailableBed(closestBed) ~= nil then
						TriggerServerEvent("vrp_hospital:SendToBed", closestBed, false)
                    else
                        TriggerEvent("fplaytbank:notifications", "error", "Patul este ocupat.")
                    end
                end
            end
        end
        
        if not inRange then
            Citizen.Wait(1000)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(5000)
        SetClosestBed()
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(10)
        if beingtreatedhospital == true then
            Citizen.Wait(1800)
            treatedpercentage = treatedpercentage + 1
        else
            Citizen.Wait(1000)
        end
        
        if treatedpercentage == 100 then
            treatedpercentage = 0
            beingtreatedhospital = false
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(10)
        if beingtreated == true then
            Citizen.Wait(1800)
            treatedpercentage = treatedpercentage + 1
        else
            Citizen.Wait(1000)
        end
        if treatedpercentage == 100 then
            EndCheck()
            treatedpercentage = 0
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(10)
        if beingtreatedrespawn == true then
            Citizen.Wait(3000)
            treatedpercentage = treatedpercentage + 1
        else
            Citizen.Wait(1000)
        end
        if treatedpercentage == 100 then
            EndCheck()
            treatedpercentage = 0
        end
    end
end)

CreateThread(function()
    while true do
        local plyPos = GetEntityCoords(PlayerPedId(), false)
        if beingtreated or beingtreatedhospital or beingtreatedrespawn then
            if beingtreated == true or beingtreatedhospital == true then
                Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.3, tostring("~w~ Esti sub tratament... ~g~" .. treatedpercentage .. " %"))
            end
            if beingtreatedrespawn == true then
                Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.3, tostring("~w~ Esti sub tratament... ~g~" .. treatedpercentage .. " %"))
                Draw3DText2(plyPos.x, plyPos.y, plyPos.z + 0.2, tostring("~w~ Ranile tare sunt destul de grave, o sa dureze mai mult timp"))
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(1)
    end
end)


CreateThread(function()
    while true do
        Citizen.Wait(7)
        
        if isInHospitalBed and canLeaveBed then
            local pos = GetEntityCoords(PlayerPedId())
            Draw3DText2(pos.x, pos.y, pos.z, "~g~E~w~ - Ridica-te din pat..")
            if IsControlJustReleased(0, Keys["E"]) then
                LeaveBed()
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        pos = GetEntityCoords(PlayerPedId())
    end
end)

Citizen.CreateThread(function()
    local ticks = 1000
    while true do
        -- Citizen.Wait(1)
        Wait(ticks)
        if HCheckIn then
            ticks = 4
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
            EnableControlAction(0, 2, true)
        end
    end
end)

function HospitalCheck(tx, ty, tz)
    local ped = PlayerPedId()
    local player = PlayerPedId()
    local ad = "amb@lo_res_idles@"
    IsCheckingUp = true
    RequestAnimDict(ad)
    SetEntityCoordsNoOffset(ped, tx, ty, tz, false, false, false, true)
    SetEntityHeading(ped, 142.97)
    TaskPlayAnim(player, ad, "world_human_bum_slumped_left_lo_res_base", 5.0, 1.0, -1, 33, 0, 0, 0, 0)
    beingtreated = true
end

function EndCheck()
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    if not beingtreated and beingtreatedrespawn then
        SetEntityCoordsNoOffset(ped, -790.48962402344, -1220.8354492188, 8.311695098877, false, false, false, true)
    end
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(ped, true)
    FreezeEntityPosition(ped, false)
    IsCheckingUp = false
    SetEntityHealth(PlayerPedId(), 200)
    beingtreated = false
    beingtreatedrespawn = false
    Citizen.Wait(10)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsCheckingUp then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, Keys["W"], true)
            DisableControlAction(0, Keys["A"], true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 30, true)
            
            DisableControlAction(0, Keys["R"], true)
            DisableControlAction(0, Keys["SPACE"], true)
            DisableControlAction(0, Keys["Q"], true)
            DisableControlAction(0, Keys["TAB"], true)
            DisableControlAction(0, Keys["F"], true)
            
            DisableControlAction(0, Keys["F1"], true)
            DisableControlAction(0, Keys["F2"], true)
            DisableControlAction(0, Keys["F3"], true)
            DisableControlAction(0, Keys["F6"], true)
            
            DisableControlAction(0, Keys["V"], true)
            DisableControlAction(0, Keys["C"], true)
            DisableControlAction(0, Keys["X"], true)
            DisableControlAction(2, Keys["P"], true)
            
            DisableControlAction(0, 59, true)
            DisableControlAction(0, 71, true)
            DisableControlAction(0, 72, true)
            
            DisableControlAction(2, Keys["LEFTCTRL"], true)
            
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 143, true)
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            
            if not IsEntityPlayingAnim(PlayerPedId(), "amb@lo_res_idles@", "world_human_bum_slumped_left_lo_res_base", 3) then
                TaskPlayAnim(PlayerPedId(), "amb@lo_res_idles@", "world_human_bum_slumped_left_lo_res_base", 5.0, 1.0, -1, 33, 0, 0, 0, 0)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        
        if IsInABed then
            DisableControlAction(0, 1, true)-- Disable pan
            DisableControlAction(0, 2, true)-- Disable tilt
            DisableControlAction(0, 24, true)-- Attack
            DisableControlAction(0, 257, true)-- Attack 2
            DisableControlAction(0, 25, true)-- Aim
            DisableControlAction(0, 263, true)-- Melee Attack 1
            DisableControlAction(0, Keys["W"], true)-- W
            DisableControlAction(0, Keys["A"], true)-- A
            DisableControlAction(0, 31, true)-- S (fault in Keys table!)
            DisableControlAction(0, 30, true)-- D (fault in Keys table!)
            
            DisableControlAction(0, Keys["R"], true)-- Reload
            DisableControlAction(0, Keys["Q"], true)-- Cover
            DisableControlAction(0, Keys["TAB"], true)-- Select Weapon
            DisableControlAction(0, Keys["F"], true)-- Also 'enter'?
            
            DisableControlAction(0, Keys["F2"], true)-- Inventory
            DisableControlAction(0, Keys["F3"], true)-- Animations
            DisableControlAction(0, Keys["F6"], true)-- Job
            
            DisableControlAction(0, Keys["V"], true)-- Disable changing view
            DisableControlAction(0, Keys["C"], true)-- Disable looking behind
            DisableControlAction(0, Keys["X"], true)-- Disable clearing animation
            DisableControlAction(2, Keys["P"], true)-- Disable pause screen
            
            DisableControlAction(0, 59, true)-- Disable steering in vehicle
            DisableControlAction(0, 71, true)-- Disable driving forward in vehicle
            DisableControlAction(0, 72, true)-- Disable reversing in vehicle
            
            DisableControlAction(2, Keys["LEFTCTRL"], true)-- Disable going stealth
            
            DisableControlAction(0, 47, true)-- Disable weapon
            DisableControlAction(0, 264, true)-- Disable melee
            DisableControlAction(0, 257, true)-- Disable melee
            DisableControlAction(0, 140, true)-- Disable melee
            DisableControlAction(0, 141, true)-- Disable melee
            DisableControlAction(0, 142, true)-- Disable melee
            DisableControlAction(0, 143, true)-- Disable melee
            DisableControlAction(0, 75, true)-- Disable exit vehicle
            DisableControlAction(27, 75, true)-- Disable exit vehicle
            
            if IsEntityPlayingAnim(PlayerPedId(), "amb@lo_res_idles@", "world_human_bum_slumped_left_lo_res_base", 3) ~= 1 then
                TaskPlayAnim(PlayerPedId(), "amb@lo_res_idles@", "world_human_bum_slumped_left_lo_res_base", 5.0, 1.0, -1, 33, 0, 0, 0, 0)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function GetAvailableBed(bedId)
    local retval = nil
    if bedId == nil then
        for k, v in pairs(bedsLocations) do
            if not bedsLocations[k].taken then
                retval = k
            end
        end
    else
        if not bedsLocations[bedId].taken then
            retval = bedId
        end
    end
    return retval
end

function SetClosestBed()
    local current = nil
    local dist = nil
    for k, _ in pairs(bedsLocations) do
        if current ~= nil then
            if #(vector3(pos.x, pos.y, pos.z) - vector3(bedsLocations[k].x, bedsLocations[k].y, bedsLocations[k].z)) < dist then
                current = k
                dist = #(vector3(pos.x, pos.y, pos.z) - vector3(bedsLocations[k].x, bedsLocations[k].y, bedsLocations[k].z))
            end
        else
            dist = #(vector3(pos.x, pos.y, pos.z) - vector3(bedsLocations[k].x, bedsLocations[k].y, bedsLocations[k].z))
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

function SetBedCam()
    isInHospitalBed = true
    canLeaveBed = false
    
    DoScreenFadeOut(1000)
    
    while not IsScreenFadedOut() do
        Citizen.Wait(100)
    end
    
    if IsPedDeadOrDying(PlayerPedId()) then
        local playerPos = GetEntityCoords(PlayerPedId(), true)
        NetworkResurrectLocalPlayer(playerPos, true, true, false)
    end
    
    bedObject = GetClosestObjectOfType(bedOccupyingData.x, bedOccupyingData.y, bedOccupyingData.z, 1.0, bedOccupyingData.model, false, false, false)
    FreezeEntityPosition(bedObject, true)
    
    SetEntityCoords(PlayerPedId(), bedOccupyingData.x, bedOccupyingData.y, bedOccupyingData.z + 0.02)
    Citizen.Wait(500)
    FreezeEntityPosition(PlayerPedId(), true)
    
    loadAnimDict(inBedDict)
    
    TaskPlayAnim(PlayerPedId(), inBedDict, inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
    SetEntityHeading(PlayerPedId(), bedOccupyingData.h)
    
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 1.0, 1.0, true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -45.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
    
    DoScreenFadeIn(1000)
    
    Citizen.Wait(1000)
    FreezeEntityPosition(PlayerPedId(), true)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end
    
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityInvincible(PlayerPedId(), false)
    SetEntityHeading(PlayerPedId(), bedOccupyingData.h + 90)
    TaskPlayAnim(PlayerPedId(), getOutDict, getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Citizen.Wait(4000)
    ClearPedTasks(PlayerPedId())
	TriggerServerEvent("vrp_hospital:LeaveBed", bedOccupying)
    FreezeEntityPosition(bedObject, true)
    
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)
    
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    isInHospitalBed = false
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function Draw3DText2(x, y, z, text, size)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 100)
end

function SendBed(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    Citizen.CreateThread(function()
        Citizen.Wait(5)
        if isRevive then
            TriggerEvent("fplaytbank:notifications", "success", "Ai fost internat si un doctor se va ocupa sa te vindece.")
            Citizen.Wait(injuredrecovertimer)
            local ped = PlayerPedId()
            if isInHospitalBed then
                loadAnimDict(inBedDict)
                TaskPlayAnim(ped, inBedDict, inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
                SetEntityInvincible(ped, true)
                canLeaveBed = true
            end
            SetEntityMaxHealth(ped, 200)
            SetEntityHealth(ped, 200)
            ClearPedBloodDamage(ped)
            SetPlayerSprint(PlayerId(), true)
        else
            canLeaveBed = true
        end
    end)
end

function SetBed(id, isTaken)
    bedsLocations[id].taken = isTaken
end

RegisterNetEvent("vrp_hospital:SendBed", SendBed)
RegisterNetEvent("vrp_hospital:SetBed", SetBed)